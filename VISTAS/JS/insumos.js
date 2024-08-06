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
            destino: $('#destinado_a').val() // Cambié a "destinado_a"
        };

        if (editing) {
            formData.insumo_id = currentId;
        }

        $.ajax({
            url: '../AJAX/ctrInsumos.php',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert(editing ? 'Insumo actualizado correctamente' : 'Insumo registrado correctamente');
                    $('#insumoForm')[0].reset();
                    table.ajax.reload();
                    editing = false;
                    currentId = null;
                    $('#insumoForm button[type="submit"]').text('Agregar Insumo');
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

    $('#insumosTable tbody').on('click', 'button', function() {
        var action = $(this).hasClass('editInsumo') ? 'edit' : 'delete';
        var data = table.row($(this).parents('tr')).data();

        if (action === 'edit') {
            $('#nombre').val(data.nombre);
            $('#descripcion').val(data.descripcion);
            $('#unidad_medida').val(data.unidad_medida); // Cargar unidad de medida
            $('#destinado_a').val(data.destinado_a); // Cargar destino
            editing = true;
            currentId = data.insumo_id;
            $('#insumoForm button[type="submit"]').text('Actualizar Insumo');
        } else if (action === 'delete') {
            if (confirm('¿Estás seguro de que quieres eliminar este insumo?')) {
                $.ajax({
                    url: '../AJAX/ctrInsumos.php',
                    type: 'POST',
                    data: { action: 'deleteInsumo', insumo_id: data.insumo_id },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            alert('Insumo eliminado correctamente');
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
    
    
});
