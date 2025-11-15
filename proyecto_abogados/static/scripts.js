// Cargar tipos de documento al cargar la página
document.addEventListener('DOMContentLoaded', function() {
    cargarTiposDocumento();
});

// Función para mostrar mensajes
function mostrarMensaje(texto, tipo) {
    const messageDiv = document.getElementById('message');
    messageDiv.textContent = texto;
    messageDiv.className = `message ${tipo}`;
    messageDiv.style.display = 'block';

    setTimeout(() => {
        messageDiv.style.display = 'none';
    }, 5000);
}

// Función para cargar tipos de documento
function cargarTiposDocumento() {
    fetch('/obtener-tipos-documento/')
        .then(response => response.json())
        .then(data => {
            const select = document.getElementById('tipoDocumento');
            select.innerHTML = '<option value="">Seleccione tipo de documento</option>';

            if (data.success && data.tipos_documento) {
                data.tipos_documento.forEach(tipo => {
                    const option = document.createElement('option');
                    option.value = tipo.id;
                    option.textContent = tipo.descripcion;
                    select.appendChild(option);
                });
            } else {
                select.innerHTML = '<option value="">Error al cargar tipos</option>';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('tipoDocumento').innerHTML = '<option value="">Error al cargar tipos</option>';
        });
}

// Función para buscar cliente
function buscarCliente() {
    const codigo = document.getElementById('codigo').value.trim();

    if (!codigo) {
        mostrarMensaje('Por favor ingrese un código', 'error');
        return;
    }

    fetch('/buscar-cliente/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ codigo: codigo })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Llenar el formulario con los datos del cliente
            document.getElementById('nombre').value = data.cliente.nomCliente || '';
            document.getElementById('apellido').value = data.cliente.apelCliente || '';
            document.getElementById('documento').value = data.cliente.nDocumento || '';
            document.getElementById('tipoDocumento').value = data.cliente.idTipoDoc || '';

            mostrarMensaje('Cliente encontrado', 'success');
        } else {
            mostrarMensaje(data.message || 'Cliente no encontrado', 'warning');
            // Limpiar el formulario si no se encuentra el cliente
            limpiarFormulario();
        }
    })
    .catch(error => {
        console.error('Error:', error);
        mostrarMensaje('Error al buscar cliente', 'error');
    });
}

// Función para guardar cliente
function guardarCliente() {
    const formData = {
        codCliente: document.getElementById('codigo').value.trim(),
        nomCliente: document.getElementById('nombre').value.trim(),
        apelCliente: document.getElementById('apellido').value.trim(),
        nDocumento: document.getElementById('documento').value.trim(),
        idTipoDoc: document.getElementById('tipoDocumento').value
    };

    // Validar campos requeridos
    if (!formData.codCliente || !formData.nomCliente || !formData.apelCliente ||
        !formData.nDocumento || !formData.idTipoDoc) {
        mostrarMensaje('Todos los campos son requeridos', 'error');
        return;
    }

    fetch('/guardar-cliente/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            mostrarMensaje(data.message, 'success');
        } else {
            mostrarMensaje(data.message, 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        mostrarMensaje('Error al guardar cliente', 'error');
    });
}

// Función para ejecutar INSERT.sql
function ejecutarInsertSQL() {
    if (!confirm('¿Está seguro que desea ejecutar todas las sentencias INSERT del archivo SQL?')) {
        return;
    }

    fetch('/ejecutar-insert-sql/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({})
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            let mensaje = data.message;
            if (data.warnings) {
                mensaje += '\n\nAdvertencias:\n' + data.warnings.join('\n');
                mostrarMensaje(mensaje, 'warning');
            } else {
                mostrarMensaje(mensaje, 'success');
            }
        } else {
            mostrarMensaje(data.message, 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        mostrarMensaje('Error al ejecutar INSERT.sql', 'error');
    });
}

// Función para limpiar el formulario
function limpiarFormulario() {
    document.getElementById('nombre').value = '';
    document.getElementById('apellido').value = '';
    document.getElementById('documento').value = '';
    document.getElementById('tipoDocumento').value = '';
}

// Permitir buscar cliente con Enter en el campo código
document.getElementById('codigo').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        buscarCliente();
    }
});