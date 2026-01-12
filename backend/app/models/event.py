from datetime import datetime
from typing import TYPE_CHECKING
from uuid import UUID, uuid4

from sqlalchemy import TEXT, Column
from sqlmodel import Field, Relationship

from app.models import SQLModel
from app.models.mixins import CreatedByUserMixin, TimestampMixin


if TYPE_CHECKING:
    from app.models.calendar import Calendar


class EventBase(SQLModel):
    title: str = Field(index=True, min_length=1)
    description: str | None = Field(default=None, sa_column=Column(TEXT))

    start_at: datetime | None = Field(default=None, index=True)
    end_at: datetime | None = Field(default=None, index=True)
    actual_start_at: datetime | None = Field(default=None, index=True)
    actual_end_at: datetime | None = Field(default=None, index=True)

    is_cancelled: bool = Field(default=False, index=True)


class EventCreate(EventBase):
    pass


class EventUpdate(SQLModel):
    title: str | None = Field(default=None, min_length=1)
    description: str | None = Field(default=None)

    start_at: datetime | None = Field(default=None)
    end_at: datetime | None = Field(default=None)
    actual_start_at: datetime | None = Field(default=None)
    actual_end_at: datetime | None = Field(default=None)

    is_cancelled: bool | None = Field(default=None)


class EventPublic(EventBase):
    id: UUID
    calendar_id: UUID

    created_at: datetime
    updated_at: datetime


class Event(TimestampMixin, CreatedByUserMixin, EventBase, table=True):
    __tablename__ = "event"

    id: UUID = Field(primary_key=True, default_factory=uuid4)
    calendar_id: UUID = Field(foreign_key="calendar.id")

    calendar: "Calendar" = Relationship(back_populates="events")
