// frut.js

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

    // Manejar la acción de agregar fruta
    $('#fruitForm').on('submit', function(e) {
        e.preventDefault();

        var action = editing ? 'updateFruta' : 'addFruta';
        var formData = {
            action: action,
            opcion: editing ? 2 : 1, // opción 1 para inserción, opción 2 para actualización
            nombre: $('#nombre').val(),
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
                    alert(editing ? 'Fruta actualizada correctamente' : 'Fruta registrada correctamente');
                    // Limpiar el formulario
                    $('#fruitForm')[0].reset();
                    // Recargar la tabla de frutas
                    table.ajax.reload();
                    // Resetear el estado de edición
                    editing = false;
                    currentId = null;
                    $('#fruitForm button[type="submit"]').text('Agregar Fruta');
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
            if (confirm('¿Estás seguro de que quieres eliminar esta fruta?')) {
                $.ajax({
                    url: '../AJAX/ctrFrutas.php',
                    type: 'POST',
                    data: { action: 'deleteFruta', fruta_id: data.fruta_id },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            alert('Fruta eliminada correctamente');
                            // Recargar la tabla de frutas
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
