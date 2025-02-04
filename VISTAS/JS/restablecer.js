$(document).ready(function() {
    $('#restablecerForm').on('submit', function(event) {
        event.preventDefault();
        let codigo = $('#codigo').val();
        let nueva_contrasenia = $('#nueva_contrasenia').val();
        let confirmar_contrasenia = $('#confirmar_contrasenia').val();

        if (nueva_contrasenia !== confirmar_contrasenia) {
            Swal.fire('Error', 'Las contraseñas no coinciden.', 'error');
            return;
        }

        $.ajax({
            url: '../AJAX/ctrContraNueva.php',
            type: 'POST',
            data: { codigo: codigo, nueva_contrasenia: nueva_contrasenia },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    Swal.fire('Éxito', response.message, 'success');
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function() {
                Swal.fire('Error', 'Ocurrió un error al procesar la solicitud.', 'error');
            }
        });
    });
});