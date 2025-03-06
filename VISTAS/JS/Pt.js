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
                    var detailsHtml = '<table class="table table-bordered table-hover table-compact"><thead><tr><th>ID</th><th>Presentación</th><th>Cantidad Ingresada</th><th>Cantidad Disponible</th><th>Precio Unitario</th><th>Precio Total</th><th>Precio Venta Sugerido</th><th>Fecha Caducidad</th><th>Composición</th><th>Estado</th><th>Observación</th></tr></thead><tbody>';
                    detalles.forEach(function (detalle) {
                        detailsHtml += '<tr><td>' + detalle.id_pt + '</td><td>' + detalle.presentacion + '</td><td>' + detalle.cant_ingresada + '</td><td>' + detalle.cant_disponible + '</td><td>' + detalle.p_u + '</td><td>' + detalle.p_t + '</td><td>' + detalle.p_v_s + '</td><td>' + detalle.fecha_caducidad + '</td><td>' + detalle.composicion + '</td><td>' + detalle.estado + '</td><td>' + (detalle.observacion ? detalle.observacion : '') + '</td></tr>';
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