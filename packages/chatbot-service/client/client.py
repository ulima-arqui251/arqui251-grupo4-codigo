from huggingface_hub import InferenceClient

def init_client(api_key: str) -> InferenceClient:
    return InferenceClient(
        provider="fireworks-ai",
        api_key=api_key,
    )