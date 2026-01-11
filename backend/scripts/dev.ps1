.\.venv\Scripts\activate.ps1

$env:ENV="dev"

# データベースのマイグレーション
alembic upgrade head

# uvicornの起動
uvicorn app.main:app --reload-dir app --reload
