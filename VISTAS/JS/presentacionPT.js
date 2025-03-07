$(document).ready(function () {
    // Inicializar DataTables
    var table = $('#presentacionTable').DataTable({
        "ajax": {
            "url": "../AJAX/ctrPrsPT.php",
            "type": "POST",
            "data": { action: "obtenerPresentacionesPT" },
            "dataSrc": function (json) {
                console.log(json); // Verificar qué datos llegan del servidor
                return json;
            }
        },
        "columns": [
            { "data": "prs_nombre" },         // Nombre de la presentación
            { "data": "equivalencia" },       // Equivalencia de la presentación
            {
                "data": null,
                "render": function (data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item edit-btn" href="#" data-id="${row.prs_id}" data-toggle="modal" data-target="#modalFormulario" data-action="edit">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                            </div>
                        </div>
                    `;
                }
            }
        ],
        "language": dataTableLanguage
    });

    // Mostrar mensaje de advertencia al abrir el modal
    $('#modalFormulario').on('show.bs.modal', function () {
        $('#alertaEquivalencia').fadeIn();
        setTimeout(function () {
            $('#alertaEquivalencia').fadeOut();
        }, 10000); // Mostrar el mensaje durante 10 segundos
    });

    // Cargar datos en el formulario al editar
    $('#presentacionTable').on('click', '.edit-btn', function () {
        let prs_id = $(this).data('id');

        // Cambiar título del modal
        $('#modalFormularioLabel').text('Editar Presentación de Producto Terminado');

        // AJAX para cargar datos de la presentación
        $.ajax({
            url: '../AJAX/ctrPrsPT.php',
            type: 'POST',
            data: {
                action: 'obtenerPresentacionPorId',
                prs_id: prs_id
            },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    let data = response.data;

                    // Llenar los campos del formulario
                    $('#prs_id').val(data.prs_id || ''); // Evitar valores nulos
                    $('#prs_nombre').val(data.prs_nombre || '');
                    $('#equivalencia').val(data.equivalencia || '');

                    $('#modalFormulario').modal('show');
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'No se pudo cargar la presentación.', 'error');
            }
        });
    });

    // Manejar la acción de agregar o editar
    $('#presentacionForm').on('submit', function (e) {
        e.preventDefault();

        let prs_id = $('#prs_id').val();
        let action = prs_id && prs_id !== "0" ? 'updatePresentacion' : 'addPresentacion';

        let formData = {
            action: action,
            prs_id: prs_id,
            prs_nombre: $('#prs_nombre').val(),
            equivalencia: $('#equivalencia').val()
        };

        $.ajax({
            url: '../AJAX/ctrPrsPT.php',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    Swal.fire('Éxito', response.message, 'success');

                    // Limpiar formulario después de operación exitosa
                    $('#presentacionForm')[0].reset();
                    $('#prs_id').val('0');

                    $('#modalFormulario').modal('hide');
                    table.ajax.reload();
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'Ocurrió un error al procesar la solicitud.', 'error');
            }
        });
    });

    // Limpiar campos al cerrar el modal
    $('#modalFormulario').on('hidden.bs.modal', function () {
        $('#presentacionForm')[0].reset(); // Reinicia todos los campos
        $('#prs_id').val('0'); // Resetear campo oculto
        $('#modalFormularioLabel').text('Agregar Presentación de Producto Terminado'); // Resetear título por defecto
    });
});