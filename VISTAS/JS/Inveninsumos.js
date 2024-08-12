$(document).ready(function() {
    // Cargar insumos y proveedores
    $.ajax({
        url: "../AJAX/ctrInvenInsumos.php",
        type: "POST",
        data: { action: 'cargarInsumos' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione un insumo</option>';
                response.data.forEach(function(insumo) {
                    options += `<option value="${insumo.insumo_id}">${insumo.nombre}</option>`;
                });
                $("#insumo_id").html(options);
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
        url: "../AJAX/ctrInvenInsumos.php",
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
    $('#cantidad, #precio_unitario').on('input', function() {
        const cantidad = parseFloat($('#cantidad').val()) || 0;
        const precioUnitario = parseFloat($('#precio_unitario').val()) || 0;
        const precioTotal = cantidad * precioUnitario;
        $('#precio_total').val(precioTotal.toFixed(2));
    });

    // Inicializar DataTable
    const insumosTable = $('#inventarioInsumosdt').DataTable({
        ajax: {
            url: '../AJAX/ctrInvenInsumos.php',
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
            { data: 'inventins_id' },
            { data: 'insumo_nombre' },
            { data: 'proveedor_nombre' },
            { data: 'fecha_hora_ing' },
            { data: 'fecha_cad' },
            { data: 'unidad_medida' },
            { data: 'cantidad' },
            { data: 'precio_unitario' },
            { data: 'precio_total' },
            {
                data: null,
                render: function(data, type, row) {
                    return `
                    <button class="btn btn-info btn-sm edit-btn" data-id="${row.inventins_id}">Editar</button>
                    <button class="btn btn-danger btn-sm delete-btn" data-id="${row.inventins_id}">Eliminar</button>
                    `;
                }
            }
        ]
    });

    // Al hacer clic en el botón Agregar/Actualizar
    $('#inventinsumosForm').on('submit', function(event) {
        event.preventDefault();
        const formData = $(this).serialize();
        $.ajax({
            url: "../AJAX/ctrInvenInsumos.php",
            type: "POST",
            data: formData + '&action=guardarInsumo',
            dataType: "json",
            success: function(response) {
                if (response.status === 'success') {
                    const actionType = $('#inventins_id').val() ? 'actualizado' : 'registrado';
                    alert(`Insumo ${actionType} exitosamente.`);
                    $('#inventinsumosForm')[0].reset();
                    $('.btn-primary.btn-block').text('Agregar Insumo'); // Restablecer el texto del botón
                    insumosTable.ajax.reload(); // Recargar la tabla
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert("Ocurrió un error al registrar el insumo.");
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });

    // Al hacer clic en el botón Editar
    $('#inventarioInsumosdt').on('click', '.edit-btn', function() {
        const inventins_id = $(this).data('id');
        $.ajax({
            url: '../AJAX/ctrInvenInsumos.php',
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
        const inventins_id = $(this).data('id');
        if (confirm('¿Estás seguro de que deseas eliminar este registro?')) {
            $.ajax({
                url: '../AJAX/ctrInvenInsumos.php',
                type: 'POST',
                data: { action: 'eliminarInsumo', inventins_id: inventins_id },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        alert('Registro eliminado exitosamente.');
                        insumosTable.ajax.reload();
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

});
