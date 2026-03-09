from fastapi import FastAPI
from .routers import main_router

def get_app() -> FastAPI:
    app = FastAPI()
    app.include_router(main_router)
    
    return app