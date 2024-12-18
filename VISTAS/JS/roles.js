$(document).ready(function() {
    // Cargar permisos en el select box
    $.ajax({
        url: "../AJAX/ctrRoles.php",
        type: "POST",
        data: { action: 'getPermisos' },
        dataType: "json",
        success: function(response) {
            if (Array.isArray(response)) {
                let options = "";
                response.forEach(function(permiso) {
                    options += `<option value="${permiso.permiso_id}">${permiso.permiso_nombre}</option>`;
                });
                $("#rol_area_trabajo").html(options);
            } else {
                console.error("Error loading permisos: ", response);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    const rolesTable = $('#rolesTable').DataTable({
        ajax: {
            url: '../AJAX/ctrRoles.php',
            type: 'POST',
            data: { action: 'getRoles' },
            dataSrc: 'data'
        },
        columns: [
            { data: 'rol_id' },
            { data: 'rol_nombre' },
            { data: 'rol_descripcion' },
            { data: 'permiso_nombre' },
            { data: 'fecha_registro' },
            {
                data: null,
                render: function(data, type, row) {
                    return `
                        <button class="btn btn-warning btn-edit" data-id="${row.rol_id}">Editar</button>
                    `;
                }
            }
        ],
        language: dataTableLanguage // Añade esta línea para usar tu configuración de idioma
    });
    
    
   // Enviar el formulario con confirmación de SweetAlert2
   $("#roleForm").on("submit", function(e) {
    e.preventDefault();
    const rolId = $(this).data('rol_id'); // Obtener el ID del rol
    const action = rolId ? 'updateRole' : 'addRole'; // Determinar acción
    
    Swal.fire({
        title: rolId ? "¿Está seguro de que desea actualizar este rol?" : "¿Está seguro de que desea registrar este rol?",
        
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: rolId ? "Sí, actualizar" : "Sí, registrar",
        cancelButtonText: "Cancelar"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: "../AJAX/ctrRoles.php",
                type: "POST",
                data: $("#roleForm").serialize() + `&action=${action}&rol_id=${rolId}`, // Agregar ID
                dataType: "json",
                success: function(response) {
                    if (response.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Éxito',
                            text: rolId ? 'El rol ha sido actualizado correctamente' : 'El rol ha sido registrado correctamente',
                            confirmButtonText: 'Aceptar'
                        }).then(() => {
                            rolesTable.ajax.reload(); // Recargar la tabla
                            $("#roleForm")[0].reset();
                            $("#roleForm button[type='submit']").text('Agregar Rol');
                            $(this).removeData('rol_id'); // Limpiar el ID después de guardar
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error al guardar el rol: ' + response.message,
                            confirmButtonText: 'Aceptar'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Hubo un problema con la solicitud: ' + error,
                        confirmButtonText: 'Aceptar'
                    });
                }
            });
        }
    });
});

 // Editar rol
 $('#rolesTable tbody').on('click', '.btn-edit', function() {
    const rolId = $(this).data('id');
    $.ajax({
        url: "../AJAX/ctrRoles.php",
        type: "POST",
        data: { action: 'getRoleById', rol_id: rolId },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success') {
                // Llena el formulario con los datos del rol
                $("#rol_nombre").val(response.data.rol_nombre);
                $("#rol_descripcion").val(response.data.rol_descripcion);
                // No llenamos el select, solo aseguramos que se mantenga el valor
                $("#rol_area_trabajo").val(response.data.permiso_id); // Esto solo seleccionará el permiso
                
                // Cambia el texto del botón a "Actualizar Rol"
                $("#roleForm button[type='submit']").text('Actualizar Rol');

                // Guardamos el ID en el formulario
                $("#roleForm").data('rol_id', rolId); 
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error al cargar rol: ' + response.message,
                    confirmButtonText: 'Aceptar'
                });
            }
        },
        error: function(xhr, status, error) {
            console.error("Error:", error);
        }
    });
});

    
   // Eliminar rol
//    $('#rolesTable tbody').on('click', '.btn-delete', function() {
//     const rolId = $(this).data('id');
//     Swal.fire({
//         title: "¿Está seguro de que desea eliminar este rol?",
//         icon: "warning",
//         showCancelButton: true,
//         confirmButtonColor: "#3085d6",
//         cancelButtonColor: "#d33",
//         confirmButtonText: "Sí, eliminar",
//         cancelButtonText: "Cancelar"
//     }).then((result) => {
//         if (result.isConfirmed) {
//             $.ajax({
//                 url: "../AJAX/ctrRoles.php",
//                 type: "POST",
//                 data: { action: 'deleteRole', rol_id: rolId },
//                 dataType: "json",
//                 success: function(response) {
//                     if (response.status === 'success') {
//                         Swal.fire({
//                             icon: 'success',
//                             title: 'Eliminado',
//                             text: 'El rol ha sido eliminado correctamente',
//                             confirmButtonText: 'Aceptar'
//                         }).then(() => {
//                             rolesTable.ajax.reload(); // Recargar la tabla
//                         });
//                     } else {
//                         Swal.fire({
//                             icon: 'error',
//                             title: 'Error',
//                             text: 'Error al eliminar el rol: ' + response.message,
//                             confirmButtonText: 'Aceptar'
//                         });
//                     }
//                 },
//                 error: function(xhr, status, error) {
//                     Swal.fire({
//                         icon: 'error',
//                         title: 'Error',
//                         text: 'Hubo un problema con la solicitud: ' + error,
//                         confirmButtonText: 'Aceptar'
//                     });
//                 }
//             });
//         }
//     });
// });  



});
