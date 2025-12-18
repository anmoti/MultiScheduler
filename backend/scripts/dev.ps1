.\.venv\Scripts\activate.ps1

$env:ENV="dev"

uvicorn main:app --app-dir src --reload-dir src --reload
