from fastapi import APIRouter

from app.core.logger import FastAPIStructLogger
from app.models.user import UserPrivate
from app.services.auth import CurrentUserIdDep
from app.services.user import UserServiceDep


router = APIRouter(prefix="/users")
log = FastAPIStructLogger()


@router.get("/me")
async def get_user_private(
    user_id: CurrentUserIdDep, user_service: UserServiceDep
) -> UserPrivate:
    """ログインしているユーザーの情報を取得"""
    user = user_service.get_user(user_id)
    return UserPrivate.model_validate(user)
