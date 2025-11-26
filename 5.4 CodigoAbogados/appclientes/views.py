
# Aquí están las funciones que hacen cosas como buscar o guardar información de clientes.


from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
import json
import os
from .conexion import get_conn


# Esta función se llama cuando abres la página principal.
# Lo que hace es mostrar el formulario para registrar clientes.

def index(request):
    return render(request, 'registro_cliente.html')


@csrf_exempt
# Esta función busca a un cliente usando su código.
# Si lo encuentra, llena el formulario con sus datos.
# Si no, muestra un mensaje diciendo que no lo encontró.

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
        WHERE codCliente = :1
        """

        cursor.execute(query, (codigo,))
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
# Esta función guarda la información de un cliente nuevo.
# Primero revisa que todos los campos estén llenos.
# Si está todo bien, guarda los datos y dice que se guardó correctamente.

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

        insert_query = """
        INSERT INTO Cliente (codCliente, nomCliente, apelCliente, nDocumento, idTipoDoc)
        VALUES (:1, :2, :3, :4, :5)
        """

        cursor.execute(insert_query, (
            data['codCliente'].strip(),
            data['nomCliente'].strip(),
            data['apelCliente'].strip(),
            data['nDocumento'].strip(),
            data['idTipoDoc'].strip()
        ))

        conn.commit()
        cursor.close()
        conn.close()

        mensaje = 'Cliente guardado exitosamente'

        return JsonResponse({
            'success': True,
            'message': mensaje
        })

    except Exception as e:
        error_msg = str(e)
        if 'ORA-00001' in error_msg:
            return JsonResponse({
                'success': False,
                'message': 'El código de cliente ya existe. Use un código diferente.'
            })
        else:
            return JsonResponse({
                'success': False,
                'message': f'Error al guardar cliente: {error_msg}'
            })




# Esta función obtiene la lista de tipos de documento que se pueden elegir.
# Los ordena y los manda para que aparezcan en el menú desplegable.

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