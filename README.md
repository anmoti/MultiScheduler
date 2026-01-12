# MultiScheduler

## 技術スタック

### フロントエンド

- Flutter(Android, Windows, Linux, Web)
iOSはAppleDeveloperProgramが高いため未対応
macOSは持っていないため未対応

### バックエンド

- FastAPI
docker(k8s)でデプロイする。

- Supabase (Authentication, Database[PostgreSQL])

## 環境構築

VSCodeのワークスペースを推奨
Workspace: `/MultiScheduler.code-workspace`

以下のツールをインストールし、PATHを通す。
- uv
- Flutter(fvm)
- Supabase CLI
- Docker (Podman)
   Supabaseの起動に使用(Podmanの場合はデーモン閣下を召喚しておくこと)

依存関係をインストールする。

```
uv sync
```

### Supabaseの起動

以下のコマンドを `/` で実行する。

```bash
supabase start
```

### バックエンドの起動

以下のコマンドを `/backend` で実行する。

```bash
./scripts/dev.ps1
# または
./scripts/dev.sh
```

### フロントエンドの起動

flutterのデバッグを実行する。

### データベースをマイグレーション

```bash
ENV=dev uv run alembic revision --autogenerate -m "<message>"

ENV=dev uv run alembic upgrade head
```

### APIクライアントのコード生成

以下のコマンドを `/backend` で実行する。

```bash
./scripts/generate_openapi.sh
```

```
OpenAPI schema has been generated at: /home/anmoti/src/github.com/anmoti/MultiScheduler/backend/scripts/openapi.json
Building package executable...
Built swagger_parser:swagger_parser.

┃  ____ _ _ _ ____ ____ ____ ____ ____     ___  ____ ____ ____ ____ ____
┃  [__  | | | |__| | __ | __ |___ |__/     |__] |__| |__/ [__  |___ |__/
┃  ___] |_|_| |  | |__] |__] |___ |  \ ___ |    |  | |  \ ___] |___ |  \
┃

Generate...
> openapi v0.1.0:
    1 rest clients, 15 requests, 10 data classes.
    13 files with 425 lines of code.
    Success (0.017 seconds)

The generation was completed successfully. You can run the generation using build_runner.
Building package executable...
Built build_runner:build_runner.
8s freezed on 33 inputs: 10 output, 23 no-op; spent 6s analyzing, 1s resolving
2s json_serializable on 66 inputs: 23 skipped, 10 output, 33 no-op; spent 2s analyzing
0s retrofit_generator on 66 inputs: 23 skipped, 1 output, 42 no-op
0s go_router_builder on 66 inputs: 23 skipped, 1 output, 42 no-op
0s source_gen:combining_builder on 66 inputs: 23 skipped, 12 output, 31 no-op
Built with build_runner/jit in 11s; wrote 34 outputs.
```
