import os
from dotenv import load_dotenv

load_dotenv()


class Config:
    AMBIENTE = os.getenv("AMBIENTE")

    CLIENT_ID = os.getenv("CLIENT_ID")
    CLIENT_SECRET = os.getenv("CLIENT_SECRET")
    SECURE_COOKIE = os.getenv("SECURE_COOKIE")
    JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY")

    REDIRECT_URI = os.getenv("REDIRECT_URI")

    DISCORD_CLIENT_ID = os.getenv("DISCORD_CLIENT_ID")
    DISCORD_CLIENT_SECRET = os.getenv("DISCORD_CLIENT_SECRET")
    DISCORD_REDIRECT_URI = os.getenv("DISCORD_REDIRECT_URI")

    DATABASE_ENGINE = os.getenv("DATABASE_ENGINE")
    DATABASE_URL = os.getenv("DATABASE_URL")
    DATABASE_PORT = os.getenv("DATABASE_PORT")
    DATABASE_NAME = os.getenv("DATABASE_NAME")
    DATABASE_USER = os.getenv("DATABASE_USER")
    DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD")
