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
// Cargar insumos de forma independiente
$.ajax({
    url: "../AJAX/ctrInvInsumos.php",
    type: "POST",
    data: { action: 'cargarInsumos' },
    dataType: "json",
    success: function (response) {
        let options = '<option value="">Seleccione insumo</option>';
        if (response.status === 'success' && Array.isArray(response.data)) {
            response.data.forEach(function (insumo) {
                options += `<option value="${insumo.cat_id}">${insumo.cat_nombre}</option>`;
            });
            $("#cat_id").html(options);
        } else {
            alert("Error al cargar los insumos.");
            console.error("Error loading insumos: ", response);
        }
    },
    error: function (xhr, status, error) {
        alert("Ocurrió un error al cargar los insumos.");
        console.error("Error: ", error);
        console.error("Response: ", xhr.responseText);
    }
});


    

    // Obtener unidad de medida al cambiar el insumo
    $('#cat_id').change(function() {
        let idArticulo = $(this).val();

        if (idArticulo) {
            $.ajax({
                url: "../AJAX/ctrInvInsumos.php",
                type: "POST",
                data: { action: 'obtenerUnidadMedida', id_articulo: idArticulo },
                dataType: "json",
                success: function(response) {
                    if (response.status === 'success') {
                        $('#unidad_medida').val(response.unidad_medida);
                    } else {
                        alert("Error al cargar la presentación.");
                        console.error("Error loading unit: ", response);
                    }
                },
                error: function(xhr, status, error) {
                    alert("Ocurrió un error al cargar la presentación.");
                    console.error("Error: ", error);
                    console.error("Response: ", xhr.responseText);
                }
            });
        } else {
            $('#unidad_medida').val(''); // Limpiar el campo si no hay selección
        }
    });


   
    $('#unidad_medida').on('change', function() {
        const unidad = $(this).val();
        const cantidadInput = $('#cantidad');

        if (unidad === 'u') {
            cantidadInput.attr('step', '1');
            cantidadInput.attr('min', '1');
            cantidadInput.val(Math.floor(cantidadInput.val())); // Redondear a entero si es necesario
        } else {
            cantidadInput.attr('step', 'any');
            cantidadInput.removeAttr('min');
        }
    });

    // Inicializar validación de cantidad al cargar la página
    $('#unidad_medida').trigger('change');

    
    $(document).ready(function () {
        function updateQuantity(amount, inputId, step) {
            const inputField = document.getElementById(inputId);
            if (!inputField) return;
            const minValue = parseFloat(inputField.getAttribute('min')) || 0;
            const currentValue = parseFloat(inputField.value) || minValue;
            const newValue = Math.max(currentValue + (amount * step), minValue);
            inputField.value = newValue.toFixed(step === 1 ? 0 : 2); // Enteros o decimales
            inputField.dispatchEvent(new Event('input')); // Disparar evento input
        }
    
        $(".btn-minus, .btn-plus").on("click", function () {
            const inputId = $(this).siblings("input").attr("id");
            const step = $(this).hasClass("quantity-decimal") ? 0.01 : 1;
            const amount = $(this).hasClass("btn-plus") ? 1 : -1;
            updateQuantity(amount, inputId, step);
        });
    
        // Calcular precio unitario dinámicamente
        $('#cantidad_ingresada, #precio_total').on('input', function () {
            const cantidad = parseFloat($('#cantidad_ingresada').val()) || 0;
            const precioTotal = parseFloat($('#precio_total').val()) || 0;
            const precioUnitario = cantidad > 0 ? (precioTotal / cantidad).toFixed(2) : 0;
            $('#precio_unitario').val(precioUnitario);
        });
    });
    
    
        
//    // Calcular el precio total
// $('#cantidad, #precio_unitario').on('input', function() {
//     const cantidad = parseFloat($('#cantidad').val()) || 0;
//     const precioUnitario = parseFloat($('#precio_unitario').val()) || 0;
//     const precioTotal = cantidad * precioUnitario;
//     $('#precio_total').val(precioTotal.toFixed(2));
// });

const insumosTable = $('#inventarioInsumosdt').DataTable({
    ajax: {
        url: '../AJAX/ctrInvInsumos.php',
        type: 'POST',
        data: { action: 'cargarInsumosTabla' },
        dataSrc: function (json) {
            if (json.status === 'success') {
                return json.data;
            } else {
                alert('Error: ' + json.message);
                return [];
            }
        }
    },
    columns: [
        { data: 'Lote' },
        { data: 'Proveedor' },
        { data: 'Insumo' },
        { data: 'Unidad_Medida' },
        { data: 'Cantidad' },
        { data: 'Cantidad_Restante' },
        { data: 'Precio_Unitario' },
        { data: 'Precio_Total' },
        { data: 'Presentacion' },
        { data: 'Estado' },
        {
            data: 'ID',
            render: function (data, type, row) {
                return `
                    <div class="btn-group">
                        <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-cog"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item edit-btn" href="#" data-id="${data}">
                                <i class="fas fa-edit"></i> Editar
                            </a>
                            <a class="dropdown-item delete-btn" href="#" data-id="${data}">
                                <i class="fas fa-trash-alt"></i> Eliminar
                            </a>
                        </div>
                    </div>
                `;
            }
        }
    ],
    language: dataTableLanguage // Lenguaje personalizado
});

// Abrir modal de nuevo registro
$('button[data-is-new="true"]').on('click', function () {
    const isNew = $(this).data('is-new'); // Indicar nuevo registro

    if (isNew) {
        $('#InsumosForm')[0].reset(); // Limpia el formulario
        $('#numero_lote').val(''); // Limpia el campo de lote

        // Solicitar un nuevo lote al backend
        $.ajax({
            url: "../AJAX/ctrInvInsumos.php",
            type: 'POST',
            data: { action: 'generarNumeroLote' },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    $('#numero_lote').val(response.numero_lote); // Rellena el campo con el lote generado
                } else {
                    Swal.fire('Error', response.message || 'No se pudo generar el número de lote', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'Problemas al comunicarse con el servidor.', 'error');
            }
        });
    }

    $('#submitInsumo').text('Registrar Insumo').data('isEditing', false); // Configura el botón
    $('#Form_Insumos').modal('show'); // Abre el modal
});

    
   // Al hacer clic en el botón Agregar/Actualizar
   $('#InsumosForm').on('submit', function(event) {
    event.preventDefault(); // Previene la recarga de la página
    const formData = $(this).serialize(); // Asegúrate de que los nombres coincidan en el formulario HTML

    Swal.fire({
        title: '¿Estás seguro de que deseas registrar este insumo?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Sí, continuar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: "../AJAX/ctrInvInsumos.php",
                type: "POST",
                data: formData + '&action=guardarInsumo',
                dataType: "json",
                success: function(response) {
                    if (response.status === 'success') {
                        Swal.fire('Éxito', 'Insumo registrado exitosamente.', 'success');
                        $('#InsumosForm')[0].reset();
                        insumosTable.ajax.reload(); // Recargar la tabla
                    } else {
                        Swal.fire('Error', response.message, 'error');
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire('Error', 'Ocurrió un error al procesar el insumo.', 'error');
                    console.error("Error: ", error);
                    console.error("Response: ", xhr.responseText);
                }
            });
        }
    });
});

    // Al hacer clic en el botón Editar
// Al editar un insumo
$('#inventarioInsumosdt').on('click', '.edit-btn', function () {
    const inventins_id = $(this).data('id');

    $.ajax({
        url: '../AJAX/ctrInvInsumos.php',
        type: 'POST',
        data: { action: 'cargarInsumoId', inventins_id: inventins_id },
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                const data = response.data;

                // Rellena los campos del formulario con los datos del insumo
                $('#id_inv').val(data.id_inv);
                $('#cat_id').val(data.cat_id);
                $('#proveedor_id').val(data.proveedor_id);
                $('#fecha').val(data.fecha);
                $('#hora').val(data.hora);
                $('#numero_lote').val(data.numero_lote).prop('readonly', true); // Lote inmutable
                $('#cantidad_ingresada').val(data.cantidad_ingresada);
                $('#presentacion').val(data.presentacion);
                $('#precio_unitario').val(data.precio_unitario);

                $('#submitInsumo').text('Actualizar Insumo').data('isEditing', true); // Configura el botón
                $('#Form_Insumos').modal('show'); // Abre el modal
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'No se pudo cargar el registro.', 'error');
        }
    });
});


    
    $('#submitInsumo').on('click', function() {
        const formData = {
            action: 'actualizarInsumo',
            id_inv: $('#id_inv').val(),
            cat_id: $('#cat_id').val(),
            proveedor_id: $('#proveedor_id').val(),
            fecha: $('#fecha').val(),
            hora: $('#hora').val(),
            numero_lote: $('#numero_lote').val(),
            cantidad_ingresada: $('#cantidad_ingresada').val(),
            presentacion: $('#presentacion').val(),
            precio_unitario: $('#precio_unitario').val()
        };
    
        $.ajax({
            url: '../AJAX/ctrInvInsumos.php',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Insumo actualizado correctamente.');
                    location.reload(); // Recarga la tabla de insumos
                } else {
                    alert('Error: ' + response.message);
                }
            }
        });
    });
    
    // Al hacer clic en el botón Eliminar
    $('#inventarioInsumosdt').on('click', '.delete-btn', function() {
        const id_inv = $(this).data('id');
    
        Swal.fire({
            title: '¿Estás seguro?',
            text: "No podrás revertir esta acción.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminarlo',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrInvInsumos.php',
                    type: 'POST',
                    data: { action: 'eliminarInsumo', id_inv: id_inv },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire('Eliminado', 'El registro ha sido eliminado.', 'success');
                            console.log("Recargando DataTable...");
                            insumosTable.ajax.reload(null, false);

                        } else {
                            Swal.fire('Error', 'Hubo un problema al eliminar el registro.', 'error');
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



});
