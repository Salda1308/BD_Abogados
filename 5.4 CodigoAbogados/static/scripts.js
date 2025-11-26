// Este archivo controla lo que pasa en la página web para registrar clientes.
// Aquí están las funciones que hablan con el servidor para buscar o guardar datos.

// Cargar tipos de documento al cargar la página
document.addEventListener('DOMContentLoaded', function() {
    cargarTiposDocumento();
});

// Función para mostrar mensajes, como si algo salió bien o mal
function mostrarMensaje(texto, tipo) {
    const messageDiv = document.getElementById('message');  // Caja donde aparece el mensaje
    messageDiv.textContent = texto;  // Escribe el mensaje
    messageDiv.className = `message ${tipo}`;  // Estilo según el tipo
    messageDiv.style.display = 'block';  // Muestra la caja

    setTimeout(() => {  // Después de 5 segundos, esconde el mensaje
        messageDiv.style.display = 'none';
    }, 5000);
}

// Función para cargar tipos de documento desde el backend
function cargarTiposDocumento() {
    fetch('/obtener-tipos-documento/')  // Petición GET a la URL de tipos de documento
        .then(response => response.json())  // Convierte la respuesta a JSON
        .then(data => {
            const select = document.getElementById('tipoDocumento');  // El select del formulario
            select.innerHTML = '<option value="">Seleccione tipo de documento</option>';  // Opción por defecto

            if (data.success && data.tipos_documento) {  // Si la respuesta es ok y hay tipos
                data.tipos_documento.forEach(tipo => {  // Por cada tipo, crea una opción
                    const option = document.createElement('option');
                    option.value = tipo.id;  // Valor del option
                    option.textContent = tipo.descripcion;  // Texto que se ve
                    select.appendChild(option);  // Agrega al select
                });
            } else {
                select.innerHTML = '<option value="">Error al cargar tipos</option>';  // Si falla, mensaje de error
            }
        })
        .catch(error => {
            console.error('Error:', error);  // Log del error en consola
            document.getElementById('tipoDocumento').innerHTML = '<option value="">Error al cargar tipos</option>';
        });
}

// Función para buscar cliente por código, hace una petición POST al backend
function buscarCliente() {
    const codigo = document.getElementById('codigo').value.trim();  // Obtiene el código del input

    if (!codigo) {  // Si no hay código, muestra error
        mostrarMensaje('Por favor ingrese un código', 'error');
        return;
    }

    fetch('/buscar-cliente/', {  // Petición POST a la URL de buscar cliente
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',  // Envía JSON
        },
        body: JSON.stringify({ codigo: codigo })  // Envía el código en el body
    })
    .then(response => response.json())  // Convierte respuesta a JSON
    .then(data => {
        if (data.success) {  // Si encontró al cliente
            // Llenar el formulario con los datos del cliente
            document.getElementById('nombre').value = data.cliente.nomCliente || '';
            document.getElementById('apellido').value = data.cliente.apelCliente || '';
            document.getElementById('documento').value = data.cliente.nDocumento || '';
            document.getElementById('tipoDocumento').value = data.cliente.idTipoDoc || '';

            mostrarMensaje('Cliente encontrado', 'success');  // Mensaje de éxito
        } else {  // Si no encontró
            mostrarMensaje(data.message || 'Cliente no encontrado', 'warning');
            // Limpiar el formulario si no se encuentra el cliente
            limpiarFormulario();
        }
    })
    .catch(error => {
        console.error('Error:', error);  // Log del error
        mostrarMensaje('Error al buscar cliente', 'error');
    });
}

// Función para guardar cliente, envía todos los datos del formulario al backend
function guardarCliente() {
    const formData = {  // Recoge los valores del formulario
        codCliente: document.getElementById('codigo').value.trim(),
        nomCliente: document.getElementById('nombre').value.trim(),
        apelCliente: document.getElementById('apellido').value.trim(),
        nDocumento: document.getElementById('documento').value.trim(),
        idTipoDoc: document.getElementById('tipoDocumento').value
    };

    // Validar campos requeridos antes de enviar
    if (!formData.codCliente || !formData.nomCliente || !formData.apelCliente ||
        !formData.nDocumento || !formData.idTipoDoc) {
        mostrarMensaje('Todos los campos son requeridos', 'error');
        return;
    }

    

    fetch('/guardar-cliente/', {  // Petición POST a guardar cliente
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)  // Envía los datos en JSON
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {  // Si se guardó bien
            mostrarMensaje(data.message, 'success');
        } else {  // Si hubo error
            mostrarMensaje(data.message, 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        mostrarMensaje('Error al guardar cliente', 'error');
    });
}


// Función para limpiar el formulario, pone todos los campos en blanco
function limpiarFormulario() {
    document.getElementById('nombre').value = '';
    document.getElementById('apellido').value = '';
    document.getElementById('documento').value = '';
    document.getElementById('tipoDocumento').value = '';
}

// Event listener para permitir buscar cliente presionando Enter en el campo código
document.getElementById('codigo').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {  // Si presiona Enter
        e.preventDefault();  // Evita el comportamiento por defecto
        buscarCliente();  // Llama a la función de buscar
    }
});