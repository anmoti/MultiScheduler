import json
import sys
from pathlib import Path


current_dir = Path(__file__).parent
sys.path.append(str(current_dir))

from app.main import app  # noqa: E402


if __name__ == "__main__":
    output_path = current_dir / "openapi.json"

    with output_path.open("w") as f:
        openapi_json = app.openapi()
        f.write(json.dumps(openapi_json, indent=2))

    print(f"OpenAPI schema has been generated at: {output_path}")
