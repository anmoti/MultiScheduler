from typing import Annotated

from fastapi import Depends
from sqlmodel import select

from app.deps import SessionDep
from app.models.errors import EventNotFoundError, MessageRespError
from app.models.event import Event, EventCreate, EventUpdate
from app.services.calendar import CalendarServiceDep


class EventService:
    def __init__(self, session: SessionDep, calendar_service: CalendarServiceDep):
        self.session = session
        self.calendar_service = calendar_service

    def create_event(
        self, user_id: str, calendar_id: str, event_create: EventCreate
    ) -> Event:
        """イベントを作成"""
        event = Event.model_validate(
            event_create, update={"calendar_id": calendar_id, "created_by": user_id}
        )
        self.session.add(event)
        self.session.commit()
        self.session.refresh(event)
        return event

    def get_event(self, event_id: str, calendar_id: str) -> Event:
        """イベントを取得"""
        event = self.session.get(Event, event_id)
        if not event or event.calendar_id != calendar_id:
            raise MessageRespError(EventNotFoundError(event_id=event_id))

        return event

    def list_events(self, calendar_id: str) -> list[Event]:
        """カレンダーのイベント一覧を取得"""
        stmt = select(Event).where(Event.calendar_id == calendar_id)
        return list(self.session.exec(stmt).all())

    def update_event(
        self, event_id: str, calendar_id: str, event_update: EventUpdate
    ) -> Event:
        """イベントを更新"""
        event = self.get_event(event_id, calendar_id)

        update_data = event_update.model_dump(exclude_unset=True)
        event.sqlmodel_update(update_data)

        self.session.add(event)
        self.session.commit()
        self.session.refresh(event)
        return event


EventServiceDep = Annotated[EventService, Depends(EventService)]
