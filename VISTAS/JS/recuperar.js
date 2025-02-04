$(document).ready(function() {
    $('#recuperarForm').on('submit', function(event) {
        event.preventDefault();
        let correo = $('#correo').val();

        $.ajax({
            url: '../AJAX/ctrContra.php',
            type: 'POST',
            data: { correo: correo },
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