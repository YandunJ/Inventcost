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
                    $.ajax({
                        url: '../AJAX/usuinfo.php',
                        method: 'GET',
                        dataType: 'json',
                        success: function(userInfo) {
                            if (userInfo.status === 'success') {
                                switch (userInfo.permiso_id) {
                                    case 1: // Permiso 1
                                        window.location.href = 'index.php';
                                        break;
                                    case 2: // Permiso 2
                                        window.location.href = 'index2.php';
                                        break;
                                    case 3: // Permiso 3
                                        window.location.href = 'index3.php';
                                        break;
                                    case 4: // Permiso 4
                                        window.location.href = 'index4.php';
                                        break;
                                    default:
                                        alert('Permiso desconocido');
                                }
                            } else {
                                alert('Error al obtener la información del usuario');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('Error en la solicitud AJAX:', status, error);
                            alert('Error en el inicio de sesión');
                        }
                    });
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
