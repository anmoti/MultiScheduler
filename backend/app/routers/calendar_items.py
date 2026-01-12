from fastapi import APIRouter, Depends

from app.core.logger import FastAPIStructLogger
from app.deps import CalendarServiceDep, CurrentUserIdDep, EventServiceDep
from app.models.calendar import (
    CalendarPublic,
    CalendarUpdate,
)
from app.models.event import (
    EventCreate,
    EventPublic,
    EventUpdate,
)


log = FastAPIStructLogger()


def verify_calendar_access(
    calendar_id: str,
    user_id: CurrentUserIdDep,
    calendar_service: CalendarServiceDep,
) -> None:
    """カレンダーへのユーザーのアクセス権を確認する依存関係"""
    calendar_service.check_user_calendar_access(calendar_id, user_id)


router = APIRouter(
    prefix="/{calendar_id}", dependencies=[Depends(verify_calendar_access)]
)


@router.get("/")
async def get_calendar(
    calendar_id: str,
    calendar_service: CalendarServiceDep,
) -> CalendarPublic:
    """カレンダーを取得"""
    calendar = calendar_service.get_calendar(calendar_id)
    return CalendarPublic.model_validate(calendar)


@router.patch("/")
async def update_calendar(
    calendar_id: str,
    calendar_update: CalendarUpdate,
    calendar_service: CalendarServiceDep,
) -> CalendarPublic:
    """カレンダーを更新"""
    calendar = calendar_service.update_calendar(calendar_id, calendar_update)
    return CalendarPublic.model_validate(calendar)


@router.get("/events")
async def list_events(
    calendar_id: str,
    event_service: EventServiceDep,
) -> list[EventPublic]:
    """イベント一覧を取得"""
    events = event_service.list_events(calendar_id)
    return [EventPublic.model_validate(e) for e in events]


@router.post("/events")
async def create_event(
    calendar_id: str,
    user_id: CurrentUserIdDep,
    event_create: EventCreate,
    event_service: EventServiceDep,
) -> EventPublic:
    """イベントを作成"""
    event = event_service.create_event(user_id, calendar_id, event_create)
    return EventPublic.model_validate(event)


@router.get("/events/{event_id}")
async def get_event(
    calendar_id: str,
    event_id: str,
    event_service: EventServiceDep,
) -> EventPublic:
    """イベントを取得"""
    event = event_service.get_event(event_id, calendar_id)
    return EventPublic.model_validate(event)


@router.patch("/events/{event_id}")
async def update_event(
    calendar_id: str,
    event_id: str,
    event_update: EventUpdate,
    event_service: EventServiceDep,
) -> EventPublic:
    """イベントを更新"""
    event = event_service.update_event(event_id, calendar_id, event_update)
    return EventPublic.model_validate(event)
