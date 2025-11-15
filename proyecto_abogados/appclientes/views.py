from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
import json
import os
from .conexion import get_conn


def index(request):
    return render(request, 'registro_cliente.html')


@csrf_exempt
@require_http_methods(["POST"])
def buscar_cliente(request):
    try:
        data = json.loads(request.body)
        codigo = data.get('codigo', '').strip()

        if not codigo:
            return JsonResponse({
                'success': False,
                'message': 'Por favor ingrese un código'
            })

        conn = get_conn()
        if not conn:
            return JsonResponse({
                'success': False,
                'message': 'Error de conexión a la base de datos'
            })

        cursor = conn.cursor()

        query = """
        SELECT codCliente, nomCliente, apelCliente, nDocumento, idTipoDoc
        FROM Cliente
        WHERE codCliente = :codigo
        """

        cursor.execute(query, {'codigo': codigo})
        resultado = cursor.fetchone()

        if resultado:
            cliente_data = {
                'codCliente': resultado[0] or '',
                'nomCliente': resultado[1] or '',
                'apelCliente': resultado[2] or '',
                'nDocumento': resultado[3] or '',
                'idTipoDoc': resultado[4] or ''
            }
            cursor.close()
            conn.close()

            return JsonResponse({
                'success': True,
                'cliente': cliente_data
            })
        else:
            cursor.close()
            conn.close()
            return JsonResponse({
                'success': False,
                'message': 'Cliente no encontrado'
            })

    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error al buscar cliente: {str(e)}'
        })


@csrf_exempt
@require_http_methods(["POST"])
def guardar_cliente(request):
    try:
        data = json.loads(request.body)

        required_fields = ['codCliente', 'nomCliente', 'apelCliente', 'nDocumento', 'idTipoDoc']
        for field in required_fields:
            if not data.get(field, '').strip():
                return JsonResponse({
                    'success': False,
                    'message': f'El campo {field} es requerido'
                })

        conn = get_conn()
        if not conn:
            return JsonResponse({
                'success': False,
                'message': 'Error de conexión a la base de datos'
            })

        cursor = conn.cursor()

        check_query = "SELECT COUNT(*) FROM Cliente WHERE codCliente = :codigo"
        cursor.execute(check_query, {'codigo': data['codCliente']})
        existe = cursor.fetchone()[0] > 0

        if existe:
            update_query = """
            UPDATE Cliente
            SET nomCliente = :nom,
                apelCliente = :ape,
                nDocumento = :doc,
                idTipoDoc = :tipo
            WHERE codCliente = :cod
            """

            cursor.execute(update_query, {
                'nom': data['nomCliente'].strip(),
                'ape': data['apelCliente'].strip(),
                'doc': data['nDocumento'].strip(),
                'tipo': data['idTipoDoc'].strip(),
                'cod': data['codCliente'].strip()
            })
            mensaje = 'Cliente actualizado exitosamente'
        else:
            insert_query = """
            INSERT INTO Cliente (codCliente, nomCliente, apelCliente, nDocumento, idTipoDoc)
            VALUES (:cod, :nom, :ape, :doc, :tipo)
            """

            cursor.execute(insert_query, {
                'cod': data['codCliente'].strip(),
                'nom': data['nomCliente'].strip(),
                'ape': data['apelCliente'].strip(),
                'doc': data['nDocumento'].strip(),
                'tipo': data['idTipoDoc'].strip()
            })
            mensaje = 'Cliente guardado exitosamente'

        conn.commit()
        cursor.close()
        conn.close()

        return JsonResponse({
            'success': True,
            'message': mensaje
        })

    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error al guardar cliente: {str(e)}'
        })


@csrf_exempt
@require_http_methods(["POST"])
def ejecutar_insert_sql(request):
    try:
        sql_file_path = os.path.join(os.path.dirname(os.path.dirname(__file__)),
                                    'BBDD_Abogados', 'INSERT.sql')

        if not os.path.exists(sql_file_path):
            return JsonResponse({
                'success': False,
                'message': 'Archivo INSERT.sql no encontrado'
            })

        conn = get_conn()
        if not conn:
            return JsonResponse({
                'success': False,
                'message': 'Error de conexión a la base de datos'
            })

        cursor = conn.cursor()

        with open(sql_file_path, 'r', encoding='utf-8') as file:
            sql_content = file.read()

        statements = []
        current_statement = ""

        for line in sql_content.split('\n'):
            line = line.strip()
            if line and not line.startswith('--'):
                current_statement += line + ' '

                if line.endswith(';'):
                    statements.append(current_statement.strip())
                    current_statement = ""

        executed_count = 0
        errors = []

        for i, statement in enumerate(statements):
            try:
                clean_statement = statement.rstrip(';').strip()
                if clean_statement:
                    cursor.execute(clean_statement)
                    executed_count += 1
            except Exception as e:
                errors.append(f"Error en sentencia {i+1}: {str(e)}")
                errors.append(f"Sentencia: {statement[:100]}...")

        conn.commit()
        cursor.close()
        conn.close()

        if errors:
            return JsonResponse({
                'success': True,
                'message': f'Se ejecutaron {executed_count} sentencias',
                'warnings': errors
            })
        else:
            return JsonResponse({
                'success': True,
                'message': f'Se ejecutaron {executed_count} sentencias exitosamente'
            })

    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error al ejecutar INSERT.sql: {str(e)}'
        })


def obtener_tipos_documento(request):
    try:
        conn = get_conn()
        if not conn:
            return JsonResponse({
                'success': False,
                'message': 'Error de conexión a la base de datos'
            })

        cursor = conn.cursor()

        query = "SELECT idTipoDoc, descTipoDoc FROM TipoDocumento ORDER BY idTipoDoc"
        cursor.execute(query)
        resultados = cursor.fetchall()

        tipos_documento = [
            {'id': str(row[0]), 'descripcion': row[1]}
            for row in resultados
        ]

        cursor.close()
        conn.close()

        return JsonResponse({
            'success': True,
            'tipos_documento': tipos_documento
        })

    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error al obtener tipos de documento: {str(e)}'
        })