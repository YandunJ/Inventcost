$(document).ready(function() {
    // Cargar permisos en el select box
    $.ajax({
        url: "../AJAX/ctrRoles.php",
        type: "POST",
        data: { action: 'getPermisos' },
        dataType: "json",
        success: function(response) {
            console.log("Response from server:", response);

            try {
                if (Array.isArray(response)) {
                    const permisos = response;
                    console.log("Parsed permisos:", permisos);

                    let options = "";
                    permisos.forEach(function(permiso) {
                        options += `<option value="${permiso.permiso_id}">${permiso.permiso_nombre}</option>`;
                    });
                    $("#rol_area_trabajo").html(options);
                } else {
                    throw new Error("Response is not an array: " + JSON.stringify(response));
                }
            } catch (error) {
                console.error("Parsing error:", error);
                console.error("Response:", response);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error:", error);
            console.error("Response:", xhr.responseText);
        }
    });

    // Asegúrate de que los datos estén siendo enviados correctamente
    $("#roleForm").on("submit", function(e) {
        e.preventDefault();
        $.ajax({
            url: "../AJAX/ctrRoles.php",
            type: "POST",
            data: $(this).serialize() + '&action=addRole',
            dataType: "json",
            success: function(response) {
                console.log("Response from server:", response);
                if (response.status === 'success') {
                    alert("Rol guardado correctamente");
                    $("#roleForm")[0].reset();
                } else {
                    alert("Error al guardar rol: " + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                console.error("Response:", xhr.responseText);
            }
        });
    });
});
