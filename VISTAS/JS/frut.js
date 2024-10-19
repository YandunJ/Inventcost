$(document).ready(function() {
    // Inicializar DataTable
    var table = $('#fruitsTable').DataTable({
        "ajax": {
            "url": "../AJAX/ctrFrutas.php",
            "type": "POST",
            "data": { action: "obtenerFrutas" }
        },
        "columns": [
            { "data": "fruta_id" },
            { "data": "nombre" },
            { "data": "descripcion" },
            {
                "data": null,
                "defaultContent": `
                    <button class="editFruit btn btn-warning btn-sm">Editar</button>
                    <button class="deleteFruit btn btn-danger btn-sm">Eliminar</button>
                `
            }
        ]
    });

    var editing = false;
    var currentId = null;

     // Función para validar el nombre de la fruta
     function validateFruitName(name) {
        // Expresión regular para permitir solo letras y espacios
        var regex = /^[A-Za-z\s]+$/;
        return regex.test(name);
    }

 // Manejar la acción de agregar fruta
 $('#fruitForm').on('submit', function(e) {
    e.preventDefault();

    var nombre = $('#nombre').val();
    
    // Validar el nombre antes de proceder
    if (!validateFruitName(nombre)) {
        Swal.fire({
            icon: 'error',
            title: 'Error de validación',
            text: 'El nombre de la fruta solo puede contener letras y espacios.'
        });
        return; // Detener el proceso si hay un error
    }

    var action = editing ? 'updateFruta' : 'addFruta';
    var formData = {
        action: action,
        opcion: editing ? 2 : 1, // opción 1 para inserción, opción 2 para actualización
        nombre: nombre,
        descripcion: $('#descripcion').val()
    };

    if (editing) {
        formData.fruta_id = currentId;
    }

    $.ajax({
        url: '../AJAX/ctrFrutas.php',
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                Swal.fire({
                    icon: 'success',
                    title: editing ? 'Actualización exitosa' : 'Registro exitoso',
                    text: editing ? 'Fruta actualizada correctamente' : 'Fruta registrada correctamente'
                });
                // Limpiar el formulario
                $('#fruitForm')[0].reset();
                // Recargar la tabla de frutas
                table.ajax.reload();
                // Resetear el estado de edición
                editing = false;
                currentId = null;
                $('#fruitForm button[type="submit"]').text('Agregar Fruta');
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
});


  // Editar y eliminar frutas
  $('#fruitsTable tbody').on('click', 'button', function() {
    var action = $(this).hasClass('editFruit') ? 'edit' : 'delete';
    var data = table.row($(this).parents('tr')).data();

    if (action === 'edit') {
        // Llenar el formulario con los datos de la fruta
        $('#nombre').val(data.nombre);
        $('#descripcion').val(data.descripcion);
        // Cambiar el estado de edición y guardar el id actual
        editing = true;
        currentId = data.fruta_id;
        $('#fruitForm button[type="submit"]').text('Actualizar Fruta');
    } else if (action === 'delete') {
        // Mensaje de confirmación utilizando SweetAlert
        Swal.fire({
            title: '¿Estás seguro?',
            text: 'Estás a punto de eliminar esta fruta.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrFrutas.php',
                    type: 'POST',
                    data: { action: 'deleteFruta', fruta_id: data.fruta_id },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire(
                                'Eliminada!',
                                'Fruta eliminada correctamente',
                                'success'
                            );
                            // Recargar la tabla de frutas
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

let formModified = false;

    // Detectar cambios en el formulario
    $("#fruitForm input, #fruitForm select").on("input change", function() {
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

