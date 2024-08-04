$(document).ready(function() {
    // Inicializar DataTable
    var table = $('#employeesTable').DataTable({
        "ajax": {
            "url": "../AJAX/ctrEmpleados.php",
            "type": "POST",
            "data": { action: "obtenerEmpleados" }
        },
        "columns": [
            { "data": "emp_id" },
            { "data": "emp_cedula" },
            { "data": "emp_nombre" },
            { "data": "emp_apellido" },
            { "data": "emp_telefono" },
            { "data": "emp_correo" },
            { "data": "emp_direccion" },
            {
                "data": null,
                "defaultContent": `
                    <button class="editEmployee btn btn-warning btn-sm">Editar</button>
                    <button class="deleteEmployee btn btn-danger btn-sm">Eliminar</button>
                `
            }
        ]
    });

    var editing = false;
    var currentId = null;

    // Manejar la acción de agregar empleado
    $('#employeeForm').on('submit', function(e) {
        e.preventDefault();

        var action = editing ? 'updateEmpleado' : 'addEmpleado';
        var formData = {
            action: action,
            emp_id: editing ? currentId : null,
            cedula: $('#cedula').val(),
            nombre: $('#nombre').val(),
            apellido: $('#apellido').val(),
            telefono: $('#telefono').val(),
            correo: $('#correo').val(),
            direccion: $('#direccion').val()
        };

        $.ajax({
            url: '../AJAX/ctrEmpleados.php',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert(editing ? 'Empleado actualizado correctamente' : 'Empleado registrado correctamente');
                    // Limpiar el formulario
                    $('#employeeForm')[0].reset();
                    // Recargar la tabla de empleados
                    table.ajax.reload();
                    // Resetear el estado de edición
                    editing = false;
                    currentId = null;
                    $('#employeeForm button[type="submit"]').text('Agregar Empleado');
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error en la solicitud AJAX:', textStatus, errorThrown);
                alert('Error en la solicitud AJAX: ' + textStatus);
            }
        });
    });

    // Editar y eliminar empleados
    $('#employeesTable tbody').on('click', 'button', function() {
        var action = $(this).hasClass('editEmployee') ? 'edit' : 'delete';
        var data = table.row($(this).parents('tr')).data();

        if (action === 'edit') {
            // Llenar el formulario con los datos del empleado
            $('#cedula').val(data.emp_cedula);
            $('#nombre').val(data.emp_nombre);
            $('#apellido').val(data.emp_apellido);
            $('#telefono').val(data.emp_telefono);
            $('#correo').val(data.emp_correo);
            $('#direccion').val(data.emp_direccion);
            // Cambiar el estado de edición y guardar el id actual
            editing = true;
            currentId = data.emp_id;
            $('#employeeForm button[type="submit"]').text('Actualizar Empleado');
        } else if (action === 'delete') {
            if (confirm('¿Estás seguro de que quieres eliminar este empleado?')) {
                $.ajax({
                    url: '../AJAX/ctrEmpleados.php',
                    type: 'POST',
                    data: { action: 'deleteEmpleado', emp_id: data.emp_id, cedula: data.emp_cedula },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            alert('Empleado eliminado correctamente');
                            // Recargar la tabla de empleados
                            table.ajax.reload();
                        } else {
                            alert('Error: ' + response.message);
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error en la solicitud AJAX:', textStatus, errorThrown);
                        alert('Error en la solicitud AJAX: ' + textStatus);
                    }
                });
            }
        }
    });
});
