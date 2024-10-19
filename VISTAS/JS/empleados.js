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

    function validarCedulaEcuatoriana(cedula) {
        if (cedula.length !== 10) return false;

        const coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
        let suma = 0;

        for (let i = 0; i < 9; i++) {
            let digito = parseInt(cedula[i]) * coeficientes[i];
            if (digito > 9) digito -= 9;
            suma += digito;
        }

        const digitoVerificadorCalculado = (10 - (suma % 10)) % 10;
        const digitoVerificador = parseInt(cedula[9]);

        return digitoVerificadorCalculado === digitoVerificador;
    }

    // Manejar el envío del formulario para registrar o actualizar empleados
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

        if (!validarCedulaEcuatoriana(formData.cedula)) {
            $('#cedulaError').text('Cédula inválida. Por favor, verifique e intente nuevamente.');
            return;
        } else {
            $('#cedulaError').text('');
        }

        const isUpdate = formData.emp_id !== ''; // Verifica si es una actualización
        const actionText = isUpdate ? 'actualizar' : 'registrar';

        Swal.fire({
            title: `¿Estás seguro de ${actionText} este empleado?`,
            text: `Se va a ${actionText} la información del empleado.`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: `Sí, ${actionText}`,
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrEmpleados.php',
                    type: 'POST',
                    data: { action: 'addOrUpdateEmpleado', ...formData },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: 'Éxito',
                                text: isUpdate ? 'Empleado actualizado exitosamente' : 'Empleado registrado exitosamente',
                            });
                            employeesTable.ajax.reload();
                            $('#employeeForm')[0].reset();
                            $('#emp_id').val('');
                            $('button[type="submit"]').text('Agregar Empleado');
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Error: ' + response.message,
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error inesperado',
                            text: xhr.responseText,
                        });
                    }
                });
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
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Empleado no encontrado',
                    });
                }
            }
        });
    });

    // Manejar el clic en el botón de eliminar
    $('#employeesTable tbody').on('click', '.btn-delete', function() {
        const empId = $(this).data('id');
        const cedula = $(this).closest('tr').find('td:eq(1)').text(); 

        Swal.fire({
            title: '¿Estás seguro?',
            text: "Esta acción no se puede deshacer",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrEmpleados.php',
                    type: 'POST',
                    data: { action: 'deleteEmpleado', emp_id: empId, cedula: cedula },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: 'Eliminado',
                                text: 'Empleado eliminado correctamente',
                            });
                            employeesTable.ajax.reload();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Error al eliminar empleado: ' + response.message,
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error inesperado',
                            text: xhr.responseText,
                        });
                    }
                });
            }
        });
    });
});
