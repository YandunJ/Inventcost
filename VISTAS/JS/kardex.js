$(document).ready(function () {
    const tablaKardex = $('#tablaKardex').DataTable({
        ajax: {
            url: '../AJAX/ctrKardex.php',
            type: 'POST',
            data: function (d) {
                d.action = 'getKardex';
                d.categoria_id = $('#selectCategoria').val();
                const mes = $('#monthPicker').val();
                d.fecha_inicio = mes + '-01';
                d.fecha_fin = new Date(mes.split('-')[0], mes.split('-')[1], 0).toISOString().split('T')[0];
            },
            dataSrc: 'data',
        },
        columns: [
            { data: 'Producto' },
            { data: 'Presentación' },
            { data: 'Entradas' },
            { data: 'Salidas' },
            { data: 'Saldo_Final' },
            {
                data: null,
                render: function (data) {
                    return `<button class="btn btn-info btn-detalle" data-id="${data.cat_id}">Ver Detalle</button>`;
                },
            },
        ],
        language: dataTableLanguage
    });

    $('#btnFiltrar').on('click', function () {
        tablaKardex.ajax.reload();
    });

    $('#tablaKardex tbody').on('click', '.btn-detalle', function () {
        const cat_id = $(this).data('id');
        const mes = $('#monthPicker').val();
        const fecha_inicio = mes + '-01';
        const fecha_fin = new Date(mes.split('-')[0], mes.split('-')[1], 0).toISOString().split('T')[0];

        $.ajax({
            url: '../AJAX/ctrKardex.php',
            type: 'POST',
            data: {
                action: 'getDetalleKardex',
                cat_id: cat_id,
                fecha_inicio: fecha_inicio,
                fecha_fin: fecha_fin
            },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    // Mostrar los detalles en un modal o en una nueva tabla
                    mostrarDetalles(response.data);
                } else {
                    alert(response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });

    function mostrarDetalles(data) {
        let detallesHtml = '<table class="table table-bordered table-hover table-compact"><thead><tr><th>ID</th><th>Fecha</th><th>Lote</th><th>Cantidad</th><th>Stock Anterior</th><th>Stock Actual</th><th>Tipo Movimiento</th></tr></thead><tbody>';
        data.forEach(function (detalle) {
            detallesHtml += `<tr>
                <td>${detalle.id_kardex}</td>
                <td>${detalle.fecha_hora}</td>
                <td>${detalle.lote}</td>
                <td>${detalle.cantidad}</td>
                <td>${detalle.stock_anterior}</td>
                <td>${detalle.stock_actual}</td>
                <td>${detalle.tipo_movimiento}</td>
            </tr>`;
        });
        detallesHtml += '</tbody></table>';

        // Mostrar los detalles en un modal
        $('#detalleModal .modal-body').html(detallesHtml);
        $('#detalleModal').modal('show');
    }
});