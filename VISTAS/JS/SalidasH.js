$(document).ready(function () {
    const tablaHistorialSalidas = $('#tablaHistorialSalidas').DataTable({
        ajax: {
            url: '../AJAX/ctrSalidasH.php',
            type: 'POST',
            data: { action: 'obtenerHistorialSalidas' },
            dataSrc: 'data',
        },
        order: [[0, 'desc']], // Ordenar por la columna de fecha de despacho en orden descendente
        columns: [
            { data: 'fecha_despacho' },
            { data: 'estado' },
            { data: 'cantidad_total' },
            { data: 'precio_total' },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle btn-sm" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item ver-detalles-btn" href="#" data-id="${row.id_despacho}">
                                    <i class="fas fa-eye"></i> Ver Detalles
                                </a>
                                <a class="dropdown-item generar-comprobante-btn" href="#" data-id="${row.id_despacho}">
                                    <i class="fas fa-file-alt"></i> Generar Comprobante
                                </a>
                            </div>
                        </div>
                    `;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                        <button class="btn btn-danger btn-sm cancelar-despacho-btn" data-id="${row.id_despacho}">
                            <i class="fas fa-times"></i> Cancelar
                        </button>
                    `;
                }
            }
        ],
        language: dataTableLanguage
    });

    // Manejar el clic en el botón de ver detalles
    $('#tablaHistorialSalidas tbody').on('click', '.ver-detalles-btn', function () {
        const idDespacho = $(this).data('id');
        
        // Llamar al SP para obtener los detalles del despacho
        $.ajax({
            url: '../AJAX/ctrSalidasH.php',
            type: 'POST',
            data: { action: 'obtenerDetallesSalida', idDespacho: idDespacho },
            success: function (response) {
                console.log("Respuesta del servidor:", response); // Depuración
    
                try {
                    const result = JSON.parse(response);
    
                    if (result.status === 'success') {
                        const detalles = result.data;
    
                        // Llenar los datos generales del despacho
                        $('#detalleNComprobante').text(detalles[0].n_comprobante);
                        $('#detalleFechaDespacho').text(detalles[0].fecha_despacho);
                        $('#detalleCantidadTotal').text(detalles[0].cantidad_total);
                        $('#detallePrecioTotal').text(detalles[0].precio_total);
    
                        // Llenar la tabla de detalles de productos
                        const tbody = $('#detalleProductos');
                        tbody.empty(); // Limpiar el contenido anterior
    
                        detalles.forEach(detalle => {
                            tbody.append(`
                                <tr>
                                    <td>${detalle.lote}</td>
                                    <td>${detalle.presentacion}</td>
                                    <td>${detalle.composicion}</td>
                                    <td>${detalle.cantidad_despachada}</td>
                                    <td>${detalle.precio_venta}</td>
                                </tr>
                            `);
                        });
    
                        // Mostrar el modal
                        $('#detalleSalidaModal').modal('show');
                    } else {
                        Swal.fire('Error', result.message, 'error');
                    }
                } catch (e) {
                    console.error("Error al parsear la respuesta:", e);
                    Swal.fire('Error', 'Hubo un problema al procesar la respuesta del servidor.', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'Hubo un problema al obtener los detalles.', 'error');
            }
        });
    });

    $('#tablaHistorialSalidas tbody').on('click', '.cancelar-despacho-btn', function () {
        const idDespacho = $(this).data('id');
    
        Swal.fire({
            title: '¿Está seguro de que desea cancelar este despacho?',
            text: "Esta acción no se puede revertir y las cantidades despachadas serán devueltas al inventario.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, cancelar',
            cancelButtonText: 'No, mantener'
        }).then((result) => {
            if (result.isConfirmed) {
                // Llamar al SP para cancelar el despacho
                $.ajax({
                    url: '../AJAX/ctrSalidasH.php',
                    type: 'POST',
                    data: { action: 'cancelarDespacho', idDespacho: idDespacho },
                    success: function (response) {
                        console.log("Respuesta del servidor:", response); // Depuración
    
                        try {
                            const result = JSON.parse(response);
    
                            if (result.status === 'success') {
                                Swal.fire('Cancelado', result.message, 'success');
                                tablaHistorialSalidas.ajax.reload(); // Recargar la tabla
                            } else {
                                Swal.fire('Error', result.message, 'error');
                            }
                        } catch (e) {
                            console.error("Error al parsear la respuesta:", e);
                            Swal.fire('Error', 'Hubo un problema al procesar la respuesta del servidor.', 'error');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error en la solicitud AJAX:", error); // Depuración
                        Swal.fire('Error', 'Hubo un problema al cancelar el despacho: ' + error, 'error');
                    }
                });
            }
        });
    });
});