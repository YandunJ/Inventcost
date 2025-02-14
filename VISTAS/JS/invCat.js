$(document).ready(function () {


    $(document).ready(function(){
        $('#helpButton').click(function(){
            $('#customHelp').fadeToggle();
        });
    });
    // Cargar categorías al iniciar
    $.ajax({
        url: "../AJAX/ctrInvCatalogo.php",
        type: "POST",
        data: { action: 'getCategorias' },
        dataType: "json",
        success: function (response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = "<option value=''>Seleccione una categoría</option>";
                response.data.slice(0, 3).forEach(function (categoria) { // Solo las primeras tres categorías
                    options += `<option value="${categoria.ctg_id}">${categoria.ctg_nombre}</option>`;
                });
                $("#categoria_select").html(options);
            } else {
                console.error("Error al cargar categorías: ", response);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });



    // Cargar todas las unidades de medida inicialmente
    let allUnits = [];
    $.ajax({
        url: "../AJAX/ctrInvCatalogo.php",
        type: "POST",
        data: { action: 'getUnidadesMedida' },
        dataType: "json",
        success: function (response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                allUnits = response.data; // Guardar unidades en memoria
                let options = "<option value=''>Seleccione una unidad</option>";
                response.data.forEach(function (unidad) {
                    options += `<option value="${unidad.prs_id}">${unidad.prs_nombre}</option>`;
                });
                $("#unidad_medida").html(options);
            } else {
                console.error("Error al cargar unidades de medida: ", response);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    // Cambiar las unidades de medida según la categoría seleccionada
    $("#categoria_select").on("change", function () {
        const selectedCategory = $(this).val();
        let filteredUnits = [];

        if (selectedCategory === "1") { // Materia Prima
            filteredUnits = allUnits.filter(unit => unit.prs_nombre === "KILOGRAMOS");
        } else {
            filteredUnits = allUnits; // Mostrar todas las unidades para otras categorías
        }

        // Actualizar el select de unidades de medida
        let options = "<option value=''>Seleccione una unidad</option>";
        filteredUnits.forEach(function (unidad) {
            options += `<option value="${unidad.prs_id}">${unidad.prs_nombre}</option>`;
        });
        $("#unidad_medida").html(options);
    });


    var table = $('#inventoryTable').DataTable({
        "ajax": {
            "url": "../AJAX/ctrInvCatalogo.php",
            "type": "POST",
            "data": { action: "obtenerArticulos" },
            "dataSrc": function(json) {
                console.log(json); // Verificar qué datos llegan del servidor
                return json.data;
            }
        },
        "columns": [
                     // Asegúrate de que "cat_id" existe en el SP
            { "data": "cat_nombre" },         // Asegúrate de que "cat_nombre" existe en el SP
               // Asegúrate de que "cat_descripcion" existe en el SP
            { "data": "categoria" },          // Alias definido en el SP
            { "data": "presentacion" },         // Alias para unidad_medida definido en el SP
            { "data": "cat_estado" },         // Asegúrate de que "cat_estado" existe en el SP
            { "data": "cat_fecha_creacion" }, // Asegúrate de que "cat_fecha_creacion" existe en el SP
            
            {
                "data": null,
                "render": function(data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                          <a class="dropdown-item edit-btn" href="#" data-id="${row.cat_id}" data-toggle="modal" data-target="#modalFormulario" data-action="edit">
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
    

  // Manejar la acción de agregar 
  $('#inventoryForm').on('submit', function (e) {
    e.preventDefault();

    let id_articulo = $('#id_articulo').val();
    let action = id_articulo && id_articulo !== "0" ? 'updateArticulo' : 'addArticulo';

    let formData = {
        action: action,
        id_articulo: id_articulo,
        nombre: $('#nombre').val(),
        id_categoria: $('#categoria_select').val(),
        unidad_medida: $('#unidad_medida').val()
    };

    $.ajax({
        url: '../AJAX/ctrInvCatalogo.php',
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                Swal.fire('Éxito', response.message, 'success');
                
                // Limpiar formulario después de operación exitosa
                $('#inventoryForm')[0].reset();
                $('#id_articulo').val('0');
                
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
$('#inventoryTable').on('click', '.edit-btn', function () {
    console.log("Abrir modal para editar");
    let id_articulo = $(this).data('id');
    console.log("ID del artículo a editar:", id_articulo);

    // Cambiar título del modal
    $('#modalFormularioLabel').text('Editar Insumo');

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
        
                // Verificar que todos los datos estén presentes
                console.log(data); // Debug para ver el objeto devuelto
        
                // Llenar los campos del formulario
                $('#id_articulo').val(data.cat_id || ''); // Evitar valores nulos
                $('#nombre').val(data.cat_nombre || '');
                $('#categoria_select').val(data.ctg_id || '').trigger('change');
                $('#unidad_medida').val(data.prs_id || '').trigger('change');
        
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

// Detectar acción y cambiar el título del modal
$('#modalFormulario').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // Botón que activó el modal
    var action = button.data('action'); // Extraer acción (add o edit)

    if (action === 'edit') {
        $('#modalFormularioLabel').text('Editar Insumo');
    } else {
        $('#modalFormularioLabel').text('Agregar Insumo');
    }
});

// Limpiar campos al cerrar el modal
$('#modalFormulario').on('hidden.bs.modal', function () {
    $('#inventoryForm')[0].reset(); // Reinicia todos los campos
    $('#categoria_select').val('').trigger('change');
    $('#unidad_medida').val('').trigger('change');
    $('#id_articulo').val('0'); // Resetear campo oculto
    $('#modalFormularioLabel').text('Agregar Insumo'); // Resetear título por defecto
});



// // Eliminar artículo de inventario
// $('#inventoryTable tbody').on('click', '.delete-btn', function () {
//     var idArticulo = $(this).data('id'); // Obtiene el ID del artículo del botón

//     // Confirmación antes de proceder con la eliminación
//     Swal.fire({
//         title: '¿Estás seguro?',
//         text: 'Esta acción eliminará permanentemente el artículo del catálogo.',
//         icon: 'warning',
//         showCancelButton: true,
//         confirmButtonColor: '#3085d6',
//         cancelButtonColor: '#d33',
//         confirmButtonText: 'Sí, eliminar',
//         cancelButtonText: 'Cancelar'
//     }).then((result) => {
//         if (result.isConfirmed) {
//             $.ajax({
//                 url: '../AJAX/ctrInvCatalogo.php',
//                 type: 'POST',
//                 data: {
//                     action: 'deleteArticulo',
//                     articulo_id: idArticulo
//                 },
//                 dataType: 'json',
//                 success: function (response) {
//                     if (response.status === 'success') {
//                         Swal.fire(
//                             'Eliminado!',
//                             response.message,
//                             'success'
//                         );
//                         $('#inventoryTable').DataTable().ajax.reload(); // Recargar la tabla
//                     } else {
//                         Swal.fire({
//                             icon: 'error',
//                             title: 'Error',
//                             text: response.message
//                         });
//                     }
//                 },
//                 error: function (jqXHR, textStatus, errorThrown) {
//                     Swal.fire({
//                         icon: 'error',
//                         title: 'Error en la solicitud',
//                         text: 'No se pudo procesar la solicitud. Intenta nuevamente.'
//                     });
//                     console.error('AJAX Error:', textStatus, errorThrown);
//                 }
//             });
//         }
//     });
// });


   
});

