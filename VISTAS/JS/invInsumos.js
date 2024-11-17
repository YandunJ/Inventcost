$(document).ready(function() {
    // Cargar insumos y proveedores
    $.ajax({
        url: "../AJAX/ctrInvInsumos.php",
        type: "POST",
        data: { action: 'cargarInsumos' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione un insumo</option>';
                response.data.forEach(function(insumo) {
                    options += `<option value="${insumo.id_articulo}">${insumo.nombre_articulo}</option>`;
                });
                $("#id_articulo").html(options);
            } else {
                alert("Error al cargar los insumos.");
                console.error("Error loading insumos: ", response);
            }
        },
        error: function(xhr, status, error) {
            alert("Ocurrió un error al cargar los insumos.");
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    $.ajax({
        url: "../AJAX/ctrInvInsumos.php",
        type: "POST",
        data: { action: 'cargarProveedores' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione un proveedor</option>';
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


    $('#id_articulo').change(function() {
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
                        alert("Error al cargar la unidad de medida.");
                        console.error("Error loading unit: ", response);
                    }
                },
                error: function(xhr, status, error) {
                    alert("Ocurrió un error al cargar la unidad de medida.");
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

   
   // Calcular el precio total
$('#cantidad, #precio_unitario').on('input', function() {
    const cantidad = parseFloat($('#cantidad').val()) || 0;
    const precioUnitario = parseFloat($('#precio_unitario').val()) || 0;
    const precioTotal = cantidad * precioUnitario;
    $('#precio_total').val(precioTotal.toFixed(2));
});


    // Inicializar DataTable
    
        const insumosTable = $('#inventarioInsumosdt').DataTable({
            ajax: {
                url: '../AJAX/ctrInvInsumos.php',
                type: 'POST',
                data: { action: 'cargarInsumosTabla' },
                dataSrc: function(json) {
                    if (json.status === 'success') {
                        return json.data;
                    } else {
                        alert('Error: ' + json.message);
                        return [];
                    }
                }
            },
            columns: [
                { data: 'ID' },
                { data: 'Insumo' },
                { data: 'Proveedor' },
                { data: 'Fecha' },
                { data: 'Hora' },
                { data: 'Unidad_Medida' },
                { data: 'Cantidad' },
                { data: 'Cantidad_Restante' },
                { data: 'Precio_Unitario' },
                { data: 'Precio_Total' },
                { data: 'Presentacion' },
                { data: 'Estado' },
                {
                    data: null,
                    render: function(data, type, row) {
                        return `
                            <div class="btn-group">
                                <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                    <i class="fas fa-cog"></i>
                                </button>
                                <div class="dropdown-menu">
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
        });
    
    
   // Al hacer clic en el botón Agregar/Actualizar
   $('#InsumosForm').on('submit', function(event) {
    event.preventDefault(); // Previene la recarga de la página
    const formData = $(this).serialize(); // Asegúrate de que los nombres coincidan en el formulario HTML
    const actionType = $('#id_inv').val() ? 'actualizar' : 'registrar';

    Swal.fire({
        title: `¿Estás seguro de que deseas ${actionType} este insumo?`,
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
                        Swal.fire('Éxito', `Insumo ${actionType}ado exitosamente.`, 'success');
                        $('#insumoForm')[0].reset();
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
    $('#inventarioInsumosdt').on('click', '.edit-btn', function() {
        const inventins_id = $(this).data('id');
        $.ajax({
            url: '../AJAX/ctrInvInsumos.php',
            type: 'POST',
            data: { action: 'cargarInsumoId', inventins_id: inventins_id },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    const data = response.data;
                    $('#insumo_id').val(data.insumo_id);
                    $('#fecha_cad').val(data.fecha_cad);
                    $('#proveedor_id').val(data.proveedor_id);
                    $('#unidad_medida').val(data.unidad_medida);
                    $('#cantidad').val(data.cantidad);
                    $('#precio_unitario').val(data.precio_unitario);
                    $('#precio_total').val(data.precio_total);
                    $('#inventins_id').val(data.inventins_id); // Establecer el inventins_id
                    $('.btn-primary.btn-block').text('Actualizar Insumo'); // Cambiar el texto del botón
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert("Ocurrió un error al obtener los datos.");
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
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
                            insumosTable.ajax.reload(null, false); // Recarga la tabla sin reiniciar la paginación
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

    let formModified = false;

    // Detectar cambios en el formulario
    $("#inventinsumosForm input, #inventinsumosForm select").on("input change", function() {
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

    // Implementar el botón de Cancelar
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
