$(document).ready(function() {
    // Cargar frutas y proveedores
    $.ajax({
        url: "../AJAX/ctrInvenMateriaP.php",
        type: "POST",
        data: { action: 'cargarFrutas' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione una fruta</option>';
                response.data.forEach(function(fruta) {
                    options += `<option value="${fruta.fruta_id}">${fruta.nombre}</option>`;
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
        url: "../AJAX/ctrInvenMateriaP.php",
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
            url: '../AJAX/ctrInvenMateriaP.php',
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
            { data: 'mp_id' },
            { data: 'fruta_id' },
            { data: 'fecha_hora_ing' },
            { data: 'fecha_cad' },
            { data: 'proveedor_id' },
            { data: 'cantidad' },
            { data: 'precio_unit' },
            { data: 'precio_total' },
            { data: 'birx' },
            { data: 'estado' },
            { data: 'observaciones' },
            {
                data: null,
                render: function(data, type, row) {
                    return `
                    <button class="btn btn-info btn-sm edit-btn" data-id="${row.mp_id}">Editar</button>
                    <button class="btn btn-success btn-sm approve-btn" data-id="${row.mp_id}">A</button>
                    <button class="btn btn-danger btn-sm reject-btn" data-id="${row.mp_id}">X</button>
                    <button class="btn btn-danger btn-sm delete-btn" data-id="${row.mp_id}">Eliminar</button>
                    `;
                }
            }
        ]
    });


       // Botón de estado "A" (Aprobar)
       $('#tablaMateriaPrimas').on('click', '.approve-btn', function() {
        const mp_id = $(this).data('id');
        cambiarEstado(mp_id, 1); // 1 para "aprobado"
    });

    // Botón de estado "X" (No Aprobar)
    $('#tablaMateriaPrimas').on('click', '.reject-btn', function() {
        const mp_id = $(this).data('id');
        cambiarEstado(mp_id, 3); // 3 para "no_aprobado"
    });


    function cambiarEstado(mp_id, estado) {
        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php',
            type: 'POST',
            data: { action: 'cambiarEstadoMateriaPrima', mp_id: mp_id, estado: estado },
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
    }
});


        $('#materiaPrimaForm').on('submit', function(event) {
            event.preventDefault();
            const formData = $(this).serialize();
            $.ajax({
                url: "../AJAX/ctrInvenMateriaP.php",
                type: "POST",
                data: formData + '&action=guardarMateriaPrima',
                dataType: "json",
                success: function(response) {
                    if (response.status === 'success') {
                        const actionType = $('#mp_id').val() ? 'actualizada' : 'registrada';
                        alert(`Materia prima ${actionType} exitosamente.`);
                        $('#materiaPrimaForm')[0].reset();
                        $('.btn-primary.btn-block').text('Agregar Materia Prima'); // Restablecer el texto del botón
                        materiaPrimasTable.ajax.reload(); // Recargar la tabla
                    } else {
                        alert('Error: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert("Ocurrió un error al registrar la materia prima.");
                    console.error("Error: ", error);
                    console.error("Response: ", xhr.responseText);
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
                    $('#fruta_id').val(data.fruta_id);
                    $('#fecha_cad').val(data.fecha_cad);
                    $('#proveedor_id').val(data.proveedor_id);
                    $('#cantidad').val(data.cantidad);
                    $('#precio_unit').val(data.precio_unit);
                    $('#precio_total').val(data.precio_total);
                    $('#birx').val(data.birx);
                    $('#presentacion').val(data.presentacion);
                    $('#observaciones').val(data.observaciones);
                    $('#mp_id').val(data.mp_id); // Establecer el mp_id
                    $('.btn-primary.btn-block').text('Actualizar Materia Prima'); // Cambiar el texto del botón
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
    $('#tablaMateriaPrimas').on('click', '.delete-btn', function() {
        const mp_id = $(this).data('id');
        if (confirm('¿Estás seguro de que deseas eliminar este registro?')) {
            $.ajax({
                url: '../AJAX/ctrInvenMateriaP.php',
                type: 'POST',
                data: { action: 'eliminarMateriaPrima', mp_id: mp_id },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        alert('Registro eliminado exitosamente.');
                        materiaPrimasTable.ajax.reload();
                    } else {
                        alert('Error: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert("Ocurrió un error al eliminar el registro.");
                    console.error("Error: ", error);
                    console.error("Response: ", xhr.responseText);
                }
            });
        }
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
