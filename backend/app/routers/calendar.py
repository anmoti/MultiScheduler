from fastapi import APIRouter

from app.core.logger import FastAPIStructLogger
from app.deps import CalendarServiceDep, CurrentUserIdDep, UserServiceDep
from app.models.calendar import (
    CalendarCreate,
    CalendarPublic,
)
from app.routers import calendar_items


router = APIRouter(prefix="/calendars")
log = FastAPIStructLogger()

router.include_router(calendar_items.router)


@router.post("/")
async def create_calendar(
    user_id: CurrentUserIdDep,
    calendar_create: CalendarCreate,
    calendar_service: CalendarServiceDep,
) -> CalendarPublic:
    """カレンダーを作成"""
    log.info("Creating calendar", user_id=str(user_id))
    calendar = calendar_service.create_calendar(user_id, calendar_create)
    return CalendarPublic.model_validate(calendar)


@router.get("/")
async def list_calendars(
    user_id: CurrentUserIdDep,
    user_service: UserServiceDep,
) -> list[CalendarPublic]:
    """カレンダー一覧を取得"""
    calendars = user_service.list_calendars(user_id)
    return [CalendarPublic.model_validate(c) for c in calendars]
