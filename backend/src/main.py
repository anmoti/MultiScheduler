from asgi_correlation_id import CorrelationIdMiddleware
from fastapi import FastAPI, HTTPException

from core.logger import FastAPIStructLogger, StructLogMiddleware


app = FastAPI(title="MultiScheduler API")

app.add_middleware(StructLogMiddleware)
app.add_middleware(CorrelationIdMiddleware)

log = FastAPIStructLogger()


@app.get("/")
def read_root():
    log.info("API called - Hello World")

    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int):
    log.bind(item_id=item_id)
    log.info("Processing item request")

    if item_id == 0:
        log.warning("Received invalid item id")
        raise HTTPException(status_code=400, detail="Item ID 0 is not allowed")

    return {"item_id": item_id}


@app.get("/error")
async def trigger_error():
    log.info("About to trigger a 500 error")
    result = 1 / 0

    return {"result": result}
