$(document).ready(function() {
    // Cargar proveedores
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: "POST",
        data: { action: 'cargarProveedores' },
        dataType: "json",
        success: function(response) {
            let options = '<option value="">Seleccione proveedor</option>';
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

    // Cargar frutas de forma independiente
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: "POST",
        data: { action: 'cargarFrutas' },
        dataType: "json",
        success: function(response) {
            let options = '<option value="">Seleccione fruta</option>';
            if (response.status === 'success' && Array.isArray(response.data)) {
                response.data.forEach(function(fruta) {
                    options += `<option value="${fruta.cat_id}">${fruta.cat_nombre}</option>`;
                });
                $("#cat_id").html(options);
            } else {
                alert("Error al cargar las frutas.");
                console.error("Error loading frutas: ", response);
            }
        },
        error: function(xhr, status, error) {
            alert("Ocurrió un error al cargar las frutas.");
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });



    $(document).ready(function () {
        // Función genérica para actualizar los valores
        function updateQuantity(amount, inputId, step) {
            const inputField = document.getElementById(inputId);
            if (!inputField) return;
    
            const minValue = parseFloat(inputField.getAttribute('min')) || 0;
            const currentValue = parseFloat(inputField.value) || minValue;
    
            // Calcula el nuevo valor
            const newValue = Math.max(currentValue + (amount * step), minValue);
            inputField.value = newValue.toFixed(step === 1 ? 0 : 2);
    
            // Dispara el evento de entrada para actualizaciones dinámicas
            inputField.dispatchEvent(new Event('input'));
        }
    
        // Incremento y decremento de valores
        $(".btn-minus, .btn-plus").on("click", function () {
            const inputId = $(this).siblings("input").attr("id");
            const step = $(this).hasClass("quantity-decimal") ? 0.01 : 1;
            const amount = $(this).hasClass("btn-plus") ? 1 : -1;
            updateQuantity(amount, inputId, step);
        });
    
        // Calcular Precio Unitario dinámicamente
        $('#cantidad_ingresada, #precio_total').on('input', function () {
            const cantidad = parseFloat($('#cantidad_ingresada').val()) || 1; // Evitar división por 0
            const precioTotal = parseFloat($('#precio_total').val()) || 0;
            const precioUnitario = precioTotal / cantidad;
            $('#precio_unitario').val(precioUnitario.toFixed(2));
        });
    });
    
        
// Inicializar DataTable
const materiaPrimasTable = $('#tablaMateriaPrimas').DataTable({
    ajax: {
        url: '../AJAX/ctrInvFrutas.php',
        type: 'POST',
        data: { action: 'cargarMateriaPrima' },
        dataSrc: function (json) {
            if (json.status === 'success') {
                return json.data;
            } else {
                Swal.fire('Error', json.message || 'Error al cargar los datos.', 'error');
                return [];
            }
        }
    },
    columns: [
        { data: 'Lote' },
        { data: 'Proveedor' },
        { data: 'Artículo' },
        { data: 'unidad_medida' },
        { data: 'cantidad_ingresada' },
        { data: 'Cantidad_Disponible' },
        { data: 'precio_unitario' },
        { data: 'Precio_Total' },
        { data: 'Estado' },
        {
            data: null,
            render: function (data, type, row) {
                return `
                    <div class="btn-group">
                        <button class="btn btn-secondary dropdown-toggle btn-sm" data-toggle="dropdown">
                            <i class="fas fa-cog"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item details-btn" href="#" data-id="${row.ID}">
                                <i class="fas fa-info-circle"></i> Detalles
                            </a>
                            <a class="dropdown-item edit-btn" href="#" data-id="${row.ID}">
                                <i class="fas fa-edit"></i> Editar
                            </a>
                            <a class="dropdown-item delete-btn" href="#" data-id="${row.ID}">
                                <i class="fas fa-trash-alt"></i> Eliminar
                            </a>
                        </div>
                    </div>
                `;
            }
        }
    ]
    ,
        language: dataTableLanguage
});

    $('#tablaMateriaPrimas').on('click', '.details-btn', function() {
        const loteID = $(this).data('id');
        cargarDetallesLote(loteID);
    });
    function cargarDetallesLote(loteID) {
        $.ajax({
            url: '../AJAX/ctrInvFrutas.php',
            type: 'POST',
            data: { action: 'obtenerDetalleLote', lote_id: loteID },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    // Llenar el modal con los datos recibidos
                    $('#detalleFecha').text(response.data.Fecha);
                    $('#detalleHora').text(response.data.Hora);
                    $('#detalleLote').text(response.data.Numero_Lote);
                    $('#detalleProveedor').text(response.data.Proveedor);
                    $('#detalleArticulo').text(response.data.Artículo);
                    $('#detalleCantidadIngresada').text(response.data.Cantidad_Ingresada); // Nuevo
                    $('#detalleCantidadRestante').text(response.data.Cantidad_Restante);
                    $('#detalleUnidadMedida').text(response.data.Unidad_Medida); // Nuevo
                    $('#detallePresentacion').text(response.data.Presentación); // Nuevo
                    $('#detallePrecioUnitario').text(response.data.Precio_Unitario); // Nuevo
                    $('#detallePrecioTotal').text(response.data.Precio_Total);
                    $('#detalleEstado').text(response.data.Estado);
                    $('#detalleBrix').text(response.data.Brix);
                    $('#detallePesoUnitario').text(response.data.Peso_Unitario);
                    $('#detalleBultos').text(response.data.Bultos_Canastas);
                    $('#detalleObservacion').text(response.data.Observación);
                    $('#detalleAprobacion').text(response.data.Aprobación);
    
                    // Mostrar el modal
                    $('#detalleModal').modal('show');
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function() {
                alert('Error en la solicitud AJAX.');
            }
        });
    }
    

 
// Abrir el modal y manejar lógica de nuevo registro
$('button[data-is-new="true"]').on('click', function () {
    const isNew = $(this).data('is-new'); // Indicar que es un nuevo registro

    if (isNew) {
        // Limpiar el formulario y solicitar un nuevo lote
        $('#materiaPrimaForm')[0].reset(); 
        $('#numero_lote').val(''); // Limpia el campo lote

        // Solicitar el nuevo número de lote al backend
        $.ajax({
            url: "../AJAX/ctrInvFrutas.php",
            type: 'POST',
            data: { action: 'generarNumeroLote' },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    $('#numero_lote').val(response.numero_lote); // Llenar con el nuevo lote
                } else {
                    Swal.fire('Error', response.message || 'Error al generar el número de lote', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'Error al comunicarse con el servidor', 'error');
            }
        });
    }

    // Cambiar el texto del botón para diferenciar acciones
    $('.form-actions .btn-primary').text('Guardar').data('isEditing', false);
    $('#Form_MP').data('isEditing', false);

    // Mostrar el modal
    $('#Form_MP').modal('show');
});


    
// Cargar datos al hacer clic en el botón Editar
$('#tablaMateriaPrimas').on('click', '.edit-btn', function () {
    const id_inv = $(this).data('id');

    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: 'POST',
        data: { action: 'obtenerMateriaPrima', id_inv: id_inv },
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                const data = response.data;

                // Llenar el formulario con los datos del registro
                $('#materiaPrimaForm').find('#id_inv').val(data.id_inv);
                $('#materiaPrimaForm').find('#fecha').val(data.fecha);
                $('#materiaPrimaForm').find('#hora').val(data.hora);
                $('#materiaPrimaForm').find('#cat_id').val(data.cat_id);
                $('#materiaPrimaForm').find('#proveedor_id').val(data.proveedor_id);
                $('#materiaPrimaForm').find('#numero_lote').val(data.numero_lote).prop('readonly', true); // Lote sin cambios
                $('#materiaPrimaForm').find('#cantidad_ingresada').val(data.cantidad_ingresada);
                $('#materiaPrimaForm').find('#precio_unitario').val(data.precio_unitario);
                $('#materiaPrimaForm').find('#brix').val(data.brix);
                $('#materiaPrimaForm').find('#presentacion').val(data.presentacion);
                $('#materiaPrimaForm').find('#bultos_o_canastas').val(data.bultos_o_canastas);
                $('#materiaPrimaForm').find('#peso_unitario').val(data.peso_unitario);
                $('#materiaPrimaForm').find('#observacion').val(data.observacion);

                // Cambiar texto del botón para editar
                $('.form-actions .btn-primary').text('Guardar cambios').data('isEditing', true);
                $('#Form_MP').data('isEditing', true);

                // Mostrar el modal
                $('#Form_MP').modal('show');
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'Ocurrió un error al obtener los datos.', 'error');
        }
    });
});


// Enviar el formulario para agregar o actualizar la materia prima
$('.form-actions .btn-primary').on('click', function (event) {
    event.preventDefault();

    const $form = $('#materiaPrimaForm');
    const isEditing = $('#Form_MP').data('isEditing');
    const action = isEditing ? 'actualizarMateriaPrima' : 'guardarMateriaPrima';

    // No tocar el número de lote en edición
    if (isEditing) {
        $('#numero_lote').prop('readonly', false); // Permite enviarlo al backend
    }

    $.ajax({
        url: '../AJAX/ctrInvFrutas.php',
        type: 'POST',
        data: $form.serialize() + `&action=${action}`,
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                Swal.fire(
                    'Éxito',
                    isEditing ? 'Registro actualizado correctamente' : 'Registro agregado correctamente',
                    'success'
                ).then(() => {
                    $('#Form_MP').modal('hide');
                    materiaPrimasTable.ajax.reload();
                });
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'Ocurrió un error al guardar los datos.', 'error');
        }
    });
});


// Al hacer clic en el botón Eliminar
$('#tablaMateriaPrimas').on('click', '.delete-btn', function() {
    const id_inv = $(this).data('id'); // Cambiado a id_inv
    Swal.fire({
        title: '¿Estás seguro de que deseas eliminar este registro?',
        text: "Esta acción no se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '../AJAX/ctrInvFrutas.php',
                type: 'POST',
                data: { action: 'eliminarMateriaPrima', id_inv: id_inv }, // Cambiado a id_inv
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        Swal.fire(
                            'Eliminado!',
                            'El registro ha sido eliminado.',
                            'success'
                        );
                        materiaPrimasTable.ajax.reload();
                    } else {
                        Swal.fire('Error', response.message, 'error');
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire('Error', 'Ocurrió un error al eliminar el registro.', 'error');
                    console.error("Error: ", error);
                    console.error("Response: ", xhr.responseText);
                }
            });
        }
    });
});

    
        // let formModified = false;

        // // Detectar cambios en el formulario
        // $("#materiaPrimaForm input, #materiaPrimaFormselect").on("input change", function() {
        //     formModified = true;
        // });
        
        // // Evento beforeunload para detectar si se intenta cerrar o recargar la página
        // window.addEventListener("beforeunload", function(e) {
        //     if (formModified) {
        //         const confirmationMessage = "Tienes datos sin guardar. ¿Estás seguro de que deseas salir?";
        //         e.returnValue = confirmationMessage; // Establece el mensaje
        //         return confirmationMessage;
        //     }
        // });
        
        // Capturar clics en el menú lateral
        // $("a").on("click", function(e) {
        //     if (formModified) {
        //         e.preventDefault(); // Prevenir la navegación
        //         Swal.fire({
        //             title: "Tienes datos sin guardar",
        //             text: "¿Estás seguro de que deseas salir sin guardar?",
        //             icon: "warning",
        //             showCancelButton: true,
        //             confirmButtonText: "Sí, salir",
        //             cancelButtonText: "Cancelar"
        //         }).then((result) => {
        //             if (result.isConfirmed) {
        //                 window.location.href = $(this).attr("href"); // Redirigir si confirma
        //             }
        //         });
        //     }
        // });
        
        // El botón de cancelar regresa a la página anterior
       // El botón de cancelar regresa a la página anterior
            $("#cancelarBtn").on("click", function() {

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
