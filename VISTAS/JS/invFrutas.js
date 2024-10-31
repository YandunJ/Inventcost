$(document).ready(function() {
    // Cargar frutas y proveedores
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: "POST",
        data: { action: 'cargarFrutas' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione una fruta</option>';
                response.data.forEach(function(fruta) {
                    options += `<option value="${fruta.id_articulo}">${fruta.nombre_articulo}</option>`;
                });
                $("#fruta_id").html(options);
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

    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
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

    // Calcular el precio total
    $('#cantidad, #precio_unit').on('input', function() {
        const cantidad = parseFloat($('#cantidad').val()) || 0;
        const precioUnit = parseFloat($('#precio_unit').val()) || 0;
        const precioTotal = cantidad * precioUnit;
        $('#precio_total').val(precioTotal.toFixed(2));
    });

     // Inicializar DataTable
     const materiaPrimasTable = $('#tablaMateriaPrimas').DataTable({
        ajax: {
            url: '../AJAX/ctrInvFrutas.php',
            type: 'POST',
            data: { action: 'cargarMateriaPrima' },
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
            { data: 'Fecha' },
            { data: 'Hora' },
            { data: 'Lote' },
            { data: 'Proveedor' },
            { data: 'Artículo' },
            { data: 'Cantidad_Disponible' },
            { data: 'Estado' },
            { data: 'Precio_Total' },
            {
                data: null,
                render: function(data, type, row) {
                    return `
                        <button class="btn btn-info btn-sm edit-btn" data-id="${row.ID}">Editar</button>
                        <button class="btn btn-danger btn-sm delete-btn" data-id="${row.ID}">Eliminar</button>
                    `;
                }
            }
        ]
    });
    


    // Botón de estado "A" (Aprobar)
$('#tablaMateriaPrimas').on('click', '.approve-btn', function() {
    const mp_id = $(this).data('id');
    Swal.fire({
        title: '¿Estás seguro de aprobar esta materia prima?',
        text: "Esta acción se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, aprobar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            cambiarEstado(mp_id, 1); // 1 para "aprobado"
        }
    });
});
 // Botón de estado "X" (No Aprobar)
$('#tablaMateriaPrimas').on('click', '.reject-btn', function() {
    const mp_id = $(this).data('id');
    Swal.fire({
        title: '¿Estás seguro de no aprobar esta materia prima?',
        text: "Esta acción se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, no aprobar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            cambiarEstado(mp_id, 3); // 3 para "no_aprobado"
        }
    });
});
      // Al hacer clic en el botón de estado (Aprobar/No Aprobar)
      $('#tablaMateriaPrimas').on('click', '.status-btn',     function() {
        const mp_id = $(this).data('id');
        const estadoActual = $(this).text();
        const nuevoEstado = estadoActual === 'Aprobado' ? 'no_aprobado' : 'aprobado'; // Cambia el estado

        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php',
            type: 'POST',
            data: { action: 'cambiarEstadoMateriaPrima', mp_id: mp_id, estado: nuevoEstado },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Estado actualizado exitosamente.');
                    materiaPrimasTable.ajax.reload(); // Recargar la tabla
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert("Ocurrió un error al cambiar el estado.");
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
});



    function cambiarEstado(mp_id, estado) {
        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php',
            type: 'POST',
            data: { action: 'cambiarEstadoMateriaPrima', mp_id: mp_id, estado: estado },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    const actionType = $('#mp_id').val() ? 'actualizada' : 'registrada';
                    alert(`Materia prima ${actionType} exitosamente.`);
                    $('#materiaPrimaForm')[0].reset();
                    $('#mp_id').val(''); // Limpia el campo oculto
                    $('.btn-primary.btn-block').text('Agregar Materia Prima');
                    materiaPrimasTable.ajax.reload(null, false); // Recarga la tabla manteniendo la página actual
                } else {
                    alert('Error: ' + response.message);
                }
            },
            
            error: function(xhr, status, error) {
                alert("Ocurrió un error al cambiar el estado.");
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    }


    $('#materiaPrimaForm').on('submit', function(event) {
        event.preventDefault();
    
        // Validaciones adicionales
        const cantidad = parseFloat($('#cantidad').val()) || 0;
        const precioUnit = parseFloat($('#precio_unit').val()) || 0;
        const birx = parseFloat($('#birx').val()) || 0;
        const fechaCad = new Date($('#fecha_cad').val());
        const today = new Date();
    
        if (cantidad <= 0) {
            alert("La cantidad debe ser mayor a 0.");
            return;
        }
        if (precioUnit <= 0) {
            alert("El precio por kilogramo debe ser mayor a 0.");
            return;
        }
        if (birx < 0) {
            alert("El valor de Brix no puede ser negativo.");
            return;
        }
        if (fechaCad < today) {
            alert("La fecha límite de producción debe ser una fecha futura.");
            return;
        }
    
        // Mensaje de confirmación antes de guardar
        const actionType = $('#mp_id').val() ? 'actualizar' : 'registrar';
        Swal.fire({
            title: `¿Estás seguro de que deseas ${actionType} la materia prima?`,
            text: "Esta acción se puede confirmar más tarde.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: `Sí, ${actionType}`,
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Procesar el formulario
                const formData = $(this).serialize();
                $.ajax({
                    url: "../AJAX/ctrInvenMateriaP.php",
                    type: "POST",
                    data: formData + '&action=guardarMateriaPrima',
                    dataType: "json",
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire(
                                'Éxito!',
                                `Materia prima ${actionType} exitosamente.`,
                                'success'
                            );
                            $('#materiaPrimaForm')[0].reset();
                            $('.btn-primary.btn-block').text('Agregar Materia Prima'); // Restablecer el texto del botón
                            materiaPrimasTable.ajax.reload(); // Recargar la tabla
                        } else {
                            Swal.fire('Error', response.message, 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire('Error', 'Ocurrió un error al registrar la materia prima.', 'error');
                        console.error("Error: ", error);
                        console.error("Response: ", xhr.responseText);
                    }
                });
            }
        });
    });
    
      // Al hacer clic en el botón Editar
$('#tablaMateriaPrimas').on('click', '.edit-btn', function() {
    const mp_id = $(this).data('id');
    $.ajax({
        url: '../AJAX/ctrInvenMateriaP.php',
        type: 'POST',
        data: { action: 'obtenerMateriaPrima', mp_id: mp_id },
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                const data = response.data;
                $('#fruta_nombre').val(data.fruta_nombre);
                $('#proveedor_nombre').val(data.proveedor_nombre);
                $('#cantidad').val(data.cantidad);
                $('#precio_unit').val(data.precio_unit);
                $('#precio_total').val(data.precio_total);
                $('#birx').val(data.birx);
                $('#presentacion').val(data.presentacion);
                $('#observaciones').val(data.observaciones);
                $('#mp_id').val(data.mp_id); // Establecer el mp_id
                $('.btn-primary.btn-block').text('Actualizar Materia Prima'); // Cambiar el texto del botón
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function(xhr, status, error) {
            Swal.fire('Error', 'Ocurrió un error al obtener los datos.', 'error');
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });
});
    
       // Al hacer clic en el botón Eliminar
$('#tablaMateriaPrimas').on('click', '.delete-btn', function() {
    const mp_id = $(this).data('id');
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
                url: '../AJAX/ctrInvenMateriaP.php',
                type: 'POST',
                data: { action: 'eliminarMateriaPrima', mp_id: mp_id },
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

    
        let formModified = false;

        // Detectar cambios en el formulario
        $("#materiaPrimaForm input, #materiaPrimaFormselect").on("input change", function() {
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
