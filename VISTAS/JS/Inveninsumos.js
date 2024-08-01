$(document).ready(function() {
    $('#inventarioForm').on('submit', function(e) {
        e.preventDefault();
        
        const formData = {
            insumo_id: $('#insumo_id').val(),
            proveedor_id: $('#proveedor_id').val(),
            cantidad: $('#cantidad').val(),
            precio_unitario: $('#precio_unitario').val(),
        };

        $.ajax({
            url: '../AJAX/ctrInvenInsumos.php',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message);
                    $('#inventarioForm')[0].reset();
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert('Error al registrar los datos');
            }
        });
    });
});
