from fastapi import APIRouter, HTTPException, Depends, Query
from sqlmodel import Session, select, SQLModel
from typing import List, Optional
from datetime import datetime

from database import get_session
from models.noticias import Noticia
from models.archivos import Archivo
from models.noticia_archivo import NoticiaArchivo

router = APIRouter()

# Esquema para respuesta
class NoticiaResponse(SQLModel):
    id: int
    title: str
    content: str
    description: Optional[str] = None
    author: Optional[str] = None
    published_at: Optional[datetime] = None
    image_url: Optional[str] = None
    is_important: bool = False

# Obtener todas las noticias
@router.get("/", response_model=List[NoticiaResponse])
def get_noticias(
    skip: int = Query(0, ge=0),
    limit: int = Query(10, ge=1, le=100),
    session: Session = Depends(get_session)
):
    statement = select(Noticia).offset(skip).limit(limit)
    noticias = session.exec(statement).all()
    
    response = []
    for noticia in noticias:
        # Obtener la primera imagen asociada
        image_url = None
        if noticia.noticia_archivos:
            archivo = noticia.noticia_archivos[0].archivo
            if archivo:
                image_url = archivo.image_url
        
        response.append(NoticiaResponse(
            id=noticia.id,
            title=noticia.title,
            content=noticia.content,
            description=noticia.content[:150] + "..." if len(noticia.content) > 150 else noticia.content,
            image_url=image_url,
            published_at=datetime.now()  # Agregar campo de fecha si lo tienes en el modelo
        ))
    
    return response

# Obtener noticia por ID
@router.get("/{noticia_id}", response_model=NoticiaResponse)
def get_noticia(noticia_id: int, session: Session = Depends(get_session)):
    noticia = session.get(Noticia, noticia_id)
    if not noticia:
        raise HTTPException(status_code=404, detail="Noticia no encontrada")
    
    # Obtener imagen
    image_url = None
    if noticia.noticia_archivos:
        archivo = noticia.noticia_archivos[0].archivo
        if archivo:
            image_url = archivo.image_url
    
    return NoticiaResponse(
        id=noticia.id,
        title=noticia.title,
        content=noticia.content,
        description=noticia.content[:150] + "..." if len(noticia.content) > 150 else noticia.content,
        image_url=image_url,
        published_at=datetime.now()
    )

# Crear nueva noticia
@router.post("/", response_model=NoticiaResponse)
def create_noticia(
    title: str,
    content: str,
    image_url: Optional[str] = None,
    session: Session = Depends(get_session)
):
    noticia = Noticia(title=title, content=content)
    session.add(noticia)
    session.commit()
    session.refresh(noticia)
    
    # Si hay imagen, crear archivo y relación
    if image_url:
        archivo = Archivo(image_url=image_url)
        session.add(archivo)
        session.commit()
        session.refresh(archivo)
        
        noticia_archivo = NoticiaArchivo(
            noticia_id=noticia.id,
            archivo_id=archivo.id
        )
        session.add(noticia_archivo)
        session.commit()
    
    return NoticiaResponse(
        id=noticia.id,
        title=noticia.title,
        content=noticia.content,
        description=noticia.content[:150] + "..." if len(noticia.content) > 150 else noticia.content,
        image_url=image_url,
        published_at=datetime.now()
    )