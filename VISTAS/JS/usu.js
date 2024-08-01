$(document).ready(function() {
    cargarRoles();

    function cargarRoles() {
        $.ajax({
            url: '../AJAX/ctrUsuario.php?action=obtenerRoles',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log(response); // Depuración
                if (response.status === 'success') {
                    llenarSelectRoles(response.data);
                } else {
                    console.error('Error al obtener roles: ' + response.message);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error en la solicitud AJAX: ' + textStatus);
            }
        });
    }

    function llenarSelectRoles(roles) {
        console.log(roles); // Depuración
        var select = $('#rol');
        select.empty();
        select.append('<option value="">Seleccione un rol</option>');

        $.each(roles, function(index, rol) {
            select.append('<option value="' + rol.rol_id + '">' + rol.rol_nombre + '</option>');
        });
    }

    $('#form-registro-usuario').on('submit', function(event) {
        event.preventDefault();
        var formData = $(this).serialize();
        console.log(formData); // Depuración

        $.ajax({
            url: '../AJAX/ctrUsuario.php?action=registrarUsuario',
            method: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                console.log(response); // Depuración
                if (response.status === 'success') {
                    alert('Usuario registrado con éxito');
                    $('#form-registro-usuario')[0].reset();
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('Error al procesar la solicitud: ' + textStatus);
            }
        });
    });
});
