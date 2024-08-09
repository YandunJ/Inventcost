$(document).ready(function() {
    // Cargar insumos y proveedores
    $.ajax({
        url: "../AJAX/ctrInvenInsumos.php",
        type: "POST",
        data: { action: 'cargarInsumos' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione un insumo</option>';
                response.data.forEach(function(insumo) {
                    options += `<option value="${insumo.insumo_id}">${insumo.nombre}</option>`;
                });
                $("#insumo_id").html(options);
            } else {
                alert("Error al cargar los insumos.");
                console.error("Error loading insumos: ", response);
            }
        },
        error: function(xhr, status, error) {
            alert("Ocurrió un error al cargar los insumos.");
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    $.ajax({
        url: "../AJAX/ctrInvenInsumos.php",
        type: "POST",
        data: { action: 'cargarProveedores' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione un proveedor</option>';
                response.data.forEach(function(proveedor) {
                    options += `<option value="${proveedor.proveedor_id}">${proveedor.nombre_empresa}</option>`;
                });
                $("#proveedor_id").html(options);
            } else {
                alert("Error al cargar los proveedores.");
                console.error("Error loading proveedores: ", response);
            }
        },
        error: function(xhr, status, error) {
            alert("Ocurrió un error al cargar los proveedores.");
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });
});