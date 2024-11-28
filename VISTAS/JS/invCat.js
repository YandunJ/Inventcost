$(document).ready(function() {
        
    $.ajax({
        url: "../AJAX/ctrInvCatalogo.php",
        type: "POST",
        data: { action: 'getCategorias' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = "<option value=''>Seleccione una categoría</option>";
                response.data.forEach(function(categoria) {
                    options += `<option value="${categoria.id_categoria}">${categoria.nombre_categoria}</option>`;
                });
                $("#categoria_select").html(options);
            } else {
                console.error("Error al cargar categorías: ", response);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });
    
    
    
        // Cargar unidades de medida en el select box
        $.ajax({
            url: "../AJAX/ctrInvCatalogo.php",
            type: "POST",
            data: { action: 'getUnidadesMedida' },
            dataType: "json",
            success: function(response) {
                if (response.status === 'success' && Array.isArray(response.data)) {
                    let options = "<option value=''>Seleccione una unidad</option>";
                    response.data.forEach(function(unidad) {
                        options += `<option value="${unidad.uni_id}">${unidad.uni_nombre}</option>`;
                    });
                    $("#unidad_medida").html(options);
                } else {
                    console.error("Error al cargar unidades de medida: ", response);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
        
    
    
    $.ajax({
        url: "../AJAX/ctrInvCatalogo.php",
        type: "POST",
        data: { action: 'cargarProveedores' },
        dataType: "json",
        success: function(response) {
            let options = '<option value="">Seleccione un proveedor</option>';
            if (response.status === 'success' && Array.isArray(response.data)) {
                response.data.forEach(function(proveedor) {
                    options += `<option value="${proveedor.proveedor_id}">${proveedor.nombre_empresa}</option>`;
                });
                $("#proveedor_id").html(options);
            } else {
                alert("Error al cargar los proveedores.");
                console.error("Error loading proveedores: ", response);
            }
        },
        error: function(xhr, status, error) {
            alert("Ocurrió un error al cargar los proveedores.");
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    var table = $('#inventoryTable').DataTable({
        "ajax": {
            "url": "../AJAX/ctrInvCatalogo.php",
            "type": "POST",
            "data": { action: "obtenerArticulos" }, // Corregido
            "dataSrc": function(json) {
                console.log(json);  // Verifica qué se está recibiendo desde el servidor
                return json.data;
            }
        },
        "columns": [
            { "data": "id_articulo" },
            { "data": "nombre_articulo" },
            { "data": "descripcion" },
            { "data": "categoria" }, // Cambiado para usar el alias 'categoria'
            { "data": "proveedor" },
            { "data": "unidad_medida" },
             // Cambiado para usar el alias 'unidad_medida'
            { "data": "estado" },
            { "data": "fecha_creacion" },
            { "data": "stock" },
            {
                "data": null,
                "render": function(data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item   
     edit-btn" href="#" data-id="${row.id_articulo}">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                                <a class="dropdown-item delete-btn" href="#" data-id="${row.id_articulo}">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </a>
                            </div>
                        </div>
                    `;
                }
            }
        ]
    });

    var editing = false;
    var currentId = null;

     // Función para validar el nombre de la fruta
     function validateFruitName(name) {
        // Expresión regular para permitir solo letras y espacios
        var regex = /^[A-Za-z\s]+$/;
        return regex.test(name);
    }
  // Manejar la acción de agregar 
  $('#inventoryForm').on('submit', function (e) {
    e.preventDefault();

    let formData = {
        action: 'addArticulo',
        id_articulo: $('#id_articulo').val(),
        nombre: $('#nombre').val(),
        descripcion: $('#descripcion').val(),
        id_categoria: $('#categoria_select').val(),
        proveedor_id: $('#proveedor_id').val(),
        unidad_medida: $('#unidad_medida').val()
    };

    // Validar campos antes de enviar
    if (!formData.nombre || !formData.descripcion) {
        Swal.fire('Error', 'Los campos Nombre y Descripción son obligatorios.', 'error');
        return;
    }

    // Deshabilitar el botón de enviar para evitar múltiples envíos
    var submitButton = $(this).find('button[type="submit"]');
    submitButton.prop('disabled', true);

    $.ajax({
        url: '../AJAX/ctrInvCatalogo.php',
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                Swal.fire('Éxito', response.message, 'success');
                $('#inventoryForm')[0].reset();
                $('#modalFormulario').modal('hide');
                table.ajax.reload(); // Recargar la tabla de datos
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'Ocurrió un error al procesar la solicitud.', 'error');
        },
        complete: function() {
            // Volver a habilitar el botón después de completar la solicitud
            submitButton.prop('disabled', false);
        }
    });
});


// Cargar datos en el formulario al editar
$('#inventoryTable').on('click', '.edit-btn', function () {
    let id_articulo = $(this).data('id'); // Obtener el ID del artículo seleccionado

    // Cambiar título del modal
    $('#modalFormularioLabel').text('Editar Artículo');

    // AJAX para cargar datos del artículo
    $.ajax({
        url: '../AJAX/ctrInvCatalogo.php',
        type: 'POST',
        data: {
            action: 'getArticuloById',
            id_articulo: id_articulo
        },
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                let data = response.data;

                // Asignar valores al formulario
                $('#id_articulo').val(data.id_articulo);
                $('#nombre').val(data.nombre_articulo);
                $('#descripcion').val(data.descripcion);
                $('#categoria_select').val(data.id_categoria).trigger('change');
                $('#proveedor_id').val(data.proveedor_id).trigger('change');
                $('#unidad_medida').val(data.uni_id).trigger('change');

                // Mostrar el modal
                $('#modalFormulario').modal('show');
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'No se pudo cargar el artículo.', 'error');
        }
    });
});

$('#inventoryForm').on('submit', function (e) {
    e.preventDefault();

    let id_articulo = $('#id_articulo').val();
    let action = id_articulo == 0 ? 'addArticulo' : 'updateArticulo'; // Determinar acción

    // Realizar petición AJAX
    $.ajax({
        url: '../AJAX/ctrInvCatalogo.php',
        type: 'POST',
        data: $(this).serialize() + `&action=${action}`,
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                $('#modalFormulario').modal('hide');
                Swal.fire('Éxito', response.message, 'success');
                $('#inventoryTable').DataTable().ajax.reload();
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'No se pudo guardar el artículo.', 'error');
        }
    });
});


// Eliminar artículo de inventario
$('#inventoryTable tbody').on('click', '.delete-btn', function () {
    var idArticulo = $(this).data('id'); // Obtiene el ID del artículo del botón

    // Confirmación antes de proceder con la eliminación
    Swal.fire({
        title: '¿Estás seguro?',
        text: 'Esta acción eliminará permanentemente el artículo del catálogo.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '../AJAX/ctrInvCatalogo.php',
                type: 'POST',
                data: {
                    action: 'deleteArticulo',
                    articulo_id: idArticulo
                },
                dataType: 'json',
                success: function (response) {
                    if (response.status === 'success') {
                        Swal.fire(
                            'Eliminado!',
                            response.message,
                            'success'
                        );
                        $('#inventoryTable').DataTable().ajax.reload(); // Recargar la tabla
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: response.message
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error en la solicitud',
                        text: 'No se pudo procesar la solicitud. Intenta nuevamente.'
                    });
                    console.error('AJAX Error:', textStatus, errorThrown);
                }
            });
        }
    });
});


let formModified = false;

    // Detectar cambios en el formulario
    $("#fruitForm input, #fruitForm select").on("input change", function() {
        formModified = true;
    });

    // Evento beforeunload para detectar si se intenta cerrar o recargar la página
    window.addEventListener("beforeunload", function(e) {
        if (formModified) {
            const confirmationMessage = "Tienes datos sin guardar. ¿Estás seguro de que deseas salir?";
            e.returnValue = confirmationMessage; // Establece el mensaje
            return confirmationMessage;
        }
    });

    // Capturar clics en el menú lateral
    $("a").on("click", function(e) {
        if (formModified) {
            e.preventDefault(); // Prevenir la navegación
            Swal.fire({
                title: "Tienes datos sin guardar",
                text: "¿Estás seguro de que deseas salir sin guardar?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, salir",
                cancelButtonText: "Cancelar"
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = $(this).attr("href"); // Redirigir si confirma
                }
            });
        }
    });
      // El botón de cancelar regresa a la página anterior
      $("#cancelButton").on("click", function() {
        if (formModified) {
            Swal.fire({
                title: "Tienes datos sin guardar",
                text: "¿Estás seguro de que deseas salir sin guardar?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, salir",
                cancelButtonText: "Cancelar"
            }).then((result) => {
                if (result.isConfirmed) {
                    window.history.back(); // Regresa a la página anterior
                }
            });
        } else {
            window.history.back(); // Regresa a la página anterior
        }
    });
   
});

