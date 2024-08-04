$(document).ready(function() {
    // Cargar roles en el select box
    $.ajax({
        url: "../AJAX/ctrUsuario.php",
        type: "POST",
        data: { action: 'obtenerRoles' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione un rol</option>';
                response.data.forEach(function(rol) {
                    options += `<option value="${rol.rol_id}">${rol.rol_nombre}</option>`;
                });
                $("#rol").html(options);
            } else {
                console.error("Error loading roles: ", response);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    // Inicializar DataTable para usuarios
    const usuariosTable = $('#tablaUsuarios').DataTable({
        ajax: {
            url: '../AJAX/ctrUsuario.php',
            type: 'GET',
            data: { action: 'obtenerUsuarios' },
            dataSrc: 'data'
        },
        columns: [
            { data: 'usu_id' },
            { data: 'usu_cedula' },
            { data: 'usu_nombre' },
            { data: 'usu_apellido' },
            { data: 'usu_telefono' },
            { data: 'usu_correo' },
            { data: 'usu_direccion' },
            { data: 'usu_usuario' },
            { data: 'rol_id' },
            { data: 'fecha_reg' },
            {
                data: null,
                render: function(data) {
                    return `
                        <button class="btn btn-primary btn-editar" data-id="${data.usu_id}">Editar</button>
                        <button class="btn btn-danger btn-eliminar" data-id="${data.usu_id}">Eliminar</button>
                    `;
                }
            }
        ]
    });

    // Manejar el envío del formulario para registrar/actualizar usuarios
    $('#form-registro-usuario').on('submit', function(event) {
        event.preventDefault();
        var formData = $(this).serialize();
        var action = $('#usu_id').val() ? 'actualizarUsuario' : 'registrarUsuario';

        $.ajax({
            url: `../AJAX/ctrUsuario.php?action=${action}`,
            method: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Usuario registrado/actualizado con éxito');
                    $('#form-registro-usuario')[0].reset();
                    usuariosTable.ajax.reload();
                    $('#btn-registro').text('Registrar Usuario');
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('Error al procesar la solicitud: ' + textStatus);
            }
        });
    });

    // Evento para el botón de eliminar
    $('#tablaUsuarios').on('click', '.btn-eliminar', function() {
        var usu_id = $(this).data('id');

        if (confirm('¿Estás seguro de que deseas eliminar este usuario?')) {
            $.ajax({
                url: '../AJAX/ctrUsuario.php?action=eliminarUsuario',
                method: 'POST',
                data: { usu_id: usu_id },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        alert('Usuario eliminado con éxito');
                        usuariosTable.ajax.reload();
                    } else {
                        alert('Error: ' + response.message);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('Error al procesar la solicitud: ' + textStatus);
                }
            });
        }
    });

    // Evento para el botón de editar
    $('#tablaUsuarios').on('click', '.btn-editar', function() {
        var usu_id = $(this).data('id');

        $.ajax({
            url: '../AJAX/ctrUsuario.php?action=obtenerUsuarioPorId',
            method: 'GET',
            data: { usu_id: usu_id },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    var usuario = response.data;
                    $('#usu_id').val(usuario.usu_id);
                    $('#cedula').val(usuario.usu_cedula);
                    $('#nombre').val(usuario.usu_nombre);
                    $('#apellido').val(usuario.usu_apellido);
                    $('#telefono').val(usuario.usu_telefono);
                    $('#correo').val(usuario.usu_correo);
                    $('#direccion').val(usuario.usu_direccion);
                    $('#usuario').val(usuario.usu_usuario);
                    $('#rol').val(usuario.rol_id);

                    $('#btn-registro').text('Actualizar Usuario');
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
