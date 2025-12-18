import json
import os
import subprocess
from typing import Any, Type

from pydantic import Field, HttpUrl, PostgresDsn
from pydantic_settings import (
    BaseSettings,
    PydanticBaseSettingsSource,
)

PROD = "prod"
DEV = "dev"


class SupabaseCliSettingsSource(PydanticBaseSettingsSource):
    def get_field_value(self, field, field_name):
        return super().get_field_value(field, field_name)

    def __call__(self) -> dict[str, Any]:
        if os.getenv("ENV") != DEV:
            return {}

        try:
            # コマンド実行
            result = subprocess.run(
                ["supabase", "status", "--output", "json"],
                capture_output=True,
                text=True,
                check=True,
                shell=True,
            )

            raw_data = json.loads(result.stdout)

            # Windows対策: 0.0.0.0 を 127.0.0.1 に置換する
            def fix_host(url: Any) -> Any:
                if isinstance(url, str):
                    return url.replace("0.0.0.0", "127.0.0.1")
                return url

            # CLIのキー名を Settings のフィールド名にマッピング
            return {
                "DATABASE_URL": fix_host(raw_data.get("DB_URL")),
                "SUPABASE_URL": fix_host(raw_data.get("API_URL")),
                "SUPABASE_PUBLISHABLE_KEY": raw_data.get("PUBLISHABLE_KEY"),
                "SUPABASE_SECRET_KEY": raw_data.get("SECRET_KEY"),
                "SUPABASE_SERVICE_ROLE_KEY": raw_data.get("SERVICE_ROLE_KEY"),
                "SUPABASE_JWT_SECRET": raw_data.get("JWT_SECRET"),
            }
        except Exception as e:
            print(f"Supabase CLI settings source error: {e}")
            return {}


class Settings(BaseSettings):
    env: str = Field(PROD, validation_alias="ENV")

    database_url: PostgresDsn = Field(..., validation_alias="DATABASE_URL")
    supabase_url: HttpUrl = Field(..., validation_alias="SUPABASE_URL")
    supabase_publishable_key: str = Field(
        ..., validation_alias="SUPABASE_PUBLISHABLE_KEY"
    )
    supabase_secret_key: str = Field(..., validation_alias="SUPABASE_SECRET_KEY")
    supabase_service_role_key: str = Field(
        ..., validation_alias="SUPABASE_SERVICE_ROLE_KEY"
    )
    supabase_jwt_secret: str = Field(..., validation_alias="SUPABASE_JWT_SECRET")

    @classmethod
    def settings_customise_sources(
        cls,
        settings_cls: Type[BaseSettings],
        init_settings: PydanticBaseSettingsSource,
        env_settings: PydanticBaseSettingsSource,
        dotenv_settings: PydanticBaseSettingsSource,
        file_secret_settings: PydanticBaseSettingsSource
    ) -> tuple[PydanticBaseSettingsSource, ...]:
        return (
            init_settings,
            env_settings,
            SupabaseCliSettingsSource(settings_cls),
            dotenv_settings,
            file_secret_settings,
        )
