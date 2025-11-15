"""
Configuración WSGI para el proyecto proyecto_abogados.
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'proyecto_abogados.settings')

application = get_wsgi_application()