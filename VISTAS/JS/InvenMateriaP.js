$(document).ready(function() {
    // Función para cargar las frutas
    function cargarFrutas() {
        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php?op=cargarFrutas',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                let options = '';
                response.forEach(function(fruta) {
                    options += `<option value="${fruta.fruta_id}">${fruta.nombre}</option>`;
                });
                $('#fruta_id').html(options);
            },
            error: function(error) {
                console.log("Error al cargar frutas: ", error);
            }
        });
    }

    // Función para cargar los proveedores
    function cargarProveedores() {
        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php?op=cargarProveedores',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                let options = '';
                response.forEach(function(proveedor) {
                    options += `<option value="${proveedor.proveedor_id}">${proveedor.nombre_empresa}</option>`;
                });
                $('#proveedor_id').html(options);
            },
            error: function(error) {
                console.log("Error al cargar proveedores: ", error);
            }
        });
    }

    // Llamar a las funciones al cargar la página
    cargarFrutas();
    cargarProveedores();

    // Manejar el envío del formulario
    $('#materiaPrimaForm').on('submit', function(event) {
        event.preventDefault(); // Evitar que el formulario se envíe normalmente

        // Obtener los datos del formulario
        const formData = {
            fruta_id: $('#fruta_id').val(),
            fecha_cad: $('#fecha_cad').val(),
            proveedor_id: $('#proveedor_id').val(),
            cantidad: $('#cantidad').val(),
            precio_unit: $('#precio_unit').val(),
            birx: $('#birx').val(),
            estado: $('#estado').val(),
            observaciones: $('#observaciones').val(),
            usuario_id: 1 // Cambiar esto según sea necesario para obtener el ID del usuario
        };

        // Enviar los datos al servidor usando AJAX
        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php?op=guardar',
            type: 'POST',
            data: formData,
            success: function(response) {
                alert('Materia Prima agregada correctamente.');
                // Recargar la tabla de datos o realizar otras acciones necesarias
                $('#materiaPrimaForm')[0].reset(); // Resetear el formulario
                cargarTablaMateriaPrima(); // Actualizar la tabla (asegúrate de tener esta función)
            },
            error: function(error) {
                alert('Error al agregar Materia Prima.');
                console.log("Error: ", error);
            }
        });
    });

    // (código existente para el DataTable y el formulario)
});
