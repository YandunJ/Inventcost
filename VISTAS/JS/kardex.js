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
            { data: 'saldo' },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                        <button class="btn btn-primary btn-sm ver-entradas" data-id="${row.articulo}">
                            Ver
                        </button>
                    `;
                }
            }
        ],
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

    // Inicializar DataTable para el modal
    const tablaEntradas = $('#tablaEntradas').DataTable({
        columns: [
            { data: 'FechaHora' },
            { data: 'Lote' },
            { data: 'Proveedor' },
            { data: 'Articulo' },
            { data: 'Presentacion' },
            { data: 'CantidadInicial' },
            { data: 'CantidadDisponible' },
            { data: 'PrecioUnitario' },
            { data: 'PrecioTotal' },
            { data: 'Estado' },
            { data: 'Brix' },
            { data: 'Observacion' },
            { data: 'TipoMovimiento' }
        ],
        language: dataTableLanguage
    });

    // Manejar el evento de clic en el botón "Ver"
    $('#tablaKardex').on('click', '.ver-entradas', function () {
        const articuloId = $(this).data('id');
        console.log("ID del artículo:", articuloId); // Verificar el ID del artículo

        // Cargar los datos de entradas para el artículo seleccionado
        $.ajax({
            url: '../AJAX/ctrKardex.php',
            type: 'POST',
            data: { action: 'cargarEntradas', articuloId: articuloId },
            dataType: 'json',
            success: function (response) {
                console.log("Respuesta del servidor:", response); // Verificar la respuesta del servidor
                if (response.status === 'success') {
                    console.log("Datos recibidos:", response.data); // Agrega esto para depurar
                    tablaEntradas.clear().rows.add(response.data).draw();
                    $('#modalEntradas').modal('show');
                } else {
                    Swal.fire('Error', response.message || 'No se encontraron datos.', 'error');
                }
            },
            error: function (xhr, status, error) {
                Swal.fire('Error', 'Ocurrió un error al cargar los datos.', 'error');
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });
});