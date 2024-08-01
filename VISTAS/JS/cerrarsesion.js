$(document).ready(function() {
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
