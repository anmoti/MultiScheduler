from uuid import UUID

from sqlmodel import Field

from app.models import SQLModel
from app.models.mixins import TimestampMixin


class UserCalendarLink(TimestampMixin, SQLModel, table=True):
    __tablename__ = "user_calendar_link"

    user_id: UUID = Field(foreign_key="user.id", primary_key=True)
    calendar_id: UUID = Field(foreign_key="calendar.id", primary_key=True)
