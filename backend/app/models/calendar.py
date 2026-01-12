from typing import TYPE_CHECKING
from uuid import UUID, uuid4

from sqlmodel import Field, Relationship

from app.models import SQLModel
from app.models.links import UserCalendarLink
from app.models.mixins import CreatedByUserMixin, TimestampMixin


if TYPE_CHECKING:
    from app.models.user import User


class Calendar(TimestampMixin, CreatedByUserMixin, SQLModel, table=True):
    __tablename__ = "calendar"

    id: UUID = Field(primary_key=True, default_factory=uuid4)
    name: str

    users: list["User"] = Relationship(
        back_populates="calendars", link_model=UserCalendarLink
    )
