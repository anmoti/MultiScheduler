from enum import Enum
from typing import ClassVar, Literal

from fastapi import status
from fastapi.responses import JSONResponse
from pydantic import BaseModel


# https://supabase.com/docs/guides/auth/debugging/error-codes
class SupabaseErrorCode(str, Enum):
    INVALID_CREDENTIALS = "invalid_credentials"
    USER_ALREADY_EXISTS = "user_already_exists"
    REFRESH_TOKEN_NOT_FOUND = "refresh_token_not_found"


class Status(str, Enum):
    OK = "OK"

    NOT_AUTHENTICATED = "NOT_AUTHENTICATED"
    USERNAME_ALREADY_EXISTS = "USERNAME_ALREADY_EXISTS"
    USER_NOT_FOUND = "USER_NOT_FOUND"
    USER_ALREADY_EXISTS = "USER_ALREADY_EXISTS"
    INVALID_CREDENTIALS = "INVALID_CREDENTIALS"
    REFRESH_TOKEN_NOT_FOUND = "REFRESH_TOKEN_NOT_FOUND"

    CALENDAR_NOT_FOUND = "CALENDAR_NOT_FOUND"

    EVENT_NOT_FOUND = "EVENT_NOT_FOUND"


class MessageResp(BaseModel):
    status_code: ClassVar[int] = 400
    status: Status
    message: str | None = None

    def as_response(self) -> JSONResponse:
        return JSONResponse(
            status_code=self.status_code,
            content=self.model_dump(),
        )


class MessageRespError(Exception):
    message_resp: MessageResp

    def __init__(self, message_resp: MessageResp):
        super().__init__()
        self.message_resp = message_resp


class OKResp(MessageResp):
    status_code = status.HTTP_200_OK
    status: Literal[Status.OK] = Status.OK
    message: str | None = None


class NotAuthenticatedError(MessageResp):
    status_code = status.HTTP_401_UNAUTHORIZED
    status: Literal[Status.NOT_AUTHENTICATED] = Status.NOT_AUTHENTICATED
    message: str = "認証されていません。"


class UsernameAlreadyExistsError(MessageResp):
    status_code = status.HTTP_409_CONFLICT
    status: Literal[Status.USERNAME_ALREADY_EXISTS] = Status.USERNAME_ALREADY_EXISTS
    message: str = "ユーザー名は既に存在します。"


class UserNotFoundError(MessageResp):
    status_code = status.HTTP_404_NOT_FOUND
    status: Literal[Status.USER_NOT_FOUND] = Status.USER_NOT_FOUND
    message: str = "ユーザーが見つかりません。"
    user_id: str


class UserAlreadyExistsError(MessageResp):
    status_code = status.HTTP_409_CONFLICT
    status: Literal[Status.USER_ALREADY_EXISTS] = Status.USER_ALREADY_EXISTS
    message: str = "ユーザーは既に存在します。"


class InvalidCredentialsError(MessageResp):
    status_code = status.HTTP_401_UNAUTHORIZED
    status: Literal[Status.INVALID_CREDENTIALS] = Status.INVALID_CREDENTIALS
    message: str = "無効な認証情報です。"


class RefreshTokenNotFoundError(MessageResp):
    status_code = status.HTTP_401_UNAUTHORIZED
    status: Literal[Status.REFRESH_TOKEN_NOT_FOUND] = Status.REFRESH_TOKEN_NOT_FOUND
    message: str = "リフレッシュトークンが見つかりません。"


class CalendarNotFoundError(MessageResp):
    status_code = status.HTTP_404_NOT_FOUND
    status: Literal[Status.CALENDAR_NOT_FOUND] = Status.CALENDAR_NOT_FOUND
    message: str = "カレンダーが見つかりません。"
    calendar_id: str


class EventNotFoundError(MessageResp):
    status_code = status.HTTP_404_NOT_FOUND
    status: Literal[Status.EVENT_NOT_FOUND] = Status.EVENT_NOT_FOUND
    message: str = "イベントが見つかりません。"
    event_id: str
