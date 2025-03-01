$(document).ready(function () {
    // Inicializar el DataTable para mostrar las producciones registradas
    const tablaProducciones = $('#tablaProducciones').DataTable({
        ajax: {
            url: '../AJAX/ctrProduccionMP.php',
            type: 'POST',
            data: { action: 'obtenerProducciones' },
            dataSrc: function (json) {
                if (json.status === 'success') {
                    return json.data;
                }
                return [];
            }
        },
        columns: [
            { data: 'pro_id' }, // Asegúrate de que el pro_id se muestre en el DataTable
            { data: 'pro_fecha' },
            { data: 'pro_cant_producida' },
            { data: 'pro_subtotal_mtpm' },
            { data: 'pro_subtotal_ins' },
            { data: 'pro_subtotal_mo' },
            { data: 'pro_subtotal_ci' },
            { data: 'pro_total' },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item ver-btn" href="#" data-id="${row.pro_id}">
                                    <i class="fas fa-eye"></i> Ver
                                </a>
                                <a class="dropdown-item edit-btn" href="#" data-id="${row.pro_id}">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                                <a class="dropdown-item cancel-btn" href="#" data-id="${row.pro_id}">
                                    <i class="fas fa-times"></i> Cancelar
                                </a>
                            </div>
                        </div>
                    `;
                }
            }
        ],
        "language": dataTableLanguage
    });

    // Función para cargar y mostrar los detalles de una producción en el modal
    $('#tablaProducciones').on('click', '.ver-btn', function () {
        const pro_id = $(this).data('id');

        // Llamar al procedimiento almacenado para obtener los detalles de la producción
        $.ajax({
            url: '../AJAX/ctrProduccionMP.php',
            type: 'POST',
            data: { action: 'obtenerDetallesProduccion', pro_id: pro_id },
            success: function(response) {
                console.log("Response: ", response); // Imprimir la respuesta en la consola
                try {
                    const datos = JSON.parse(response);

                    if (datos.status === 'success') {
                        const costosAsociados = datos.data.costosAsociados;

                        // Cargar los costos asociados en la tabla
                        const costosAsociadosTable = $('#tablaCostosAsociados tbody');
                        costosAsociadosTable.empty();
                        costosAsociados.forEach(costo => {
                            costosAsociadosTable.append(`
                                <tr>
                                    <td>${costo.cst_id}</td>
                                    <td>${costo.cat_id}</td>
                                    <td>${costo.cst_cant}</td>
                                    <td>${costo.cst_presentacion}</td>
                                    <td>${costo.cst_horas_persona}</td>
                                    <td>${costo.cst_precio_ht}</td>
                                    <td>${costo.cst_total_horas_actividad}</td>
                                    <td>${costo.cst_costo_total}</td>
                                </tr>
                            `);
                        });

                        // Mostrar el modal
                        $('#verProduccionModal').modal('show');
                    } else {
                        console.error("Error: ", datos.message);
                    }
                } catch (e) {
                    console.error("Error parsing JSON: ", e);
                    console.error("Response: ", response);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });

    // Función para cancelar una producción
    $('#tablaProducciones').on('click', '.cancel-btn', function () {
        const pro_id = $(this).data('id');
        const confirmCancel = confirm('¿Está seguro de que desea cancelar esta producción? Esta acción no se puede deshacer.');

        if (confirmCancel) {
            // Llamar al procedimiento almacenado para cancelar la producción
            $.ajax({
                url: '../AJAX/ctrProduccionMP.php',
                type: 'POST',
                data: { action: 'cancelarProduccion', pro_id: pro_id },
                success: function(response) {
                    console.log("Response: ", response); // Imprimir la respuesta en la consola
                    try {
                        const result = JSON.parse(response);

                        if (result.status === 'success') {
                            alert('Producción cancelada correctamente');
                            // Actualizar el DataTable
                            tablaProducciones.ajax.reload();
                        } else {
                            alert('Error: ' + result.message);
                        }
                    } catch (e) {
                        alert('Error en la respuesta del servidor: ' + response);
                    }
                },
                error: function(xhr, status, error) {
                    alert('Error en la solicitud AJAX: ' + error);
                }
            });
        }
    });
});