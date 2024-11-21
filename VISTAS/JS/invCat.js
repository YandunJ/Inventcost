$(document).ready(function() {
        
    $(document).ready(function() {
        // Cargar categorías en el select box
        $.ajax({
            url: "../AJAX/ctrInvCatalogo.php",
            type: "POST",
            data: { action: 'getCategorias' },
            dataType: "json",
            success: function(response) {
                if (Array.isArray(response)) {
                    let options = "";
                    response.forEach(function(categoria) {
                        options += `<option value="${categoria.id_categoria}">${categoria.nombre_categoria}</option>`;
                    });
                    $("#categoria_select").html(options);
                } else {
                    console.error("Error loading categories: ", response);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });
    
    
    $(document).ready(function() {
        // Cargar unidades de medida en el select box
        $.ajax({
            url: "../AJAX/ctrInvCatalogo.php",
            type: "POST",
            data: { action: 'getUnidadesMedida' },
            dataType: "json",
            success: function(response) {
                if (Array.isArray(response)) {
                    let options = "<option value=''>Seleccione una unidad</option>";
                    response.forEach(function(unidad) {
                        options += `<option value="${unidad.uni_id}">${unidad.uni_nombre}</option>`;
                    });
                    $("#unidad_medida").html(options);
                } else {
                    console.error("Error loading units of measure: ", response);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });
    
    
    
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
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
                "defaultContent": `
                    <button class="editItem btn btn-warning btn-sm">Editar</button>
                    <button class="deleteArticle btn btn-danger btn-sm">Eliminar</button>
                `
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
// Manejar la acción de agregar o actualizar artículo
$('#inventoryForm').on('submit', function(e) {
    e.preventDefault();

    // Obtenemos los valores del formulario
    let id_articulo = $('#id_articulo').val();
    let nombre = $('#nombre').val();
    let descripcion = $('#descripcion').val();
    let id_categoria = $('#categoria_select').val();
    let unidad_medida = $('#unidad_medida').val();
    
    // Acción a enviar: agregar o actualizar
    let action = id_articulo == 0 ? 'addArticulo' : 'addArticulo';
    let opcion = id_articulo == 0 ? 1 : 2; // opción 1 para inserción, 2 para actualización

    // Configuramos los datos para la petición AJAX
    let formData = {
        action: action,
        opcion: opcion,
        id_articulo: id_articulo,
        nombre: nombre,
        descripcion: descripcion,
        id_categoria: id_categoria,
        unidad_medida: unidad_medida
    };

    $.ajax({
        url: '../AJAX/ctrInvCatalogo.php',
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                Swal.fire({
                    icon: 'success',
                    title: id_articulo == 0 ? 'Artículo registrado' : 'Artículo actualizado',
                    text: response.message
                });
                // Resetear el formulario
                $('#inventoryForm')[0].reset();
                $('#id_articulo').val(0); // Reseteamos el id a 0 (modo de inserción)
                $('#formSubmitButton').text('Agregar Artículo');
                // Recargar la tabla de inventario
                $('#inventoryTable').DataTable().ajax.reload();
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: response.message
                });
            }
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: 'error',
                title: 'Error en la solicitud',
                text: 'Error en la solicitud AJAX: ' + status
            });
        }
    });
});

$('#inventoryTable').on('click', '.editItem', function() {
    let data = table.row($(this).parents('tr')).data();
    
    // Cargar datos en los campos del formulario
    $('#id_articulo').val(data.id_articulo);
    $('#nombre').val(data.nombre_articulo);
    $('#descripcion').val(data.descripcion);
    $('#categoria_select').val(data.id_categoria);
    $('#unidad_medida').val(data.unidad_medida);

    // Cambiar el texto del botón de enviar para reflejar "Actualizar"
    $('#formSubmitButton').text('Actualizar Artículo');
    editing = true;
});


// Eliminar artículo de inventario
$('#inventoryTable tbody').on('click', 'button', function() {
    var action = $(this).hasClass('deleteArticle') ? 'delete' : 'edit';
    var data = table.row($(this).parents('tr')).data();

    if (action === 'delete') {
        // Confirmación antes de eliminar
        Swal.fire({
            title: '¿Estás seguro?',
            text: 'Estás a punto de eliminar este artículo de inventario.',
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
                    data: { action: 'deleteArticulo', articulo_id: data.id_articulo },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire(
                                'Eliminado!',
                                'El artículo fue eliminado correctamente.',
                                'success'
                            );
                            table.ajax.reload(); // Recarga la tabla para reflejar los cambios
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.message
                            });
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error en la solicitud AJAX:', textStatus, errorThrown);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error en la solicitud',
                            text: 'Error en la solicitud AJAX: ' + textStatus
                        });
                    }
                });
            }
        });
    }
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

