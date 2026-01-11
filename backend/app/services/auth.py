from typing import Annotated

import jwt
import supabase_auth
from fastapi import Depends, HTTPException, Request, Response, status

from app.core.config import settings
from app.core.logger import FastAPIStructLogger
from app.models.errors import MessageRespError, NotAuthenticatedError
from app.models.user import UserSession


log = FastAPIStructLogger("auth_service")

ACCESS_TOKEN = "access_token"
REFRESH_TOKEN = "refresh_token"

JWKS_URL = f"{settings.SUPABASE_URL}/auth/v1/.well-known/jwks.json"
jwks_client = jwt.PyJWKClient(JWKS_URL)


def get_access_token_from_header_or_cookie(request: Request) -> str:
    """ヘッダーまたはCookieから `access_token` を取得"""
    auth_header = request.headers.get("Authorization")
    if auth_header and auth_header.startswith("Bearer "):
        return auth_header.split(" ")[1]

    cookie_token = request.cookies.get(ACCESS_TOKEN)
    if cookie_token:
        return cookie_token

    raise MessageRespError(NotAuthenticatedError())


AccessTokenDep = Annotated[str, Depends(get_access_token_from_header_or_cookie)]


def get_refresh_token_from_header_or_cookie(request: Request) -> str:
    """ヘッダーまたはCookieから `refresh_token` を取得"""
    refresh_header = request.headers.get("X-Refresh-Token")
    if refresh_header:
        return refresh_header

    cookie_token = request.cookies.get(REFRESH_TOKEN)
    if cookie_token:
        return cookie_token

    log.debug("No refresh token found in header or cookie", cookie=request.cookies)

    raise MessageRespError(NotAuthenticatedError())


RefreshTokenDep = Annotated[str, Depends(get_refresh_token_from_header_or_cookie)]


def get_current_user_id(access_token: AccessTokenDep) -> str:
    try:
        # ヘッダーをデコードしてアルゴリズムを確認
        unverified_header = jwt.get_unverified_header(access_token)
        alg = unverified_header.get("alg")

        if alg == "ES256":
            # ES256の場合はJWKSから公開鍵を取得して検証
            signing_key = jwks_client.get_signing_key_from_jwt(access_token)

            payload = jwt.decode(
                access_token,
                signing_key.key,
                algorithms=["ES256"],
                audience="authenticated",
            )
        else:
            # HS256 (デフォルト) の場合は共有シークレットで検証
            payload = jwt.decode(
                access_token,
                settings.SUPABASE_JWT_SECRET,
                algorithms=["HS256"],
                audience="authenticated",
            )
    except jwt.PyJWTError as e:
        log.debug("JWT decoding failed", error=e)
        raise MessageRespError(NotAuthenticatedError()) from None

    user_id = payload.get("sub")
    if not isinstance(user_id, str):
        raise MessageRespError(NotAuthenticatedError())

    return user_id


CurrentUserIdDep = Annotated[str, Depends(get_current_user_id)]


class SessionManager:
    """セッション管理ユーティリティクラス"""

    def __init__(self, response: Response):
        self.response = response

    def handle_auth_response(
        self, auth_resp: supabase_auth.AuthResponse, log_label: str
    ) -> tuple[UserSession, supabase_auth.User]:
        """Supabaseのレスポンス検証、Cookie設定、UserSessionの生成を一括で行う"""
        if not auth_resp.user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"{log_label} failed - no user returned",
            )
        if not auth_resp.session:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"{log_label} failed - no session returned",
            )

        user_session = UserSession(
            user_id=auth_resp.user.id,
            access_token=auth_resp.session.access_token,
            refresh_token=auth_resp.session.refresh_token,
        )

        self._set_auth_cookies(user_session, auth_resp.session.expires_in)

        return user_session, auth_resp.user

    def _set_auth_cookies(
        self, session: UserSession, access_token_expires_in: int
    ) -> None:
        self.response.set_cookie(
            key=ACCESS_TOKEN,
            value=session.access_token,
            path="/",
            max_age=access_token_expires_in,
            httponly=True,
            secure=not settings.is_dev(),
            samesite="lax",
        )

        self.response.set_cookie(
            key=REFRESH_TOKEN,
            value=session.refresh_token,
            path="/auth/refresh",
            httponly=True,
            secure=not settings.is_dev(),
            samesite="lax",
        )


SessionManagerDep = Annotated[SessionManager, Depends(SessionManager)]
