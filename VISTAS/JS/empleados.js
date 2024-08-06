$(document).ready(function() {
    // Inicializar DataTable
    const employeesTable = $('#employeesTable').DataTable({
        ajax: {
            url: '../AJAX/ctrEmpleados.php',
            type: 'POST',
            data: { action: 'obtenerEmpleados' },
            dataSrc: 'data'
        },
        columns: [
            { data: 'emp_id' },
            { data: 'emp_cedula' },
            { data: 'emp_nombre' },
            { data: 'emp_apellido' },
            { data: 'emp_telefono' },
            { data: 'emp_correo' },
            { data: 'emp_direccion' },
            {
                data: null,
                render: function(data) {
                    return `
                        <button class="btn btn-warning btn-edit" data-id="${data.emp_id}">Editar</button>
                        <button class="btn btn-danger btn-delete" data-id="${data.emp_id}">Eliminar</button>
                    `;
                }
            }
        ]
    });

    // Manejar el envío del formulario para registrar empleados
    $('#employeeForm').on('submit', function(e) {
        e.preventDefault();
        
        const formData = {
            emp_id: $('#emp_id').val(),
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
            data: { action: 'addOrUpdateEmpleado', ...formData },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Empleado registrado exitosamente');
                    employeesTable.ajax.reload();
                    $('#employeeForm')[0].reset();
                    $('#emp_id').val(''); // Limpiar el ID del empleado
                    $('button[type="submit"]').text('Agregar Empleado');
                } else {
                    alert('Error al registrar el empleado: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                console.error("Response:", xhr.responseText);
            }
        });
    });

    // Manejar el clic en el botón de editar
    $('#employeesTable tbody').on('click', '.btn-edit', function() {
        const empId = $(this).data('id');

        $.ajax({
            url: '../AJAX/ctrEmpleados.php',
            type: 'POST',
            data: { action: 'getEmpleadoById', emp_id: empId },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    const empleado = response.data;
                    $('#emp_id').val(empleado.emp_id);
                    $('#cedula').val(empleado.emp_cedula);
                    $('#nombre').val(empleado.emp_nombre);
                    $('#apellido').val(empleado.emp_apellido);
                    $('#telefono').val(empleado.emp_telefono);
                    $('#correo').val(empleado.emp_correo);
                    $('#direccion').val(empleado.emp_direccion);
                    
                    $('button[type="submit"]').text('Actualizar Empleado');
                } else {
                    alert('Empleado no encontrado');
                }
            }
        });
    });

    // Manejar el clic en el botón de eliminar
    $('#employeesTable tbody').on('click', '.btn-delete', function() {
        const empId = $(this).data('id');
        const cedula = $(this).closest('tr').find('td:eq(1)').text(); // Obtener la cédula del empleado

        if (confirm("¿Estás seguro de que deseas eliminar este empleado?")) {
            $.ajax({
                url: '../AJAX/ctrEmpleados.php',
                type: 'POST',
                data: { action: 'deleteEmpleado', emp_id: empId, cedula: cedula },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        alert('Empleado eliminado correctamente');
                        employeesTable.ajax.reload();
                    } else {
                        alert('Error al eliminar empleado: ' + response.message);
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
