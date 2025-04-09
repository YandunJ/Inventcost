$(document).ready(function () {
    const proveedoresTable = $('#proveedoresTable').DataTable({
        ajax: {
            url: '../AJAX/ctrProveedores.php',
            type: 'POST',
            data: { action: 'getProveedores' },
            dataSrc: 'data',
        },
        order: [[4, 'desc']], // Ordenar por la columna de fecha de registro en orden descendente
        columns: [
            { data: 'nombre_empresa' },
            { data: 'representante' },
            { data: 'correo' },
            { data: 'telefono' },
            { data: 'fecha_reg' },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle btn-sm" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item edit-btn" href="#" data-id="${row.proveedor_id}">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                                
                            </div>
                        </div>
                    `;
                }
            }
        ],
        language: dataTableLanguage
    });

    // Botón para abrir el modal para agregar un nuevo proveedor
    $('#addProveedorButton').on('click', function () {
        $('#proveedorForm')[0].reset();
        $('#proveedor_id').val('');
        $('#proveedorModalLabel').text('Registrar Proveedor');
        $('#proveedorModal').modal('show');
    });

    // Botón para cerrar el modal al cancelar
    $('#cancelarProveedorButton').on('click', function () {
        $('#proveedorModal').modal('hide');
    });

    // Envío del formulario
    $('#proveedorForm').on('submit', function (e) {
        e.preventDefault();

        const proveedorId = $('#proveedor_id').val();
        const action = proveedorId ? 'updateProveedor' : 'addProveedor';

        const formData = {
            proveedor_id: proveedorId,
            nombre_empresa: $('#nombre_empresa').val(),
            representante: $('#representante').val(),
            correo: $('#correo').val() || '', // Permitir valores vacíos
            telefono: $('#telefono').val() || '', // Permitir valores vacíos
        };

        Swal.fire({
            title: proveedorId ? '¿Está seguro de que desea actualizar este proveedor?' : '¿Está seguro de que desea agregar este proveedor?',
            text: proveedorId ? 'Actualizar los datos del proveedor puede afectar los registros históricos y la trazabilidad de los lotes de materia prima e insumos.' : '',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, confirmar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrProveedores.php',
                    type: 'POST',
                    data: { action: action, ...formData },
                    dataType: 'json',
                    success: function (response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: proveedorId ? 'Proveedor actualizado exitosamente' : 'Proveedor registrado exitosamente',
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            proveedoresTable.ajax.reload();
                            $('#proveedorModal').modal('hide');
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.message || 'Error al procesar la solicitud',
                            });
                        }
                    },
                });
            }
        });
    });

    // Botón para editar un proveedor
    $('#proveedoresTable tbody').on('click', '.edit-btn', function () {
        const proveedorId = $(this).data('id');

        $.ajax({
            url: '../AJAX/ctrProveedores.php',
            type: 'POST',
            data: { action: 'getProveedorById', proveedor_id: proveedorId },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    const proveedor = response.data;
                    $('#proveedor_id').val(proveedor.proveedor_id);
                    $('#nombre_empresa').val(proveedor.nombre_empresa);
                    $('#representante').val(proveedor.representante);
                    $('#correo').val(proveedor.correo);
                    $('#telefono').val(proveedor.telefono);

                    $('#proveedorModalLabel').text('Editar Proveedor');
                    $('#proveedorModal').modal('show');
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: response.message || 'No se pudo cargar el proveedor',
                    });
                }
            },
        });
    });

    // Manejar el clic en el botón de deshabilitar/habilitar
    $('#proveedoresTable tbody').on('click', '.toggle-status-btn', function() {
        const proveedorId = $(this).data('id');
        const currentStatus = $(this).data('status');
        const newStatus = currentStatus === 'habilitado' ? 'deshabilitado' : 'habilitado';

        Swal.fire({
            title: `¿Está seguro de que desea ${newStatus === 'habilitado' ? 'habilitar' : 'deshabilitar'} este proveedor?`,
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: `Sí, ${newStatus === 'habilitado' ? 'habilitar' : 'deshabilitar'}`,
            cancelButtonText: "Cancelar"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrProveedores.php',
                    type: 'POST',
                    data: { action: 'toggleStatusProveedor', proveedor_id: proveedorId, estado: newStatus },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: newStatus === 'habilitado' ? 'Habilitado' : 'Deshabilitado',
                                text: `El proveedor ha sido ${newStatus === 'habilitado' ? 'habilitado' : 'deshabilitado'} correctamente`,
                                confirmButtonText: 'Aceptar'
                            }).then(() => {
                                proveedoresTable.ajax.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.message || `Error al ${newStatus === 'habilitado' ? 'habilitar' : 'deshabilitar'} el proveedor`,
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