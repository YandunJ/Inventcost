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

        const proveedorId = $(this).data('proveedor_id'); // Obtener el ID del proveedor
        const action = proveedorId ? 'updateProveedor' : 'addProveedor'; // Determinar acción

        const formData = {
            proveedor_id: proveedorId,
            nombre_empresa: $('#nombre_empresa').val(),
            representante: $('#representante').val(),
            direccion: $('#direccion').val(),
            correo: $('#correo').val(),
            telefono: $('#telefono').val()
        };

        Swal.fire({
            title: proveedorId ? "¿Está seguro de que desea actualizar este proveedor?" : "¿Está seguro de que desea registrar este proveedor?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: proveedorId ? "Sí, actualizar" : "Sí, registrar",
            cancelButtonText: "Cancelar"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrProveedores.php',
                    type: 'POST',
                    data: { action: action, ...formData },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: proveedorId ? 'Proveedor actualizado exitosamente' : 'Proveedor registrado exitosamente',
                                showConfirmButton: false,
                                timer: 1500
                            });
                            proveedoresTable.ajax.reload();
                            $('#proveedorForm')[0].reset();
                            $('#proveedorForm').removeData('proveedor_id'); // Limpiar ID después de guardar
                            $('button[type="submit"]').text('Registrar Proveedor');
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.message || 'Error al registrar el proveedor',
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error:", error);
                        console.error("Response:", xhr.responseText);
                    }
                });
            }
        });
    });

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
                    $('#proveedorForm').data('proveedor_id', proveedorId); // Guardar ID en el formulario
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error al cargar proveedor: ' + response.message,
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
            }
        });
    });

    // Manejar el clic en el botón de eliminar
    $('#proveedoresTable tbody').on('click', '.btn-delete', function() {
        const proveedorId = $(this).data('id');

        Swal.fire({
            title: "¿Está seguro de que desea eliminar este proveedor?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Sí, eliminar",
            cancelButtonText: "Cancelar"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrProveedores.php',
                    type: 'POST',
                    data: { action: 'deleteProveedor', proveedor_id: proveedorId },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: 'Eliminado',
                                text: 'El proveedor ha sido eliminado correctamente',
                                confirmButtonText: 'Aceptar'
                            }).then(() => {
                                proveedoresTable.ajax.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.message || 'Error al eliminar el proveedor',
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Hubo un problema con la solicitud: ' + error,
                        });
                    }
                });
            }
        });
    });

});
