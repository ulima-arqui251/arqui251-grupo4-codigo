# 🧛‍♂️ Desmodus Chatbot API – FastAPI

Este repositorio contiene una **API construida con FastAPI** que expone un **asistente conversacional (chatbot)** diseñado para integrarse con la aplicación **Desmodus App**, una herramienta especializada en la **detección de vampiros**.

El chatbot responde preguntas mediante un modelo de lenguaje (Llama 3.1) alojado en Hugging Face.

---

## 🚀 ¿Qué hace esta API?

- Recibe una consulta (`prompt`) desde el cliente.
- Envia el mensaje al modelo `meta-llama/Llama-3.1-8B-Instruct`.
- Devuelve una respuesta en forma conversacional, actuando como un asistente especializado de la App **Desmodus**.

---

## 🧰 Librerías utilizadas

| Paquete        | Descripción                              |
|----------------|------------------------------------------|
| `fastapi`      | Framework principal para construir la API |
| `uvicorn`      | Servidor ASGI para correr la app         |
| `pydantic`     | Configuración y validaciones de entorno  |
| `pydantic_settings`| Configuración y validaciones de entorno  |
| `python-dotenv`| Lectura de variables de entorno `.env`   |
| `huggingface_hub`  | Cliente de inferencia hacia Hugging Face |

---

## Estructura del proyecto

``` pgsql
chatbot-api
├── services
│   └── chat_service.py
├── client
│   └── client.py
├── configs
│   └── config.py
├── app.py
├── requierements.txt
├── .env
├── .gitignore
└── Readme.md
```

---

## Requisitos previos

- Python 3.10 o superior
- `pip` instalado

---

## Instalación

1. **Clonar el repositorio**:

```bash
git clone https://github.com/ulima-arqui251/arqui251-grupo4-codigo.git
cd arqui251-grupo4-codigo
cd packages
cd chatbot-api
```

2. **Crear y activar un entorno virtual** (opcional pero recomendado):

### Windows

```bash
python -m venv venv
venv\Scripts\activate
```

### MacOs/Linux

```bash
source venv/bin/activate
```

3. **Instalar dependencias**:

```bash
pip install -r requirements.txt
```

4. **Crear archivo .env en la raíz con tu token**:

```ini
HF_TOKEN=tu_token_privado
```

5. **Despliegue local con Uvicorn (modo producción)**:

```bash
uvicorn app:app --host 0.0.0.0 --port 3005 --workers 4
```

---

## Endpoint disponible

### GET /chat

```http
GET /chat?prompt=¿Qué es un murciélago vampiro?
```

### Response

```json
{
  "output": "Un murciélago vampiro es una especie de murciélago que se alimenta de sangre (hematófago)..."
}
```

---

## Seguridad

No incluyas el archivo .env en tus commits. Añádelo al .gitignore.

Puedes usar .env.example como referencia para otros desarrolladores.

---
