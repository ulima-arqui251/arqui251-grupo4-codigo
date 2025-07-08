def chat_service(client, prompt: str) -> str:
    response = client.chat.completions.create(
        model="meta-llama/Llama-3.1-8B-Instruct",
        messages=[
            {
                "role": "user",
                "content": f"Eres un asistente de una app de detección de murciélago vampiro llamada 'Desmodus', responde la siguiente consulta:\n {prompt}"
            }
        ],
    )
    return response.choices[0].message.content