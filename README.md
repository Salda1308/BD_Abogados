# Sistema de Registro de Clientes - Abogados

Proyecto universitario con Django y Oracle Database.

## 🚀 Inicio Rápido

```bash
# 1. Instalar dependencias
pip install -r requirements.txt

# 2. Configurar Oracle
# Editar appclientes/conexion.py con tus credenciales

# 3. Ejecutar servidor
python manage.py runserver

# 4. Abrir navegador
# http://localhost:8000
```

## 📋 Funcionalidades

- ✅ Registrar clientes
- ✅ Buscar clientes por código
- ✅ Actualizar clientes existentes
- ✅ Lista de tipos de documento
- ✅ Ejecutar datos de prueba

## 🗄️ Base de Datos

1. Ejecutar `BBDD_Abogados/AbogadoModulo.sql` en Oracle
2. Opcional: Ejecutar `BBDD_Abogados/INSERT.sql` para datos de prueba

## 📁 Estructura

```
proyecto_abogados/
├── 📄 manage.py                    # Comando Django
├── 📄 requirements.txt             # Dependencias Python
├── 📄 README.md                    # Esta documentación
├── 📄 .gitignore                   # Archivos ignorados por Git
├── 📁 appclientes/                 # App principal
│   ├── __init__.py
│   ├── views.py                    # Lógica de negocio
│   ├── urls.py                     # URLs de la app
│   └── conexion.py                 # Credenciales Oracle
├── 📁 static/                      # Archivos estáticos
│   ├── styles.css                  # Estilos CSS
│   └── scripts.js                  # JavaScript
├── 📁 templates/                   # Plantillas HTML
│   └── registro_cliente.html       # Interfaz principal
├── 📁 BBDD_Abogados/               # Scripts SQL
│   ├── AbogadoModulo.sql           # Crear tablas
│   └── INSERT.sql                  # Datos de prueba
└── 📁 proyecto_abogados/           # Configuración Django
    ├── __init__.py
    ├── settings.py                 # Configuración
    ├── urls.py                     # URLs principales
    └── wsgi.py                     # Para despliegue
```

## 🔧 Requisitos

- Python 3.7+
- Oracle Database
- Django 5.2.8
- oracledb 2.0.0

## 📝 Notas

- NO usa Django ORM, usa SQL directo con Oracle
- Configurar `appclientes/conexion.py` con credenciales de Oracle
- Puerto por defecto: 8000
- Archivos CSS y JavaScript separados para mejor organización
- Proyecto simplificado al máximo para fines universitarios

## 🐛 Problemas Comunes

### Error de conexión Oracle
- Verificar que Oracle esté ejecutándose
- Revisar credenciales en `conexion.py`

### Error "No module named 'oracledb'"
```bash
pip install oracledb
```

### Puerto ocupado
```bash
python manage.py runserver 8080
