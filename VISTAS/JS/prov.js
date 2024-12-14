$(document).ready(function () {
    const proveedoresTable = $('#proveedoresTable').DataTable({
        ajax: {
            url: '../AJAX/ctrProveedores.php',
            type: 'POST',
            data: { action: 'getProveedores' },
            dataSrc: 'data',
        },
        columns: [
            { data: 'proveedor_id' },
            { data: 'nombre_empresa' },
            { data: 'representante' },
            { data: 'correo' },
            { data: 'telefono' },
            { data: 'fecha_reg' },
            {
                data: null,
                render: function (data) {
                    return `
                        <button class="btn btn-warning btn-edit" data-id="${data.proveedor_id}">Editar</button>
                        <button class="btn btn-danger btn-delete" data-id="${data.proveedor_id}">Eliminar</button>
                    `;
                },
            },
        ],
    });

  // Botón para abrir el modal para agregar un nuevo proveedor
  $('#addProveedorButton').on('click', function () {
    $('#proveedorForm')[0].reset();
    $('#proveedor_id').val('');
    $('#proveedorModalLabel').text('Registrar Proveedor');
    $('#proveedorModal').modal('show');
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
      correo: $('#correo').val(),
      telefono: $('#telefono').val(),
    };

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
  });

  // Botón para editar un proveedor
  $('#proveedoresTable tbody').on('click', '.btn-edit', function () {
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
