from fastapi import APIRouter

router = APIRouter()

@router.get("/")
async def read_root():
    return {"message": "Hello, World!"}

@router.get("/version")
async def read_version():
    return {"version": "0.1.0"}

@router.get("/health")
async def read_health():
    return {"status": "ok"}