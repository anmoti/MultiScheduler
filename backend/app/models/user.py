from uuid import UUID

from pydantic import field_validator
from sqlmodel import Field

from app.models import SQLModel


class UserBase(SQLModel):
    name: str = Field(
        unique=True,
        regex=r"^[a-z0-9_-]+$",
        min_length=4,
        max_length=20,
    )


class UserPublic(UserBase):
    id: UUID = Field(primary_key=True)

    @field_validator("name", mode="before")
    @classmethod
    def normalize_name(cls, v: str) -> str:
        if isinstance(v, str):
            return v.lower()
        return v


class UserPrivate(UserPublic):
    nickname: str


class User(UserPrivate, table=True):
    pass
