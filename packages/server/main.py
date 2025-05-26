from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def entry_point():
    return {"message": "Hola mundo"}
