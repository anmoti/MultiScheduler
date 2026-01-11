from fastapi import APIRouter

from app.core.logger import FastAPIStructLogger
from app.deps import SupabaseDep, UserServiceDep
from app.models.errors import MessageRespError, UsernameAlreadyExistsError
from app.models.user import UserBase, UserCreate, UserLogin, UserSession
from app.services.auth import RefreshTokenDep, SessionManagerDep


router = APIRouter(prefix="/auth")
log = FastAPIStructLogger("auth_router")


@router.post("/signup")
def signup_user(
    user_create: UserCreate,
    supabase: SupabaseDep,
    session_manager: SessionManagerDep,
    user_service: UserServiceDep,
) -> UserSession:
    """ユーザーを登録"""
    if user_service.has_username(user_create.name):
        raise MessageRespError(UsernameAlreadyExistsError())

    auth_resp = supabase.auth.sign_up({
        "email": user_create.email,
        "password": user_create.password,
        "options": {"data": UserBase.model_validate(user_create).model_dump()},
    })

    user_session, supabase_user = session_manager.handle_auth_response(
        auth_resp, "User signup"
    )

    user_service.create_user(supabase_user)

    log.info("User signup successful", user_id=user_session.user_id)
    return user_session


@router.post("/signin")
def signin_user(
    user_login: UserLogin,
    supabase: SupabaseDep,
    session_manager: SessionManagerDep,
) -> UserSession:
    """ユーザーがサインイン"""
    auth_resp = supabase.auth.sign_in_with_password({
        "email": user_login.email,
        "password": user_login.password,
    })

    user_session, _supabase_user = session_manager.handle_auth_response(
        auth_resp, "User signin"
    )
    log.info("User signin successful", user_id=user_session.user_id)
    return user_session


@router.post("/refresh")
def refresh_session(
    refresh_token: RefreshTokenDep,
    session_manager: SessionManagerDep,
    supabase: SupabaseDep,
) -> UserSession:
    """ユーザーセッションをリフレッシュ"""
    log.debug("Refreshing session", refresh_token=refresh_token)

    auth_resp = supabase.auth.refresh_session(refresh_token)
    user_session, _supabase_user = session_manager.handle_auth_response(
        auth_resp, "Session refresh"
    )
    log.debug("Session refresh successful", user_id=user_session.user_id)
    return user_session
