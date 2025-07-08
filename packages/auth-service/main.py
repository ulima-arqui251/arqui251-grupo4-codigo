import os
from contextlib import asynccontextmanager
from fastapi import FastAPI
from database import create_db_tables
from controllers import (
    users,
)
from controllers.auth.providers import discord, google
from controllers.auth import auth


@asynccontextmanager
async def lifespan(_: FastAPI):
    create_db_tables()

    yield

    # print("Eliminando las tablas de la base de datos")
    # delete_db_tables()
    print("Apagando el server")


app = FastAPI(lifespan=lifespan)

app.include_router(users.router, prefix="/users")
app.include_router(google.router, prefix="/google-auth")
app.include_router(discord.router, prefix="/discord-auth")
app.include_router(auth.router, prefix="/auth")

if __name__ == "__main__":
    import uvicorn

    print(os.getenv("PORT"))
    PORT = os.getenv("PORT", "8054")

    uvicorn.run(app, host="0.0.0.0", port=PORT)
