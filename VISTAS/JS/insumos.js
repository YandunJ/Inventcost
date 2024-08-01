$(document).ready(function() {
    $('#insumoForm').submit(function(event) {
        event.preventDefault();

        var formData = {
            'nombre': $('#nombre').val(),
            'descripcion': $('#descripcion').val(),
            'unidad_medida': $('#unidad_medida').val()
        };

        $.ajax({
            type: 'POST',
            url: "../AJAX/ctrInsumos.php",
            data: formData,
            dataType: 'json',
            encode: true
        }).done(function(data) {
            if (data.success) {
                alert('Insumo registrado correctamente');
                $('#insumoForm')[0].reset();
            } else {
                alert('Error al registrar el insumo: ' + data.message);
            }
        }).fail(function(jqXHR, textStatus, errorThrown) {
            alert('Error: ' + textStatus + ' - ' + errorThrown);
            console.error('Response:', jqXHR.responseText);
        });
    });
});
