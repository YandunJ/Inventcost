$(document).ready(function() {
    $('#loginForm').on('submit', function(event) {
        event.preventDefault();

        var usuario = $('#Usuario').val();
        var contrasenia = $('#Contrasenia').val();

        $.ajax({
            url: '../AJAX/ctrlogin.php',
            method: 'POST',
            data: {
                Usuario: usuario,
                Contrasenia: contrasenia
            },
            success: function(response) {
                if (response === 'success') {
                    window.location.href = 'index.php';
                } else {
                    alert('Usuario o contraseña incorrectos');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', status, error);
                alert('Error en el inicio de sesión');
            }
        });
    });
});