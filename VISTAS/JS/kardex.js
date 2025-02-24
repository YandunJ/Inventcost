$(document).ready(function () {
    // Establecer el valor del selector de mes al mes actual
    const fechaActual = new Date();
    const mesActual = fechaActual.toISOString().slice(0, 7); // Formato YYYY-MM
    $('#monthPicker').val(mesActual);

    // Inicializar DataTable
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
                    return `<button class="btn btn-info btn-detalle" data-id="${data.cat_id}" data-ctg-id="${data.ctg_id}">Ver Detalle</button>`;
                },
            },
        ],
        language: dataTableLanguage
    });

    // Realizar la consulta inicial al cargar la página
    tablaKardex.ajax.reload();

    // Evento para filtrar los datos
    $('#btnFiltrar').on('click', function () {
        tablaKardex.ajax.reload();
    });

    // Evento para mostrar los detalles
    $('#tablaKardex tbody').on('click', '.btn-detalle', function () {
        const cat_id = $(this).data('id');
        const ctg_id = $(this).data('ctg-id');
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
                    mostrarDetalles(response.data, ctg_id);
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

    function mostrarDetalles(data, ctg_id) {
        let detallesHtml = '<table class="table table-bordered table-hover table-compact"><thead><tr><th>ID</th><th>Fecha</th><th>Lote</th><th>Cantidad</th><th>Precio Unitario</th><th>Precio Total</th>';
        if (ctg_id == 1) {
            detallesHtml += '<th>Proveedor</th><th>Brix</th><th>Observación</th>';
        } else if (ctg_id == 2) {
            detallesHtml += '<th>Proveedor</th><th>Fecha Elaboración</th><th>Fecha Caducidad</th>';
        }
        detallesHtml += '<th>Tipo Movimiento</th></tr></thead><tbody>';
        data.forEach(function (detalle) {
            detallesHtml += `<tr>
                <td>${detalle.id_kardex}</td>
                <td>${detalle.fecha_hora}</td>
                <td>${detalle.lote}</td>
                <td>${detalle.cantidad}</td>
                <td>${detalle.precio_unitario}</td>
                <td>${detalle.precio_total}</td>`;
            if (ctg_id == 1) {
                detallesHtml += `<td>${detalle.proveedor}</td>
                                 <td>${detalle.brix}</td>
                                 <td>${detalle.observacion}</td>`;
            } else if (ctg_id == 2) {
                detallesHtml += `<td>${detalle.proveedor}</td>
                                 <td>${detalle.fecha_elaboracion}</td>
                                 <td>${detalle.fecha_caducidad}</td>`;
            }
            detallesHtml += `<td>${detalle.tipo_movimiento}</td></tr>`;
        });
        detallesHtml += '</tbody></table>';

        // Mostrar los detalles en el modal
        $('#detalleModal .modal-body').html(detallesHtml);
        $('#detalleModal').modal('show');
    }
});