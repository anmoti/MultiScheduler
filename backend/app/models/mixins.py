from datetime import UTC, datetime
from uuid import UUID

from sqlmodel import Field

from app.models import SQLModel


def utc_now() -> datetime:
    return datetime.now(UTC)


class TimestampMixin(SQLModel):
    created_at: datetime = Field(default_factory=utc_now)
    updated_at: datetime = Field(
        default_factory=utc_now, sa_column_kwargs={"onupdate": utc_now}
    )


class CreatedByUserMixin(SQLModel):
    created_by: UUID = Field(foreign_key="user.id")
