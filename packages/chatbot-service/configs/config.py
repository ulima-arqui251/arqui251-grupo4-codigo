# config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    hf_token: str

    class Config:
        env_file = ".env"  # Aquí se especifica que se debe leer el archivo .env

settings = Settings()
