$(document).ready(function() {
    const tablaSeleccionarMP = $('#tablaSeleccionarMP').DataTable({
        ajax: {
            url: '../AJAX/ctrProduccionMP.php',
            type: 'POST',
            data: { action: 'obtenerMateriaPrima' },
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
            { data: 'fecha_hora_ing' },
            { data: 'fruta_nombre' },  // Cambiar de fruta_id a fruta_nombre
            { data: 'proveedor_nombre' }, // Cambiar de proveedor_id a proveedor_nombre
            { data: 'cantidad' },
            { data: 'precio_unit' },
            {
                data: null,
                render: function(data, type, row) {
                    return `<input type="number" class="form-control cantidad-consumir" name="cantidad_consumir[]" min="0" max="${row.cantidad}" step="0.01" disabled>`;
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    return `<input type="checkbox" class="form-check-input select-mp" value="${row.mp_id}">`;
                }
            }
        ]
    });

    // Evento para habilitar/deshabilitar el campo de cantidad a consumir
    $('#tablaSeleccionarMP tbody').on('change', '.select-mp', function() {
        const row = $(this).closest('tr');
        const cantidadInput = row.find('.cantidad-consumir');
        if ($(this).is(':checked')) {
            cantidadInput.prop('disabled', false);
        } else {
            cantidadInput.prop('disabled', true);
            cantidadInput.val(''); // Limpiar el campo si se deselecciona
        }
    });
});
