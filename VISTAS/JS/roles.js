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
            dataSrc: 'data' // Cambia esto para apuntar a 'data'
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
                        <button class="btn btn-danger btn-delete" data-id="${row.rol_id}">Eliminar</button>
                    `;
                }
            }
        ]
    });
    
    // Enviar el formulario
    $("#roleForm").on("submit", function(e) {
        e.preventDefault();
        const rolId = $(this).data('rol_id'); // Obtener el ID del rol
        const action = rolId ? 'updateRole' : 'addRole'; // Determinar acción
        
        $.ajax({
            url: "../AJAX/ctrRoles.php",
            type: "POST",
            data: $(this).serialize() + `&action=${action}&rol_id=${rolId}`, // Agregar ID
            dataType: "json",
            success: function(response) {
                if (response.status === 'success') {
                    alert("Rol guardado correctamente");
                    rolesTable.ajax.reload(); // Recargar la tabla
                    $("#roleForm")[0].reset();
                    // Resetear el texto del botón a "Agregar Rol"
                    $("#roleForm button[type='submit']").text('Agregar Rol');
                    $(this).removeData('rol_id'); // Limpiar el ID después de guardar
                } else {
                    alert("Error al guardar rol: " + response.message);
                }
            },
            
            error: function(xhr, status, error) {
                console.error("Error:", error);
            }
        });
    });
    

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
                    alert("Error al cargar rol: " + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
            }
        });
    });
    
    
    $('#rolesTable tbody').on('click', '.btn-delete', function() {
        const rolId = $(this).data('id');
        if (confirm("¿Estás seguro de que deseas eliminar este rol?")) {
            $.ajax({
                url: "../AJAX/ctrRoles.php",
                type: "POST",
                data: { action: 'deleteRole', rol_id: rolId },
                dataType: "json",
                success: function(response) {
                    if (response.status === 'success') {
                        alert("Rol eliminado correctamente");
                        rolesTable.ajax.reload(); // Recargar la tabla
                    } else {
                        alert("Error al eliminar rol: " + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    console.error("Response:", xhr.responseText);
                }
            });
        }
    });  
});
