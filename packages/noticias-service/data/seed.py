import os
import random
from sqlmodel import delete, text, Session, select
from decimal import Decimal
from database import engine
from faker import Faker

def seed_noticias():
    from models.noticias import Noticia
    from models.archivos import Archivo
    from models.noticia_archivo import NoticiaArchivo
    
    with Session(engine) as session:
        # Verificar si ya hay noticias
        existing = session.exec(select(Noticia)).first()
        if existing:
            return
        
        noticias_data = [
            {
                "title": "Como reportar especies avistadas al SENASA",
                "content": """El Servicio Nacional de Sanidad Agraria (SENASA) ha habilitado múltiples canales 
                para que los ciudadanos puedan reportar avistamientos de murciélagos vampiro. 
                Es importante reportar cualquier avistamiento para mantener un control efectivo de la población 
                y prevenir la propagación de enfermedades. Los reportes pueden realizarse a través de la línea 
                gratuita 0800-10828, la aplicación móvil SENASA Contigo, o directamente en las oficinas locales."""
            },
            {
                "title": "Hábitat del murciélago vampiro",
                "content": """Los murciélagos vampiro (Desmodus rotundus) habitan principalmente en cuevas, 
                árboles huecos y construcciones abandonadas. Prefieren áreas con clima cálido y húmedo, 
                cercanas a fuentes de alimento como ganado. En Lima, se han identificado colonias en los 
                distritos de San Martín de Porres, Los Olivos e Independencia. Es importante conocer sus 
                hábitats para evitar encuentros no deseados y tomar las precauciones necesarias."""
            },
            {
                "title": "Brote de rabia en San Martín de Porres",
                "content": """Las autoridades sanitarias han confirmado tres casos de rabia en animales 
                domésticos en el distrito de San Martín de Porres. SENASA ha iniciado una campaña de 
                vacunación masiva y recomienda a todos los dueños de mascotas acudir a los puntos de 
                vacunación gratuita. Es fundamental mantener a las mascotas vacunadas y evitar el 
                contacto con animales silvestres."""
            }
        ]
        
        for data in noticias_data:
            noticia = Noticia(**data)
            session.add(noticia)
        
        session.commit()


def seed_data():
    """Carga los datos iniciales de la base de datos"""
    seed_noticias()


__all__ = ["seed_data"]
