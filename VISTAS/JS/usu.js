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
            type: 'POST',
            data: { action: 'obtenerUsuarios' },
            dataSrc: 'data'
        },
        columns: [
            { data: 'usu_cedula' },
            { data: 'usu_nombre' },
            { data: 'usu_apellido' },
            { data: 'usu_usuario' },
            { data: 'rol_nombre' }, // Mostrar el nombre del rol en vez del ID
            { data: 'correo' },
            { data: 'usu_telefono' },
            { data: 'estado' },
            { data: 'fecha_reg' },
            {
                data: null,
                render: function(data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item edit-btn" href="#" data-id="${row.usu_id}">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                                <a class="dropdown-item delete-btn" href="#" data-id="${row.usu_id}">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </a>
                                <a class="dropdown-item toggle-status-btn" href="#" data-id="${row.usu_id}" data-status="${row.estado}">
                                    <i class="fas fa-toggle-on"></i> habilitar/deshabilitar
                                </a>
                            </div>
                        </div>
                    `;
                }
            }
        ],
        language: dataTableLanguage
    });

    // ...código existente...

    // Manejar el evento del botón para cambiar el estado
    $('#tablaUsuarios').on('click', '.toggle-status-btn', function() {
        let usu_id = $(this).data('id');
        let currentStatus = $(this).data('status');
        let newStatus = currentStatus === 'habilitado' ? 'deshabilitado' : 'habilitado';

        $.ajax({
            url: '../AJAX/ctrUsuario.php',
            type: 'POST',
            data: {
                action: 'cambiarEstadoUsuario',
                usu_id: usu_id,
                estado: newStatus
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    Swal.fire('Éxito', 'Estado del usuario cambiado con éxito', 'success');
                    usuariosTable.ajax.reload();
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function() {
                Swal.fire('Error', 'Ocurrió un error al procesar la solicitud.', 'error');
            }
        });
    });

    $('#form-registro-usuario').on('submit', function(event) {
        event.preventDefault();
    
        let usu_id = $('#usu_id').val();
        let action = usu_id && usu_id !== "0" ? 'actualizarUsuario' : 'registrarUsuario';
    
        let formData = {
            action: action,
            usu_id: usu_id,
            cedula: $('#cedula').val(),
            nombre: $('#nombre').val(),
            apellido: $('#apellido').val(),
            telefono: $('#telefono').val(),
            usuario: $('#usuario').val(),
            rol_id: $('#rol').val(),
            correo: $('#correo').val()
        };
    
        // Solo agregar la contraseña si se ha ingresado una nueva
        let contrasenia = $('#contrasenia').val();
        if (contrasenia) {
            formData.contrasenia = contrasenia;
        }
    
        $.ajax({
            url: '../AJAX/ctrUsuario.php',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    Swal.fire('Éxito', 'Usuario registrado/actualizado con éxito', 'success');
                    $('#form-registro-usuario')[0].reset();
                    $('#usu_id').val('0');
                    $('#modalRegistroUsuario').modal('hide');
                    usuariosTable.ajax.reload();
    
                    // Mostrar mensaje adicional sobre la contraseña
                    if (contrasenia) {
                        toastr.success('Contraseña cambiada exitosamente.');
                    } else {
                        toastr.info('La contraseña se mantuvo sin cambios.');
                    }
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function() {
                Swal.fire('Error', 'Ocurrió un error al procesar la solicitud.', 'error');
            }
        });
    });


// Cargar datos en el formulario al editar
$('#tablaUsuarios').on('click', '.edit-btn', function() {
    let usu_id = $(this).data('id');

    $.ajax({
        url: '../AJAX/ctrUsuario.php',
        type: 'POST',
        data: {
            action: 'obtenerUsuarioPorID',
            usu_id: usu_id
        },
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                let usuario = response.data;
                $('#usu_id').val(usuario.usu_id);
                $('#cedula').val(usuario.usu_cedula);
                $('#nombre').val(usuario.usu_nombre);
                $('#apellido').val(usuario.usu_apellido);
                $('#telefono').val(usuario.usu_telefono);
                $('#usuario').val(usuario.usu_usuario);
                $('#rol').val(usuario.rol_id);
                $('#correo').val(usuario.correo);

                $('#modalRegistroUsuarioLabel').text('Actualizar Usuario');
                $('#btn-registro').text('Guardar');
                $('#modalRegistroUsuario').modal('show');
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function(xhr, status, error) {
            Swal.fire('Error', 'No se pudo cargar el usuario.', 'error');
        }
    });
});

// Cambiar el título del modal y el texto del botón al abrir el modal para registrar
$('#modalRegistroUsuario').on('show.bs.modal', function(event) {
    let button = $(event.relatedTarget); // Botón que abrió el modal
    let modal = $(this);
    if (button.hasClass('edit-btn')) {
        modal.find('.modal-title').text('Actualizar Usuario');
        $('#btn-registro').text('Guardar');
    } else {
        modal.find('.modal-title').text('Registrar Usuario');
        $('#btn-registro').text('Guardar');
    }
});




    // function validarCedulaEcuatoriana(cedula) {
    //     if (cedula.length !== 10) return false;
    //     const digitoRegion = cedula.substring(0, 2);
    //     if (digitoRegion < 1 || digitoRegion > 24) return false;

    //     const coef = [2, 1, 2, 1, 2, 1, 2, 1, 2];
    //     const verificador = parseInt(cedula.charAt(9), 10);
    //     const suma = cedula.substring(0, 9).split('').reduce((acc, digit, index) => {
    //         let valor = parseInt(digit, 10) * coef[index];
    //         if (valor > 9) valor -= 9;
    //         return acc + valor;
    //     }, 0);

    //     const resultado = (suma % 10 === 0) ? 0 : 10 - (suma % 10);
    //     return resultado === verificador;
    // }

    // $('#cedula').on('blur', function() {
    //     const cedula = $(this).val();
    //     if (!validarCedulaEcuatoriana(cedula)) {
    //         alert('Cédula inválida');
    //         $(this).val('');
    //     }
    // });

// Evento para el botón de eliminar
// $('#tablaUsuarios').on('click', '.btn-eliminar', function() {
//     var usu_id = $(this).data('id');

//     // Mensaje de confirmación utilizando SweetAlert
//     Swal.fire({
//         title: '¿Estás seguro?',
//         text: 'Estás a punto de eliminar este usuario.',
//         icon: 'warning',
//         showCancelButton: true,
//         confirmButtonColor: '#3085d6',
//         cancelButtonColor: '#d33',
//         confirmButtonText: 'Sí, eliminar',
//         cancelButtonText: 'Cancelar'
//     }).then((result) => {
//         if (result.isConfirmed) {
//             $.ajax({
//                 url: '../AJAX/ctrUsuario.php?action=eliminarUsuario',
//                 method: 'POST',
//                 data: { usu_id: usu_id },
//                 dataType: 'json',
//                 success: function(response) {
//                     if (response.status === 'success') {
//                         Swal.fire(
//                             'Eliminado!',
//                             'Usuario eliminado con éxito',
//                             'success'
//                         );
//                         usuariosTable.ajax.reload();
//                     } else {
//                         Swal.fire(
//                             'Error!',
//                             'Error: ' + response.message,
//                             'error'
//                         );
//                     }
//                 },
//                 error: function(jqXHR, textStatus, errorThrown) {
//                     Swal.fire(
//                         'Error!',
//                         'Error al procesar la solicitud: ' + textStatus,
//                         'error'
//                     );
//                 }
//             });
//         }
//     });
// });


});