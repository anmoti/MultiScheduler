#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit

# 仮想環境の有効化
source ./.venv/bin/activate

# 環境変数の設定
export ENV="dev"

# データベースのマイグレーション
alembic upgrade head

# uvicornの起動
uvicorn app.main:app --reload-dir app --reload
