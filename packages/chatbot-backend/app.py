from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from client.client import init_client
from huggingface_hub import InferenceClient
from configs.config import settings
from services.chat_service import chat_service

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Inicializar el cliente al arrancar la app
    app.state.client = init_client(settings.hf_token)
    yield  # Aquí la app está corriendo

app = FastAPI(lifespan=lifespan)

@app.get("/chat")
def generate_text(prompt: str, request: Request):

    client: InferenceClient = request.app.state.client

    response = chat_service(client, prompt)
    return {"output": response}