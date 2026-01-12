from asgi_correlation_id import CorrelationIdMiddleware
from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from supabase import AuthApiError

from app.core import FastAPIStructLogger, StructLogMiddleware
from app.models.errors import (
    InvalidCredentialsError,
    MessageRespError,
    RefreshTokenNotFoundError,
    SupabaseErrorCode,
    UserAlreadyExistsError,
)
from app.routers import auth, calendar, user


app = FastAPI(title="MultiScheduler API")

app.add_middleware(StructLogMiddleware)
app.add_middleware(CorrelationIdMiddleware)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

log = FastAPIStructLogger()


@app.exception_handler(MessageRespError)
async def message_resp_error_handler(
    _request: Request, e: MessageRespError
) -> JSONResponse:
    return e.message_resp.as_response()


@app.exception_handler(AuthApiError)
async def auth_api_error_handler(
    _request: Request, e: AuthApiError
) -> JSONResponse | AuthApiError:

    if e.code == SupabaseErrorCode.USER_ALREADY_EXISTS.value:
        log.debug("user already exists error during auth")
        return UserAlreadyExistsError().as_response()

    if e.code == SupabaseErrorCode.INVALID_CREDENTIALS.value:
        log.debug("invalid credentials error during auth")
        return InvalidCredentialsError().as_response()

    if e.code == SupabaseErrorCode.REFRESH_TOKEN_NOT_FOUND.value:  # type: ignore[comparison-overlap]
        log.debug("refresh token not found error during auth")
        return RefreshTokenNotFoundError().as_response()

    log.error("unhandled auth api error", code=e.code, dict=e.to_dict())
    return JSONResponse(status_code=500, content={"message": "Internal server error"})


app.include_router(user.router)
app.include_router(auth.router)
app.include_router(calendar.router)


@app.get("/")
def read_root() -> dict[str, str]:
    log.info("API called - Hello World")

    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int) -> dict[str, int]:
    log.bind(item_id=item_id)
    log.info("Processing item request")

    if item_id == 0:
        log.warning("Received invalid item id")
        raise HTTPException(status_code=400, detail="Item ID 0 is not allowed")

    return {"item_id": item_id}


@app.get("/error")
async def trigger_error() -> dict[str, float]:
    log.info("About to trigger a 500 error")
    result = 1 / 0

    return {"result": result}
