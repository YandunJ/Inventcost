$(document).ready(function() {
    var table = $('#insumosTable').DataTable({
        "ajax": {
            "url": "../AJAX/ctrInsumos.php",
            "type": "POST",
            "data": { action: "obtenerInsumos" },
            "dataSrc": "data" // Asegúrate de que la respuesta contenga esta estructura
        },
        "columns": [
            { "data": "insumo_id" },
            { "data": "nombre" },
            { "data": "descripcion" },
            { "data": "unidad_medida" },
            { "data": "destino" }, // Cambié a "destinado_a" para que coincida con tu tabla
            {
                "data": null,
                "defaultContent": `
                    <button class="editInsumo btn btn-warning btn-sm">Editar</button>
                    <button class="deleteInsumo btn btn-danger btn-sm">Eliminar</button>
                `
            }
        ]
    });

    var editing = false;
    var currentId = null;

    $('#insumoForm').on('submit', function(e) {
        e.preventDefault();

        var action = editing ? 'updateInsumo' : 'addInsumo';
        var formData = {
            action: action,
            opcion: editing ? 2 : 1,
            nombre: $('#nombre').val(),
            descripcion: $('#descripcion').val(),
            unidad_medida: $('#unidad_medida').val(),
            destino: $('#destinado_a').val()
        };

        if (editing) {
            formData.insumo_id = currentId;
        }

        Swal.fire({
            title: editing ? '¿Actualizar Insumo?' : '¿Agregar Insumo?',
            text: editing ? '¿Está seguro de que desea actualizar este insumo?' : '¿Está seguro de que desea agregar este insumo?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrInsumos.php',
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: editing ? 'Insumo actualizado correctamente' : 'Insumo registrado correctamente'
                            });
                            $('#insumoForm')[0].reset();
                            table.ajax.reload();
                            editing = false;
                            currentId = null;
                            $('#insumoForm button[type="submit"]').text('Agregar Insumo');
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.message
                            });
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error en la solicitud AJAX:', textStatus, errorThrown);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error en la solicitud',
                            text: 'Error en la solicitud AJAX: ' + textStatus
                        });
                    }
                });
            }
        });
    });


    $('#insumosTable tbody').on('click', 'button', function() {
        var action = $(this).hasClass('editInsumo') ? 'edit' : 'delete';
        var data = table.row($(this).parents('tr')).data();

        if (action === 'edit') {
            $('#nombre').val(data.nombre);
            $('#descripcion').val(data.descripcion);
            $('#unidad_medida').val(data.unidad_medida);
            $('#destinado_a').val(data.destinado_a);
            editing = true;
            currentId = data.insumo_id;
            $('#insumoForm button[type="submit"]').text('Actualizar Insumo');
        } else if (action === 'delete') {
            Swal.fire({
                title: '¿Estás seguro?',
                text: 'Estás a punto de eliminar este insumo.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '../AJAX/ctrInsumos.php',
                        type: 'POST',
                        data: { action: 'deleteInsumo', insumo_id: data.insumo_id },
                        dataType: 'json',
                        success: function(response) {
                            if (response.status === 'success') {
                                Swal.fire(
                                    'Eliminado!',
                                    'Insumo eliminado correctamente',
                                    'success'
                                );
                                table.ajax.reload();
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: response.message
                                });
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.error('Error en la solicitud AJAX:', textStatus, errorThrown);
                            Swal.fire({
                                icon: 'error',
                                title: 'Error en la solicitud',
                                text: 'Error en la solicitud AJAX: ' + textStatus
                            });
                        }
                    });
                }
            });
        }
    });


    $.ajax({
        url: '../AJAX/ctrInsumos.php',
        type: 'POST',
        data: { action: 'obtenerInsumos' },
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                table.clear().rows.add(response.data).draw(); // Asegúrate de que esto esté correcto
            } else {
                alert('Error: ' + response.message);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error('Error en la solicitud AJAX:', textStatus, errorThrown);
            alert('Error en la solicitud AJAX: ' + textStatus);
        }
    });

    
    
    let formModified = false;

    // Detectar cambios en el formulario
    $("#insumoForm input, #insumoForm select").on("input change", function() {
        formModified = true;
    });

    // Evento beforeunload para detectar si se intenta cerrar o recargar la página
    window.addEventListener("beforeunload", function(e) {
        if (formModified) {
            const confirmationMessage = "Tienes datos sin guardar. ¿Estás seguro de que deseas salir?";
            e.returnValue = confirmationMessage; // Establece el mensaje
            return confirmationMessage;
        }
    });

    // Capturar clics en el menú lateral
    $("a").on("click", function(e) {
        if (formModified) {
            e.preventDefault(); // Prevenir la navegación
            Swal.fire({
                title: "Tienes datos sin guardar",
                text: "¿Estás seguro de que deseas salir sin guardar?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, salir",
                cancelButtonText: "Cancelar"
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = $(this).attr("href"); // Redirigir si confirma
                }
            });
        }
    });

    // El botón de cancelar regresa a la página anterior
    $("#cancelButton").on("click", function() {
        if (formModified) {
            Swal.fire({
                title: "Tienes datos sin guardar",
                text: "¿Estás seguro de que deseas salir sin guardar?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, salir",
                cancelButtonText: "Cancelar"
            }).then((result) => {
                if (result.isConfirmed) {
                    window.history.back(); // Regresa a la página anterior
                }
            });
        } else {
            window.history.back(); // Regresa a la página anterior
        }
    });
});