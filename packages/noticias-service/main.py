import os
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
# from fastapi.staticfiles import StaticFiles
from database import create_db_tables
from data.seed import seed_data
from controllers import (
    # avist_archivo,  # Comentar
    # archivos,       # Comentar
    # avist,          # Comentar
    # departamento,   # Comentar
    # distrito,       # Comentar
    noticias,         # Solo dejar este
    # provincia,      # Comentar
    # users,          # Comentar
    # uploads,        # Comentar
)
# from controllers.auth.providers import discord, google  # Comentar
# from controllers.auth import auth                       # Comentar

@asynccontextmanager
async def lifespan(_: FastAPI):
    create_db_tables()
    seed_data()
    yield
    print("Apagando el server")

app = FastAPI(lifespan=lifespan)

# Agregar CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# app.mount("/static", StaticFiles(directory="./images"), name="images")  # Comentar
# app.include_router(uploads.router)  # Comentar

# Solo dejar el router de noticias
app.include_router(noticias.router, prefix="/noticias")

# Comentar todos los demás routers...

if __name__ == "__main__":
    import uvicorn
    PORT = os.getenv("PORT", "8054")
    uvicorn.run(app, host="0.0.0.0", port=int(PORT))
