$(document).ready(function () {
    // Configuración del datepicker
    $('#monthPicker').datepicker({
        format: "mm/yyyy",
        startView: "months",
        minViewMode: "months",
        autoclose: true,
        todayHighlight: true,
        language: "es"
    });

    // Establecer el mes actual al cargar la página
    const today = new Date();
    const currentMonth = ('0' + (today.getMonth() + 1)).slice(-2); // Mes en formato MM
    const currentYear = today.getFullYear(); // Año en formato AAAA
    $('#monthPicker').val(`${currentMonth}/${currentYear}`);

    // Inicializar DataTable con carga automática
    const tablaKardex = $('#tablaKardex').DataTable({
        ajax: {
            url: '../AJAX/ctrKardex.php',
            type: 'POST',
            data: function () {
                const fecha = $('#monthPicker').val();
                const [month, year] = fecha.split('/');
                const fechaInicio = `${year}-${month}-01`;
                const fechaFin = `${year}-${String(parseInt(month)).padStart(2, '0')}-${new Date(year, month, 0).getDate()}`;
                const categoria = $('#selectCategoria').val();

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
        ,
        language: dataTableLanguage
    });

    // Botón para filtrar manualmente
    $('#btnFiltrar').on('click', function () {
        const fecha = $('#monthPicker').val();
        if (/^(0[1-9]|1[0-2])\/\d{4}$/.test(fecha)) {
            tablaKardex.ajax.reload();
        } else {
            Swal.fire('Atención', 'Por favor selecciona un mes válido en formato MM/AAAA.', 'warning');
        }
    });

    // Cargar datos del mes actual al iniciar
    tablaKardex.ajax.reload();
});
