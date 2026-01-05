import json
import os
import subprocess
from typing import Any

from pydantic import Field, HttpUrl, PostgresDsn, field_validator
from pydantic.fields import FieldInfo
from pydantic_settings import (
    BaseSettings,
    PydanticBaseSettingsSource,
)


PROD = "prod"
DEV = "dev"


class SupabaseCliSettingsSource(PydanticBaseSettingsSource):
    def __init__(self, settings_cls: type[BaseSettings]):
        super().__init__(settings_cls)
        self._cached_data: dict[str, Any] | None = None

    def __call__(self) -> dict[str, Any]:
        if self._cached_data is not None:
            return self._cached_data

        if os.getenv("ENV") != DEV:
            self._cached_data = {}
            return self._cached_data

        try:
            # コマンド実行
            result = subprocess.run(
                "pnpm dlx supabase status --output json",
                capture_output=True,
                text=True,
                check=True,
                shell=True,
            )

            raw_data = json.loads(result.stdout)

            # CLIのキー名を Settings のフィールド名にマッピング
            self._cached_data = {
                "DATABASE_URL": raw_data.get("DB_URL"),
                "SUPABASE_URL": raw_data.get("API_URL"),
                "SUPABASE_PUBLISHABLE_KEY": raw_data.get("PUBLISHABLE_KEY"),
                "SUPABASE_SECRET_KEY": raw_data.get("SECRET_KEY"),
                "SUPABASE_SERVICE_ROLE_KEY": raw_data.get("SERVICE_ROLE_KEY"),
                "SUPABASE_JWT_SECRET": raw_data.get("JWT_SECRET"),
            }

            return self._cached_data
        except Exception as e:
            print(f"Supabase CLI settings source error: {e}")
            self._cached_data = {}

            return self._cached_data

    def get_field_value(self, _field: FieldInfo, field_name: str) -> Any:
        """指定されたフィールドの値を取得"""
        settings_data = self()

        return settings_data.get(field_name)


class Settings(BaseSettings):
    env: str = Field(PROD, validation_alias="ENV")

    LOG_LEVEL: str = "DEBUG"
    LOG_JSON_FORMAT: bool = False
    LOG_NAME: str = "app.logs"
    LOG_ACCESS_NAME: str = "app.access_logs"
    LOG_INCLUDE_STACK: bool = False
    DATABASE_URL: PostgresDsn = Field(...)
    SUPABASE_URL: HttpUrl = Field(...)
    SUPABASE_PUBLISHABLE_KEY: str = Field(...)
    SUPABASE_SECRET_KEY: str = Field(...)
    SUPABASE_SERVICE_ROLE_KEY: str = Field(...)
    SUPABASE_JWT_SECRET: str = Field(...)

    @field_validator("DATABASE_URL", mode="before")
    @classmethod
    def fix_database_protocol(cls, v: Any) -> Any:
        """psycopgに対応"""
        if isinstance(v, str) and v.startswith("postgresql://"):
            v = v.replace("postgresql://", "postgresql+psycopg://", 1)
        return v

    @classmethod
    def settings_customise_sources(
        cls,
        settings_cls: type[BaseSettings],
        init_settings: PydanticBaseSettingsSource,
        env_settings: PydanticBaseSettingsSource,
        dotenv_settings: PydanticBaseSettingsSource,
        file_secret_settings: PydanticBaseSettingsSource,
    ) -> tuple[PydanticBaseSettingsSource, ...]:
        return (
            init_settings,
            env_settings,
            SupabaseCliSettingsSource(settings_cls),
            dotenv_settings,
            file_secret_settings,
        )


settings = Settings()

__all__ = ["settings"]
