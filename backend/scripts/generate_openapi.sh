#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit

# 仮想環境の有効化
source ./.venv/bin/activate

# 環境変数の設定
export ENV="dev"

export PYTHONPATH=$PYTHONPATH:$(pwd)

python scripts/generate_openapi.py

cd ../flutter

dart run swagger_parser

fvm dart run build_runner build --delete-conflicting-outputs
