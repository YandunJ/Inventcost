$(document).ready(function () {
    // Inicializar el DataTable
    var table = $('#costTable').DataTable({
        "ajax": {
            "url": "../AJAX/ctrCost.php",
            "type": "POST",
            "data": { action: "obtenerCostos" },
            "dataSrc": function (json) {
                return json.data;
            }
        },
        "columns": [
            
            { "data": "cat_nombre" },
            { "data": "categoria" },
            { "data": "cat_estado" },
            { "data": "cat_fecha_creacion" },
            {
                "data": null,
                "render": function (data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item edit-btn" href="#" data-id="${row.cat_id}">
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

    // Cargar categorías al iniciar
    $.ajax({
        url: "../AJAX/ctrCost.php",
        type: "POST",
        data: { action: 'getCategorias' },
        dataType: "json",
        success: function (response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = "<option value=''>Seleccione una categoría</option>";
                response.data.forEach(function (categoria) {
                    options += `<option value="${categoria.ctg_id}">${categoria.ctg_nombre}</option>`;
                });
                $("#categoria").html(options);
            } else {
                console.error("Error al cargar categorías: ", response);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    // Manejar la acción de agregar 
    $('#costForm').on('submit', function (e) {
        e.preventDefault();

        let id_costo = $('#id_costo').val();
        let action = id_costo && id_costo !== "0" ? 'updateCosto' : 'addCosto';

        let formData = {
            action: action,
            id_costo: id_costo,
            nombre: $('#nombre').val(),
            categoria: $('#categoria').val(),
            estado: $('#estado').is(':checked') ? 'habilitado' : 'deshabilitado'
        };

        $.ajax({
            url: '../AJAX/ctrCost.php',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    Swal.fire('Éxito', response.message, 'success');
                    
                    // Limpiar formulario después de operación exitosa
                    $('#costForm')[0].reset();
                    $('#id_costo').val('0');
                    
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

    // Cargar datos en el formulario al editar
    $('#costTable').on('click', '.edit-btn', function () {
        let id_costo = $(this).data('id');
        $('#modalFormularioLabel').text('Editar Costo');

        // AJAX para cargar datos del costo
        $.ajax({
            url: '../AJAX/ctrCost.php',
            type: 'POST',
            data: {
                action: 'getCostoById',
                id_costo: id_costo
            },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    let data = response.data;
            
                    // Llenar los campos del formulario
                    $('#id_costo').val(data.cat_id || ''); // Evitar valores nulos
                    $('#nombre').val(data.cat_nombre || '');
                    $('#categoria').val(data.ctg_id || '').trigger('change');
                    $('#estado').prop('checked', data.cat_estado === 'habilitado');
            
                    $('#modalFormulario').modal('show');
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'No se pudo cargar el costo.', 'error');
            }
        });
    });

    // Abrir el modal para agregar
    $('#modalFormulario').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Botón que activó el modal
        var action = button.data('action'); // Extraer información de los datos del botón

        if (action === 'edit') {
            $('#modalFormularioLabel').text('Editar Costo');
        } else {
            $('#modalFormularioLabel').text('Agregar Costo');
        }
    });

    // Limpiar campos al cerrar el modal
    $('#modalFormulario').on('hidden.bs.modal', function () {
        $('#costForm')[0].reset(); // Reinicia todos los campos
        $('#categoria').val('').trigger('change');
        $('#id_costo').val('0'); // Resetear campo oculto
        $('#modalFormularioLabel').text('Agregar Costo'); // Resetear título por defecto
    });

    // Cambiar el texto del estado según el checkbox
    const estadoCheckbox = document.getElementById("estado");
    const estadoText = document.getElementById("estado-text");

    estadoCheckbox.addEventListener("change", () => {
        if (estadoCheckbox.checked) {
            estadoText.textContent = "Habilitado";
            estadoText.style.color = "#4CAF50";
        } else {
            estadoText.textContent = "Deshabilitado";
            estadoText.style.color = "#FF0000";
        }
    });
});