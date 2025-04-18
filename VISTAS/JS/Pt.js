$(document).ready(function () {
    // Inicializar DataTables
    var tableLotes = $('#tablaLotesPT').DataTable({
        "ajax": {
            "url": "../AJAX/ctrProducto.php",
            "type": "POST",
            "data": { accion: "obtenerLotesProductoTerminado" },
            "dataSrc": function (json) {
                if (json.estado === 'exito') {
                    return json.datos;
                } else {
                    console.error("Error al cargar datos: ", json.mensaje);
                    return [];
                }
            }
        },
        "columns": [
            { "data": "lote" },
            { "data": "fecha_produccion" },
            { "data": "total_disponible" },
            { "data": "precio_total" },
            {
                "data": null,
                "defaultContent": '<button class="btn btn-info btnDetalles">Detalles</button>',
                "orderable": false
            }
        ],
        "order": [[1, 'asc']]
    });

    // Generar PDF
    $('#btnGenerarPDF').on('click', function () {
        window.open('../AJAX/PDFpt1.php', '_blank');
    });

    // Detalles expandidos
    $('#tablaLotesPT tbody').on('click', '.btnDetalles', function () {
        var data = tableLotes.row($(this).parents('tr')).data();
        $.ajax({
            url: "../AJAX/ctrProducto.php",
            type: "POST",
            data: { accion: "obtenerDetallesLote", lote_PT: data.lote },
            dataType: "json",
            success: function (response) {
                if (response.estado === 'exito') {
                    var detalles = response.datos;
                    var detailsHtml = '<table class="table table-bordered table-hover table-compact"><thead><tr><th>Presentación</th><th>Cantidad Disponible</th><th>Precio Unitario</th><th>Precio Total</th><th>Precio Venta Sugerido</th><th>Fecha Caducidad</th><th>Composición</th><th>Observación</th><th>Acciones</th></tr></thead><tbody>';
                    detalles.forEach(function (detalle) {
                        detailsHtml += '<tr><td>' + detalle.presentacion + '</td><td>' + detalle.cant_disponible + '</td><td>' + detalle.p_u + '</td><td>' + detalle.p_t + '</td><td>' + detalle.p_v_s + '</td><td>' + detalle.fecha_caducidad + '</td><td>' + detalle.composicion + '</td><td>' + (detalle.observacion ? detalle.observacion : '') + '</td><td><button class="btn btn-primary btnEditarObservacion" data-id="' + detalle.id_pt + '">Editar</button></td></tr>';
                    });
                    detailsHtml += '</tbody></table>';
                    Swal.fire({
                        title: 'Detalles del Lote ' + data.lote,
                        html: detailsHtml,
                        width: '80%',
                        showCloseButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Cerrar',
                        customClass: {
                            popup: 'modal-detalles'
                        }
                    });

                    // Manejar el clic en el botón de editar observación
                    $('.btnEditarObservacion').on('click', function () {
                        var id_pt = $(this).data('id');
                        var observacionActual = $(this).closest('tr').find('td').eq(7).text();
                        Swal.fire({
                            title: 'Editar Observación',
                            input: 'textarea',
                            inputValue: observacionActual,
                            showCancelButton: true,
                            confirmButtonText: 'Guardar',
                            cancelButtonText: 'Cancelar',
                            preConfirm: (observacion) => {
                                return new Promise((resolve) => {
                                    $.ajax({
                                        url: "../AJAX/ctrProducto.php",
                                        type: "POST",
                                        data: { accion: "actualizarObservacion", id_pt: id_pt, observacion: observacion },
                                        dataType: "json",
                                        success: function (response) {
                                            if (response.estado === 'exito') {
                                                resolve();
                                            } else {
                                                Swal.showValidationMessage('Error: ' + response.mensaje);
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            Swal.showValidationMessage('Error: ' + error);
                                        }
                                    });
                                });
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                Swal.fire('Guardado', 'La observación ha sido actualizada.', 'success');
                                tableLotes.ajax.reload();
                            }
                        });
                    });
                } else {
                    console.error("Error al cargar detalles: ", response.mensaje);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });
});