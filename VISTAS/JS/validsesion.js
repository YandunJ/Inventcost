$(document).ready(function() {
    $.ajax({
        url: '../AJAX/sesion.php',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                $('#userName').text(response.nombre);
            } else if (response.status === 'not_logged_in') {
                window.location.href = 'frlogin.php';
            }
        }
    });
});
