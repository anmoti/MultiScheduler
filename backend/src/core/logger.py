import logging
import math
import re
import time
from typing import Any

import structlog
from structlog.types import Processor, EventDict

import urllib
from asgi_correlation_id import correlation_id
from starlette.applications import ASGIApp
from starlette.responses import JSONResponse
from starlette.types import Receive, Scope, Send

from core.config import settings

EVENT = "event"
EXTRA = "extra"
REQUEST_ID = "request_id"


def drop_key_processor(key: str) -> Processor:
    """
    指定したキーを event_dict から削除するプロセッサを生成します。
    """

    def processor(_, __, event_dict: EventDict):
        event_dict.pop(key, None)

        return event_dict

    return processor


def request_id_shortener_processor(_, __, event_dict: EventDict):
    """
    REQUEST_ID を短縮して表示するプロセッサ
    """
    request_id = event_dict.pop(REQUEST_ID, None)
    if request_id:
        event_dict["req_id"] = str(request_id)[:8]
    return event_dict


def named_placeholder_processor(_, __, event_dict: EventDict):
    """
    {key} 形式のプレースホルダーを値に置換
    """

    event = str(event_dict.get(EVENT, ""))
    extra = event_dict.get(EXTRA, {})
    if not isinstance(extra, dict):
        extra = {}

    pattern = r"{([^}]+)}"
    matches = re.findall(pattern, event)

    for key in matches:
        value = None

        # 直接キーを探す
        if key in event_dict:
            value = str(event_dict.pop(key))
        elif key in extra:
            value = str(extra.pop(key))
        else:
            # ネストされたキーを探す
            if "." in key:
                parts = key.split(".")
                current = extra
                try:
                    for part in parts[:-1]:
                        current = current[part]
                    value = str(current.pop(parts[-1]))
                except (KeyError, TypeError):
                    continue

        if value is not None:
            event = event.replace(f"{{{key}}}", value)

    event_dict[EVENT] = event
    return event_dict


def setup_logging() -> None:
    """
    structlog の動作（プロセッサ、レンダラー）を定義し、
    標準の Python logging モジュールと統合します。
    """

    shared_processors: list[Processor] = [
        structlog.contextvars.merge_contextvars,
        structlog.stdlib.add_logger_name,
        structlog.stdlib.add_log_level,
        structlog.processors.StackInfoRenderer(),
    ]

    log_renderer: Processor

    if settings.LOG_JSON_FORMAT:
        # 本番用
        shared_processors += [
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.format_exc_info,
            structlog.processors.dict_tracebacks,
        ]
        log_renderer = structlog.processors.JSONRenderer()
    else:
        # 開発用
        shared_processors += [
            structlog.processors.TimeStamper(fmt="%y-%m-%d %H:%M:%S.%f"),
            request_id_shortener_processor,
            named_placeholder_processor,
            drop_key_processor(EXTRA),
        ]
        log_renderer = structlog.dev.ConsoleRenderer(
            exception_formatter=structlog.dev.RichTracebackFormatter()
        )

    structlog.configure(
        processors=shared_processors
        + [
            structlog.stdlib.ProcessorFormatter.wrap_for_formatter,
        ],
        logger_factory=structlog.stdlib.LoggerFactory(),
        cache_logger_on_first_use=True,
    )

    # 標準 logging を structlog に変換するためのフォーマッタ
    formatter = structlog.stdlib.ProcessorFormatter(
        foreign_pre_chain=shared_processors,
        processors=[
            structlog.stdlib.ProcessorFormatter.remove_processors_meta,
            log_renderer,
        ],
    )

    # ルートロガーの設定：すべてのログを structlog のフォーマッタ経由で出力させる
    handler = logging.StreamHandler()
    handler.setFormatter(formatter)
    root_logger = logging.getLogger()
    root_logger.addHandler(handler)
    root_logger.setLevel(settings.LOG_LEVEL.upper())

    # Uvicorn の標準ロガーをクリアし、ルートロガーに伝播させる
    for _log in ["uvicorn", "uvicorn.error"]:
        logging.getLogger(_log).handlers.clear()
        logging.getLogger(_log).propagate = True

    # アクセスログはミドルウェアで自前出力するため、元の Uvicorn アクセスログは消音
    logging.getLogger("uvicorn.access").handlers.clear()
    logging.getLogger("uvicorn.access").propagate = False


setup_logging()


class FastAPIStructLogger:
    """
    structlog を使いやすくするための薄いラッパーです。
    contextvars を利用して、リクエストごとのコンテキスト変数を管理します。
    """

    def __init__(self, log_name=settings.LOG_NAME):
        self.logger = structlog.stdlib.get_logger(log_name)

    def bind(self, **new_values: Any):
        """ログにコンテキスト情報をバインドします。"""
        structlog.contextvars.bind_contextvars(**new_values)

    def unbind(self, *keys: str):
        """指定したキーのバインドを解除します。"""
        structlog.contextvars.unbind_contextvars(*keys)

    def debug(self, event: str, **kw: Any):
        self.logger.debug(event, **kw)

    def info(self, event: str, **kw: Any):
        self.logger.info(event, **kw)

    def warning(self, event: str, **kw: Any):
        self.logger.warning(event, **kw)

    def error(self, event: str, **kw: Any):
        self.logger.error(event, **kw)

    def exception(self, event: str, **kw: Any):
        self.logger.exception(event, **kw)


class StructLogMiddleware:
    """
    各リクエストの開始・終了時に動作するミドルウェアです。
    - Request ID (correlation_id) の取得とバインド
    - 未処理例外のキャッチと構造化ログへの出力
    - アクセスログ（URL, ステータスコード, 処理時間など）の出力
    """

    def __init__(self, app: ASGIApp):
        self.app = app
        self.app_logger = structlog.stdlib.get_logger(settings.LOG_NAME)
        self.access_logger = structlog.stdlib.get_logger(settings.LOG_ACCESS_NAME)

    async def __call__(self, scope: Scope, receive: Receive, send: Send) -> None:
        if scope["type"] != "http":
            await self.app(scope, receive, send)
            return

        # リクエストごとのコンテキストをリセット
        structlog.contextvars.clear_contextvars()

        # Request ID を取得してログに紐付け
        req_id = correlation_id.get()
        structlog.contextvars.bind_contextvars(request_id=req_id)

        start_time_ns = time.perf_counter_ns()
        status_code = 500  # デフォルト

        # ステータスコードをキャプチャするための内部関数
        async def send_wrapper(message):
            nonlocal status_code
            if message["type"] == "http.response.start":
                status_code = message["status"]
            await send(message)

        try:
            await self.app(scope, receive, send_wrapper)
        except Exception as e:
            # 例外が発生した場合、詳細な情報をログに記録
            self.app_logger.exception(
                "Unhandled exception caught by middleware",
                exception_class=e.__class__.__name__,
                exc_info=e,
                stack_info=settings.LOG_INCLUDE_STACK,
            )

            # エラーレスポンスを生成して返す
            response = JSONResponse(
                status_code=500,
                content={
                    "error": "Internal Server Error",
                    "message": "Unexpected error occurred.",
                },
            )
            await response(scope, receive, send)

        finally:
            # 処理時間の計算
            process_time_ns = time.perf_counter_ns() - start_time_ns
            process_time_ms: str = str(math.floor(process_time_ns / 1_000_000))
            if process_time_ms == "0":
                process_time_ms = "<1"

            client_host, client_port = scope["client"]
            method = scope["method"]
            path = scope["path"]
            http_version = scope["http_version"]
            url = get_path_with_query_string(scope)

            # アクセスログを構造化データとして出力
            self.access_logger.info(
                f"{{client.ip}}@{{req_id}} {{http.method}} {{http.status_code}} {path} {process_time_ms}ms",
                extra={
                    "http": {
                        "url": str(url),
                        "method": method,
                        "status_code": status_code,
                        "version": http_version,
                    },
                    "client": {"ip": client_host, "port": client_port},
                    "duration_ns": process_time_ns,
                },
            )


def get_path_with_query_string(scope: Scope) -> str:
    path_with_query_string = urllib.parse.quote(scope["path"])
    if scope["query_string"]:
        path_with_query_string = "{}?{}".format(
            path_with_query_string, scope["query_string"].decode("ascii")
        )
    return path_with_query_string
