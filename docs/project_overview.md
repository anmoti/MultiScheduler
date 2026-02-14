# MultiScheduler Project Overview

## プロジェクト概要

**MultiScheduler** は、Flutterを用いたクロスプラットフォーム（Android, Windows, Linux, Web）のスケジュール管理アプリケーションと、FastAPIとSupabaseを用いたバックエンドAPIから構成されるシステムです。

### 主な特徴

*   **クロスプラットフォーム**: Flutterにより、Android, Windows, Linux, Web の各プラットフォームで動作します。（iOS, macOSは現在未対応）
*   **バックエンド**: PythonのFastAPIフレームワークを使用した高性能なREST API。
*   **インフラ**:
    *   **Supabase**: 認証（Authentication）およびデータベース（PostgreSQL）として利用。
    *   **Docker**: Kubernetes (k8s) でのデプロイを想定したコンテナ構成。

## 技術スタック

### フロントエンド (Flutter)
*   **フレームワーク**: Flutter
*   **言語**: Dart
*   **パッケージ管理**: `pubspec.yaml`
*   **主なライブラリ**:
    *   `go_router`: ルーティング管理
    *   `dio`: HTTPクライアント
    *   `retrofit`: APIクライアント生成
    *   `hooks_riverpod` (推定): 状態管理
    *   `freezed`, `json_serializable`: コード生成

### バックエンド (Python)
*   **フレームワーク**: FastAPI
*   **言語**: Python (3.13以上)
*   **パッケージ管理**: `uv` (`pyproject.toml`)
*   **データベース/ORM**: Supabase (PostgreSQL), SQLModel, Alembic (マイグレーション)
*   **その他**: `pydantic`, `structlog`

## フォルダ構成

プロジェクトルート `/` 配下の主要なディレクトリ構成は以下の通りです。

### 1. `backend/`
FastAPIによるバックエンドサーバーのソースコードです。

*   **`app/`**: アプリケーション本体
    *   `api/`, `routers/`: APIエンドポイント定義 (`auth`, `calendar`, `user` 等)
    *   `models/`: データベースモデル、Pydanticスキーマ
    *   `core/`: 設定、ロギング、ミドルウェア
*   **`scripts/`**: 開発・運用スクリプト
    *   `dev.ps1`, `dev.sh`: サーバー起動スクリプト
    *   `generate_openapi.sh`: OpenAPIスキーマ生成スクリプト
*   **`tests/`**: テストコード (存在する場合)
*   `pyproject.toml`: 依存関係定義
*   `alembic.ini`: DBマイグレーション設定

### 2. `flutter/`
Flutterによるクライアントアプリケーションのソースコードです。

*   **`lib/`**: Dartソースコード
    *   `api/generated/`: OpenAPIから自動生成されたAPIクライアントコード
    *   `router/`: 画面遷移設定
    *   その他、UIコンポーネントやビジネスロジック
*   **`android/`, `linux/`, `web/`, `windows/`**: プラットフォーム固有のビルド設定
*   `pubspec.yaml`: 依存関係定義
*   `analysis_options.yaml`:静的解析設定

### 3. `supabase/`
Supabase関連の設定ファイル（ローカル開発環境設定、マイグレーションファイル等）。

## 開発環境構築

推奨環境: VSCode (Workspace: `/MultiScheduler.code-workspace`)

### 必須ツール
*   uv (Pythonパッケージ管理)
*   Flutter (fvm推奨)
*   Supabase CLI
*   Docker (Podman)

### 起動方法
1.  **依存関係のインストール**: `uv sync`, `flutter pub get`
2.  **Supabase起動**: `supabase start` (ルートディレクトリで実行)
3.  **バックエンド起動**: `backend/scripts/dev.sh` (または `dev.ps1`)
4.  **フロントエンド起動**: Flutterデバッグ実行

### コード生成
バックエンドのOpenAPIスキーマ変更時は、`backend/scripts/generate_openapi.sh` を実行して `openapi.json` を更新し、Flutter側の `build_runner` でクライアントコードを再生成します。
