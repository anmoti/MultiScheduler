from datetime import datetime
from typing import TYPE_CHECKING
from uuid import UUID, uuid4

from sqlmodel import Field, Relationship

from app.models import SQLModel
from app.models.links import UserCalendarLink
from app.models.mixins import CreatedByUserMixin, TimestampMixin


if TYPE_CHECKING:
    from app.models.event import Event
    from app.models.user import User


class CalendarBase(SQLModel):
    name: str = Field(min_length=1)


class CalendarCreate(CalendarBase):
    pass


class CalendarUpdate(SQLModel):
    name: str | None = Field(default=None, min_length=1)


class CalendarPublic(CalendarBase):
    id: UUID

    created_at: datetime
    updated_at: datetime


class Calendar(TimestampMixin, CreatedByUserMixin, CalendarBase, table=True):
    __tablename__ = "calendar"

    id: UUID = Field(primary_key=True, default_factory=uuid4)

    users: list["User"] = Relationship(
        back_populates="calendars", link_model=UserCalendarLink
    )
    events: list["Event"] = Relationship(back_populates="calendar")
