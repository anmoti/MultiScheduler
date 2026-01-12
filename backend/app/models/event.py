from datetime import datetime
from uuid import UUID, uuid4

from sqlalchemy import TEXT, Column
from sqlmodel import Field

from app.models import SQLModel
from app.models.mixins import CreatedByUserMixin, TimestampMixin


class Event(TimestampMixin, CreatedByUserMixin, SQLModel, table=True):
    __tablename__ = "event"

    id: UUID = Field(primary_key=True, default_factory=uuid4)
    calendar_id: UUID = Field(foreign_key="calendar.id")

    title: str = Field(index=True)
    description: str | None = Field(default=None, sa_column=Column(TEXT))

    start_at: datetime | None = Field(default=None, index=True)
    end_at: datetime | None = Field(default=None, index=True)
    actual_start_at: datetime | None = Field(default=None, index=True)
    actual_end_at: datetime | None = Field(default=None, index=True)

    is_cancelled: bool = Field(default=False, index=True)
