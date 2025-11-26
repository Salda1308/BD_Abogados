# Este archivo configura cómo funciona la app.
# Aquí decimos qué partes usar, cómo conectar con la base de datos, etc.

import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent  # Carpeta principal del proyecto

SECRET_KEY = 'test'  # Código secreto para proteger la app
DEBUG = True  # Modo de pruebas activado, muestra errores
ALLOWED_HOSTS = ['*']  # Direcciones permitidas, '*' significa todas

INSTALLED_APPS = [
    'appclientes',  # Nuestra app de clientes
]

MIDDLEWARE = [
    'django.middleware.common.CommonMiddleware',  # Parte básica del sistema
]

ROOT_URLCONF = 'proyecto_abogados.urls'  # Archivo de direcciones web

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',  # Sistema de plantillas
        'DIRS': [os.path.join(BASE_DIR, 'templates')],  # Carpetas donde buscar plantillas
        'APP_DIRS': True,  # Buscar en las apps también
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',  # Para manejar peticiones
            ],
        },
    },
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.dummy',  # No usamos BD de Django, conectamos manualmente
    }
}

STATIC_URL = '/static/'  # Dirección para archivos fijos
STATICFILES_DIRS = [
    BASE_DIR / 'static',  # Carpetas con archivos fijos
]