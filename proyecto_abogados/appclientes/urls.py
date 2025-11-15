"""
URLs para la app de clientes.
"""

from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('buscar-cliente/', views.buscar_cliente, name='buscar_cliente'),
    path('guardar-cliente/', views.guardar_cliente, name='guardar_cliente'),
    path('ejecutar-insert-sql/', views.ejecutar_insert_sql, name='ejecutar_insert_sql'),
    path('obtener-tipos-documento/', views.obtener_tipos_documento, name='obtener_tipos_documento'),
]