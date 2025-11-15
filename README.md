# Sistema de Registro de Clientes - Abogados

Proyecto universitario con Django y Oracle Database.

## 🚀 Inicio Rápido

```bash
# 1. Instalar dependencias
pip install -r requirements.txt

# 2. Configurar Oracle
copy appclientes\conexion.example.py appclientes\conexion.py
# Editar conexion.py con tus credenciales

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
├── manage.py
├── requirements.txt
├── appclientes/
│   ├── views.py
│   ├── urls.py
│   ├── conexion.py
│   └── conexion.example.py
├── templates/
│   └── registro_cliente.html
└── BBDD_Abogados/
    ├── AbogadoModulo.sql
    └── INSERT.sql
```

## 🔧 Requisitos

- Python 3.7+
- Oracle Database
- Django 5.2.8
- oracledb 2.0.0

## 📝 Notas

- NO usa Django ORM, usa SQL directo
- Configurar `conexion.py` con credenciales de Oracle
- Puerto por defecto: 8000

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