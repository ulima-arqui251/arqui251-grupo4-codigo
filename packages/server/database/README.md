# Database

Esta carpeta contiene la configuración y los módulos relacionados con la base de datos para el proyecto FastAPI.

- `database.py`: Configuración de la conexión a la base de datos y sesión.

## Uso

1. Define tus modelos en `models/`.
2. Usa los esquemas de `schemas/` para validar datos de entrada y salida.
3. Implementa la lógica de acceso a datos en `crud.py`.
4. Configura la conexión a la base de datos en `database.py` y utilízala en el resto de la aplicación.

## Notas

- Asegúrate de instalar las dependencias necesarias, como `SQLAlchemy` y `databases`.
- Consulta la documentación oficial de FastAPI para mejores prácticas de integración con bases de datos.
