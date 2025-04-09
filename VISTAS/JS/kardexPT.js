$(document).ready(function () {
    const tablaKardexPT = $('#tablaKardex').DataTable({
        ajax: {
            url: '../AJAX/ctrKardexPT.php',
            type: 'POST',
            data: function (d) {
                const mes = $('#monthPicker').val();
                const fecha_inicio = mes + '-01';
                const fecha_fin = new Date(mes.split('-')[0], mes.split('-')[1], 0).toISOString().split('T')[0];

                d.action = 'getKardexPT';
                d.fecha_inicio = fecha_inicio;
                d.fecha_fin = fecha_fin;
            },
            dataSrc: 'data',
        },
        columns: [
            { data: 'Presentacion' },  // Presentación
            { data: 'Saldo_Inicial' },  // Saldo inicial
            { data: 'Entradas' },  // Entradas
            { data: 'Salidas' },  // Salidas
            { data: 'Saldo_Final' },  // Saldo final
        ],
        language: dataTableLanguage
    });



    

    // Botón para filtrar por mes
    $('#btnFiltrar').on('click', function () {
        tablaKardexPT.ajax.reload();
    });

    // Botón para generar PDF
    $('#btnGenerarPDF').on('click', function () {
        const mes = $('#monthPicker').val();
        const fecha_inicio = mes + '-01';
        const fecha_fin = new Date(mes.split('-')[0], mes.split('-')[1], 0).toISOString().split('T')[0];

        const url = `../AJAX/PDF.php?fecha_inicio=${fecha_inicio}&fecha_fin=${fecha_fin}`;
        window.open(url, '_blank');
    });
});