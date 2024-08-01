$(document).ready(function() {
    // Manejo del inicio de sesión
    $('#loginForm').on('submit', function(event) {
        event.preventDefault();
        
        var usuario = $('#Usuario').val();
        var contrasenia = $('#Contrasenia').val();
        
        $.ajax({
            url: '../AJAX/ctrlogin.php', // Verifica esta ruta
            method: 'POST',
            data: {
                usuario: usuario,
                contrasenia: contrasenia
            },
            success: function(response) {
                if (response === 'success') {
                    window.location.href = 'index.php'; // Redirige si el login es exitoso
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

    // Cargar nombre del usuario
    function cargarNombreUsuario() {
        $.ajax({
            url: '../AJAX/getUserInfo.php',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    $('#userName').text(response.usuario_nombre);
                    $('.info a.d-block').text(response.usuario_nombre);
                } else {
                    console.error('Error al obtener el nombre del usuario');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', status, error);
            }
        });
    }

    // Llamar a la función para cargar el nombre del usuario al cargar la página
    if (window.location.pathname.includes('index.php')) {
        cargarNombreUsuario();
    }

    // Manejo del cierre de sesión
    $(".logout-link").on("click", function(e) {
        e.preventDefault();
        $.ajax({
            url: "../AJAX/cerrarsesion.php",
            type: "GET",
            success: function(response) {
                window.location.href = "../VISTAS/frlogin.php";
            },
            error: function() {
                alert("Error al cerrar sesión");
            }
        });
    });
});
