$(document).ready(function() {
    // Cargar frutas en el select box
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

    // Cargar proveedores en el select box
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

    // Inicializar el DataTable
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
                render: function(data) {
                    return `
                        <button class="btn btn-primary btn-editar" data-id="${data.mp_id}">Editar</button>
                        <button class="btn btn-danger btn-eliminar" data-id="${data.mp_id}">Eliminar</button>
                    `;
                }
            }
        ]
    });

    // Manejar el envío del formulario para guardar materia prima
    $('#materiaPrimaForm').on('submit', function(event) {
        event.preventDefault();
        var formData = $(this).serialize();
        var action = $('#mp_id').val() ? 'actualizarMateriaPrima' : 'guardarMateriaPrima';

        $.ajax({
            url: `../AJAX/ctrInvenMateriaP.php?action=${action}`,
            method: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Materia prima registrada/actualizada con éxito');
                    $('#materiaPrimaForm')[0].reset();
                    materiaPrimasTable.ajax.reload();
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('Error al procesar la solicitud: ' + textStatus);
            }
        });
    });

    // Evento para el botón de eliminar
    $('#tablaMateriaPrimas').on('click', '.btn-eliminar', function() {
        var mp_id = $(this).data('id');

        if (confirm('¿Estás seguro de que deseas eliminar esta materia prima?')) {
            $.ajax({
                url: '../AJAX/ctrInvenMateriaP.php',
                method: 'POST',
                data: { action: 'eliminarMateriaPrima', mp_id: mp_id },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        alert('Materia prima eliminada con éxito');
                        materiaPrimasTable.ajax.reload();
                    } else {
                        alert('Error: ' + response.message);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('Error al procesar la solicitud: ' + textStatus);
                }
            });
        }
    });
});
