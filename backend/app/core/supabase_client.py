from collections.abc import Generator
from typing import Annotated

from fastapi import Depends
from supabase import Client, ClientOptions, create_client

from app.core.config import settings


def get_supabase_client() -> Client:
    """Supabaseクライアントのインスタンスを生成"""
    return create_client(
        supabase_url=str(settings.SUPABASE_URL),
        supabase_key=settings.SUPABASE_SERVICE_ROLE_KEY,
        options=ClientOptions(
            postgrest_client_timeout=20,
            storage_client_timeout=20,
            schema="private",
        ),
    )


supabase_client = get_supabase_client()


def get_supabase() -> Generator[Client]:
    yield supabase_client


SupabaseDep = Annotated[Client, Depends(get_supabase)]

__all__ = ["SupabaseDep"]
