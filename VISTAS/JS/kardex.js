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
        ],
        language: dataTableLanguage
    });

    $('#btnFiltrar').on('click', function () {
        tablaKardex.ajax.reload();
    });
});