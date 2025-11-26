# Configuración de Oracle Database para el Proyecto de Abogados

Este documento explica cómo configurar la base de datos Oracle para el proyecto de registro de clientes de abogados.

## Requisitos Previos

- Oracle Database 23ai Free Edition instalado y corriendo
- SQL*Plus disponible en el PATH
- Python con oracledb instalado

## Pasos de Configuración

### 1. Crear el Usuario de Base de Datos

Ejecuta los siguientes comandos en SQL*Plus como SYSDBA:

```sql
-- Crear usuario (nota: en Oracle 23ai, los usuarios comunes necesitan prefijo C##)
CREATE USER C##BD85 IDENTIFIED BY bd85;

-- Otorgar permisos básicos
GRANT CONNECT, RESOURCE TO C##BD85;
GRANT CREATE SESSION TO C##BD85;
GRANT UNLIMITED TABLESPACE TO C##BD85;
```

### 2. Crear las Tablas

Ejecuta el script de creación de tablas:

```bash
sqlplus C##BD85/bd85@localhost/FREE @"5.2_5.3 SQL/BASE/AbogadoModulo.sql"
```

Este script crea todas las tablas necesarias del esquema de abogados.

### 3. Insertar Datos de Ejemplo

Ejecuta el script de inserts para poblar las tablas con datos de prueba:

```bash
sqlplus C##BD85/bd85@localhost/FREE @"5.2_5.3 SQL/INSERTS/INSERT.sql"
```

Este script inserta:
- Tipos de contacto (correo, número, dirección)
- Tipos de documento (CC, CE, pasaporte)
- Tipos de lugar (país, ciudad, juzgado)
- Formas de pago
- Franquicias bancarias
- Especializaciones de abogados
- Etapas procesales
- Datos de clientes de ejemplo
- Datos de abogados
- Lugares (países, ciudades, juzgados)
- Un caso de ejemplo con su expediente completo

### 4. Verificar la Conexión

Para probar que la conexión funciona, ejecuta desde la carpeta del proyecto:

```bash
cd "5.4 CodigoAbogados"
python -c "from appclientes.conexion import test_connection; test_connection()"
```

Deberías ver algo como:
```
¡Conectado!
Versión: 23.9.0.25.7
```

### 5. Ejecutar la Aplicación

Una vez configurada la BD, puedes ejecutar la app Django:

```bash
cd "5.4 CodigoAbogados"
python manage.py runserver
```

La aplicación estará disponible en http://localhost:8000

## Estructura de la Base de Datos

Las tablas principales incluyen:

- **CLIENTE**: Información de los clientes
- **ABOGADO**: Datos de los abogados
- **CASO**: Casos legales
- **EXPEDIENTE**: Seguimiento de etapas procesales
- **TIPODOCUMENTO**: Tipos de documento de identidad
- **TIPOCONTACT**: Tipos de contacto (correo, teléfono, etc.)

## Notas Importantes

- El usuario debe tener el prefijo `C##` en Oracle 23ai
- Asegúrate de que el servicio Oracle esté corriendo (`OracleServiceFREE`)
- Los scripts SQL están en la carpeta `5.2_5.3 SQL/`
- La aplicación usa el esquema completo del módulo de abogados
- Las consultas SQL usan placeholders `:1`, `:2`, etc. (estándar de Oracle)
- Si hay errores de "bind values", verifica que las consultas usen `:1` en lugar de `?`
- La aplicación maneja errores de clave duplicada con mensajes amigables

## Solución de Problemas

Si hay errores de conexión:
1. Verifica que Oracle esté corriendo: `net start OracleServiceFREE`
2. Confirma las credenciales del usuario
3. Asegúrate de que el servicio sea `FREE` (no `XE` u otro)

Si hay errores al ejecutar scripts:
1. Verifica las rutas de los archivos
2. Asegúrate de tener permisos para crear tablas
3. Revisa los logs de Oracle para errores específicos