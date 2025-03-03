$(document).ready(function () {
    // Datos de ejemplo
    var datosEjemplo = [
        {
            "lote": "PT_0103251",
            "fecha_produccion": "2025-03-01",
            "presentaciones": [
                {
                    "nombre": "100 gr",
                    "cantidad": "10.00",
                    "precio_unitario": "5.00",
                    "precio_venta_sugerido": "6.00",
                    "composicion": "MANZANA, PERA",
                    "estado": "disponible"
                },
                {
                    "nombre": "200 gr",
                    "cantidad": "5.00",
                    "precio_unitario": "10.00",
                    "precio_venta_sugerido": "12.00",
                    "composicion": "MANZANA, PERA",
                    "estado": "stock bajo"
                }
            ],
            "total_disponible": "15.00"
        },
        {
            "lote": "PT_0103252",
            "fecha_produccion": "2025-03-01",
            "presentaciones": [
                {
                    "nombre": "100 gr",
                    "cantidad": "8.00",
                    "precio_unitario": "5.00",
                    "precio_venta_sugerido": "6.00",
                    "composicion": "MANZANA",
                    "estado": "disponible"
                },
                {
                    "nombre": "500 gr",
                    "cantidad": "3.00",
                    "precio_unitario": "20.00",
                    "precio_venta_sugerido": "24.00",
                    "composicion": "MANZANA, FRESA",
                    "estado": "agotado"
                }
            ],
            "total_disponible": "11.00"
        }
    ];

    var datosPresentaciones = [
        {
            "nombre": "100 gr",
            "cantidad": "18.00",
            "precio_unitario": "5.00",
            "precio_venta_sugerido": "6.00",
            "composicion": "MANZANA, PERA",
            "estado": "disponible"
        },
        {
            "nombre": "200 gr",
            "cantidad": "5.00",
            "precio_unitario": "10.00",
            "precio_venta_sugerido": "12.00",
            "composicion": "MANZANA, PERA",
            "estado": "stock bajo"
        },
        {
            "nombre": "500 gr",
            "cantidad": "3.00",
            "precio_unitario": "20.00",
            "precio_venta_sugerido": "24.00",
            "composicion": "MANZANA, FRESA",
            "estado": "agotado"
        }
    ];

    // Inicializar Datepickers
    $("#fechaInicio, #fechaFin").datepicker({
        dateFormat: "yy-mm-dd"
    });

    // Inicializar DataTables
    var tableLotes = $('#tablaLotesPT').DataTable({
        "data": datosEjemplo,
        "columns": [
            { "data": "lote" },
            { "data": "fecha_produccion" },
            {
                "data": "presentaciones",
                "render": function (data, type, row) {
                    return data.map(p => `${p.nombre} (${p.cantidad} ${p.estado})`).join(', ');
                }
            },
            { "data": "total_disponible" },
            {
                "data": null,
                "defaultContent": '<button class="btn btn-info btnDetalles">Detalles</button>',
                "orderable": false
            }
        ],
        "order": [[1, 'asc']]
    });

    var tablePresentaciones = $('#tablaPresentacionesPT').DataTable({
        "data": datosPresentaciones,
        "columns": [
            { "data": "nombre" },
            { "data": "cantidad" },
            { "data": "precio_unitario" },
            { "data": "precio_venta_sugerido" },
            { "data": "composicion" },
            { "data": "estado" },
            {
                "data": null,
                "defaultContent": '<button class="btn btn-info btnDetalles">Detalles</button>',
                "orderable": false
            }
        ],
        "order": [[0, 'asc']]
    });

    // Filtros
    $('#btnConsultar').on('click', function () {
        var filtroTipo = $('#filtroTipo').val();
        var filtroEstado = $('#filtroEstado').val();
        var fechaInicio = $('#fechaInicio').val();
        var fechaFin = $('#fechaFin').val();

        if (filtroTipo === 'lotes') {
            $('#tablaLotesPT_wrapper').show();
            $('#tablaPresentacionesPT_wrapper').hide();
            tableLotes.column(2).search(filtroEstado).draw();
            tableLotes.draw();
        } else {
            $('#tablaLotesPT_wrapper').hide();
            $('#tablaPresentacionesPT_wrapper').show();
            tablePresentaciones.column(5).search(filtroEstado).draw();
        }
    });

    // Custom filtering function for date range
    $.fn.dataTable.ext.search.push(
        function (settings, data, dataIndex) {
            if (settings.nTable.id !== 'tablaLotesPT') {
                return true;
            }
            var min = $('#fechaInicio').datepicker("getDate");
            var max = $('#fechaFin').datepicker("getDate");
            var date = new Date(data[1]);

            if (
                (min === null && max === null) ||
                (min === null && date <= max) ||
                (min <= date && max === null) ||
                (min <= date && date <= max)
            ) {
                return true;
            }
            return false;
        }
    );

    // Detalles expandidos
    $('#tablaLotesPT tbody').on('click', '.btnDetalles', function () {
        var data = tableLotes.row($(this).parents('tr')).data();
        var details = formatDetails(data.presentaciones);
        Swal.fire({
            title: `Detalles del Lote ${data.lote}`,
            html: details,
            width: '80%',
            showCloseButton: true,
            focusConfirm: false,
            confirmButtonText: 'Cerrar'
        });
    });

    $('#tablaPresentacionesPT tbody').on('click', '.btnDetalles', function () {
        var data = tablePresentaciones.row($(this).parents('tr')).data();
        var details = formatDetails([data]);
        Swal.fire({
            title: `Detalles de la Presentación ${data.nombre}`,
            html: details,
            width: '80%',
            showCloseButton: true,
            focusConfirm: false,
            confirmButtonText: 'Cerrar'
        });
    });

    function formatDetails(presentaciones) {
        let details = `<table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Presentación</th>
                    <th>Cantidad Disponible</th>
                    <th>Precio Unitario</th>
                    <th>Precio Venta Sugerido</th>
                    <th>Composición</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>`;

        presentaciones.forEach(presentacion => {
            details += `<tr>
                <td>${presentacion.nombre}</td>
                <td>${presentacion.cantidad}</td>
                <td>${presentacion.precio_unitario}</td>
                <td>${presentacion.precio_venta_sugerido}</td>
                <td>${presentacion.composicion}</td>
                <td><span class="badge ${presentacion.estado === 'disponible' ? 'bg-success' : presentacion.estado === 'stock bajo' ? 'bg-warning' : 'bg-danger'}">${presentacion.estado}</span></td>
            </tr>`;
        });

        details += '</tbody></table>';
        return details;
    }
});