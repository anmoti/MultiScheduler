from typing import TYPE_CHECKING
from uuid import UUID

from pydantic import BaseModel, field_validator
from sqlmodel import Field, Relationship

from app.models import SQLModel
from app.models.links import UserCalendarLink
from app.models.mixins import TimestampMixin


if TYPE_CHECKING:
    from app.models.calendar import Calendar


class UserBase(SQLModel):
    name: str = Field(
        unique=True,
        regex=r"^[a-z0-9_-]+$",
        min_length=4,
        max_length=20,
    )

    @field_validator("name", mode="before")
    @classmethod
    def normalize_name(cls, v: str) -> str:
        if isinstance(v, str):
            return v.lower()
        return v


class UserCreate(UserBase):
    email: str
    password: str = Field(min_length=6, max_length=72)


class UserLogin(BaseModel):
    email: str
    password: str


class UserSession(BaseModel):
    user_id: UUID
    access_token: str
    refresh_token: str


class UserPublic(UserBase):
    id: UUID = Field(primary_key=True)


class UserPrivate(UserPublic):
    nickname: str


class User(UserPrivate, TimestampMixin, table=True):
    calendars: list["Calendar"] = Relationship(
        back_populates="users", link_model=UserCalendarLink
    )
