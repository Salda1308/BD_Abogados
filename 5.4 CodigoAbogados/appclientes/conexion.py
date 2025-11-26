"""
Este archivo se encarga de conectar con la base de datos.
Sin esta conexión, no podemos guardar o buscar información de clientes.
"""

import oracledb

def get_conn():
    """
    Esta función intenta conectar con la base de datos usando los datos que están aquí.
    Si conecta bien, devuelve la conexión; si no, devuelve nada.
    """
    # Datos para conectar con la base de datos
    usuario = "C##BD85"    # Nombre de usuario
    clave = "bd85"     # Contraseña
    host = "localhost"  # Dirección del servidor
    puerto = "1521"     # Número del puerto
    servicio = "FREE"   # Nombre del servicio

    # Preparar la dirección completa para conectar
    dsn = oracledb.makedsn(host, puerto, service_name=servicio)
    try:
        conn = oracledb.connect(user=usuario, password=clave, dsn=dsn)
        return conn  # Si conecta bien, devuelve la conexión
    except oracledb.Error as e:
        print(f"Error al conectar: {e}")
        return None  # Si no conecta, devuelve nada

def test_connection():
    """
    Esta función prueba si podemos conectar con la base de datos.
    Es útil para saber si todo está funcionando antes de usar la app.
    """
    conn = get_conn()
    if conn:
        print("¡Conectado!")  # Mensaje si conecta
        print(f"Versión: {conn.version}")   # Muestra la versión
        conn.close()  # Cierra la conexión
        return True
    else:
        print("Error: No se pudo conectar")  # Mensaje si falla
        return False