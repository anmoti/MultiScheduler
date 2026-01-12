from typing import TYPE_CHECKING
from uuid import UUID, uuid4

from sqlmodel import Field, Relationship

from app.models import SQLModel
from app.models.links import UserCalendarLink


if TYPE_CHECKING:
    from app.models.user import User


class Calendar(SQLModel, table=True):
    id: UUID = Field(primary_key=True, default_factory=uuid4)
    name: str
    created_by: UUID = Field(foreign_key="user.id")

    users: list["User"] = Relationship(
        back_populates="calendars", link_model=UserCalendarLink
    )
