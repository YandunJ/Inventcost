$(document).ready(function() {
    // Inicializar DataTable
    const proveedoresTable = $('#proveedoresTable').DataTable({
        ajax: {
            url: '../AJAX/ctrProveedores.php',
            type: 'POST',
            data: { action: 'getProveedores' },
            dataSrc: 'data'  // Asegúrate de que esté configurado a 'data'
        },
        columns: [
            { data: 'proveedor_id' },
            { data: 'nombre_empresa' },
            { data: 'representante' },
            { data: 'direccion' },
            { data: 'correo' },
            { data: 'telefono' },
            { data: 'fecha_reg' },
            {
                data: null,
                render: function(data) {
                    return `
                        <button class="btn btn-warning btn-edit" data-id="${data.proveedor_id}">Editar</button>
                        <button class="btn btn-danger btn-delete" data-id="${data.proveedor_id}">Eliminar</button>
                    `;
                }
            }
        ]
    });
    

    // Manejar el envío del formulario para registrar proveedores
    $('#proveedorForm').on('submit', function(e) {
        e.preventDefault();
        
        const formData = {
            proveedor_id: $('#proveedor_id').val(),
            nombre_empresa: $('#nombre_empresa').val(),
            representante: $('#representante').val(),
            direccion: $('#direccion').val(),
            correo: $('#correo').val(),
            telefono: $('#telefono').val()
        };

        $.ajax({
            url: '../AJAX/ctrProveedores.php',
            type: 'POST',
            data: { action: 'addOrUpdateProveedor', ...formData },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Proveedor registrado exitosamente');
                    proveedoresTable.ajax.reload();
                    $('#proveedorForm')[0].reset(); // Limpiar el formulario
                    // Cambiar el texto del botón de nuevo
                    $('button[type="submit"]').text('Registrar Proveedor');
                } else {
                    alert('Error al registrar el proveedor: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                console.error("Response:", xhr.responseText);
            }
        });
    });

    // Manejar el clic en el botón de editar
  // Manejar el clic en el botón de editar
    $('#proveedoresTable tbody').on('click', '.btn-edit', function() {
        const proveedorId = $(this).data('id');

        $.ajax({
            url: '../AJAX/ctrProveedores.php',
            type: 'POST',
            data: { action: 'getProveedorById', proveedor_id: proveedorId },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    const proveedor = response.data;
                    $('#proveedor_id').val(proveedor.proveedor_id);
                    $('#nombre_empresa').val(proveedor.nombre_empresa);
                    $('#representante').val(proveedor.representante);
                    $('#direccion').val(proveedor.direccion);
                    $('#correo').val(proveedor.correo);
                    $('#telefono').val(proveedor.telefono);
                    
                    // Cambiar el texto del botón
                    $('button[type="submit"]').text('Actualizar Proveedor');
                } else {
                    alert('Proveedor no encontrado');
                }
            }
        });
    });


    // Manejar el clic en el botón de eliminar
    $('#proveedoresTable tbody').on('click', '.btn-delete', function() {
        const proveedorId = $(this).data('id');
        if (confirm("¿Estás seguro de que deseas eliminar este proveedor?")) {
            $.ajax({
                url: '../AJAX/ctrProveedores.php',
                type: 'POST',
                data: { action: 'deleteProveedor', proveedor_id: proveedorId },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        alert('Proveedor eliminado correctamente');
                        proveedoresTable.ajax.reload();
                    } else {
                        alert('Error al eliminar proveedor: ' + response.message);
                    }
                }
            });
        }
    });
});
