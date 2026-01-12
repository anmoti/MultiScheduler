from typing import Annotated

from fastapi import Depends

from app.core.db import SessionDep
from app.models.calendar import Calendar, CalendarCreate, CalendarUpdate
from app.models.errors import CalendarNotFoundError, MessageRespError, UserNotFoundError
from app.models.links import UserCalendarLink
from app.models.user import User


class CalendarService:
    def __init__(self, session: SessionDep):
        self.session = session

    def create_calendar(
        self, user_id: str, calendar_create: CalendarCreate
    ) -> Calendar:
        """カレンダーを作成"""
        calendar = Calendar.model_validate(
            calendar_create, update={"created_by": user_id}
        )
        # 作成者をカレンダーのユーザーに追加
        user = self.session.get(User, user_id)
        if not user:
            raise MessageRespError(UserNotFoundError(user_id=user_id))
        calendar.users.append(user)

        self.session.add(calendar)
        self.session.commit()
        self.session.refresh(calendar)
        return calendar

    def get_calendar_or_none(self, calendar_id: str) -> Calendar | None:
        """カレンダーを取得"""
        return self.session.get(Calendar, calendar_id)

    def get_calendar(self, calendar_id: str) -> Calendar:
        """カレンダーを取得、存在しない場合はCalendarNotFoundErrorを投げる"""
        calendar = self.session.get(Calendar, calendar_id)
        if not calendar:
            raise MessageRespError(CalendarNotFoundError(calendar_id=calendar_id))

        return calendar

    def update_calendar(
        self, calendar_id: str, calendar_update: CalendarUpdate
    ) -> Calendar:
        """カレンダーを更新"""
        calendar = self.get_calendar(calendar_id)

        update_data = calendar_update.model_dump(exclude_unset=True)
        calendar.sqlmodel_update(update_data)

        self.session.add(calendar)
        self.session.commit()
        self.session.refresh(calendar)
        return calendar

    def check_user_calendar_access(self, calendar_id: str, user_id: str) -> bool:
        """カレンダーへのユーザーのアクセス権を確認"""
        link = self.session.get(UserCalendarLink, (user_id, calendar_id))
        if not link:
            raise MessageRespError(CalendarNotFoundError(calendar_id=calendar_id))

        return True


CalendarServiceDep = Annotated[CalendarService, Depends(CalendarService)]
CalendarServiceDep = Annotated[CalendarService, Depends(CalendarService)]
