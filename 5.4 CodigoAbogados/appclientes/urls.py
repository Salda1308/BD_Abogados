"""
Aquí están las direcciones web que usa la app de clientes.
Cada dirección web llama a una función específica cuando alguien la visita.
"""

from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),  # Página principal
    path('buscar-cliente/', views.buscar_cliente, name='buscar_cliente'),  # Buscar un cliente
    path('guardar-cliente/', views.guardar_cliente, name='guardar_cliente'),  # Guardar un cliente nuevo
    path('obtener-tipos-documento/', views.obtener_tipos_documento, name='obtener_tipos_documento'),  # Lista de tipos de documento
]