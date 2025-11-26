"""
URLs principales del proyecto proyecto_abogados.
"""
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', include('appclientes.urls')),
]

if settings.DEBUG and settings.STATICFILES_DIRS:
    urlpatterns += static(settings.STATIC_URL, document_root=str(settings.STATICFILES_DIRS[0]))