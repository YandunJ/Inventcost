$(document).ready(function () {
    const tablaKardex = $('#tablaKardex').DataTable({
        ajax: {
            url: '../AJAX/ctrKardex.php',
            type: 'POST',
            data: function () {
                const mes = $('#selectMes').val();
                const categoria = $('#selectCategoria').val();
                const año = new Date().getFullYear();
                const fechaInicio = `${año}-${String(mes).padStart(2, '0')}-01`;
                const fechaFin = new Date(año, mes, 0).toISOString().split('T')[0];

                return { action: 'cargarKardex', fechaInicio, fechaFin, categoria };
            },
            dataSrc: function (json) {
                if (json.status === 'success') {
                    return json.data;
                } else {
                    Swal.fire('Error', json.message || 'No se encontraron datos.', 'error');
                    return [];
                }
            }
        },
        columns: [
            { data: 'articulo' },
            { data: 'categoria' },
            { data: 'presentacion' },
            { data: 'unidad', defaultContent: 'N/A' },
            { data: 'entradas' },
            { data: 'salidas' },
            { data: 'saldo' }
        ]
    });

    $('#btnFiltrar').on('click', function () {
        tablaKardex.ajax.reload();
    });
});
