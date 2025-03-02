$(document).ready(function () {
    function formatPresentaciones(presentaciones) {
        return presentaciones.map(p => `${p.nombre} (${p.cantidad} ${p.estado})`).join(', ');
    }

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

    var table = $('#tablaLotesPT').DataTable({
        "data": datosEjemplo,
        "columns": [
            { "data": "lote" },
            { "data": "fecha_produccion" },
            {
                "data": "presentaciones",
                "render": function (data, type, row) {
                    return formatPresentaciones(data);
                }
            },
            { "data": "total_disponible" }
        ],
        "order": [[1, 'asc']]
    });

    $('#tablaLotesPT tbody').on('click', 'tr', function () {
        var data = table.row(this).data();
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
});