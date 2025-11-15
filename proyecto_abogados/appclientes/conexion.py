"""
Archivo de conexión a Oracle usando oracledb.
"""

import oracledb

def get_conn():
    """
    Retorna una conexión a Oracle usando oracledb.
    Configurado para Oracle Database 23ai Free Release.
    """
    # Configuración de conexión para Oracle Database 23ai Free
    # Probando primero con servicio 'free'
    usuario = "system"
    clave = "12345"
    host = "localhost"
    puerto = "1521"
    servicio = "free"
    
    # Crear DSN (Data Source Name)
    dsn = oracledb.makedsn(host, puerto, service_name=servicio)
    try:
        conn = oracledb.connect(user=usuario, password=clave, dsn=dsn)
        return conn
    except oracledb.Error as e:
        print(f"Error conectando a Oracle con servicio '{servicio}': {e}")
        return None

def test_connection():
    """
    Función para probar la conexión.
    """
    conn = get_conn()
    if conn:
        print("Conexión a Oracle exitosa!")
        print(f"Versión: {conn.version}")
        conn.close()
        return True
    else:
        print("Error: No se pudo conectar a Oracle")
        return False