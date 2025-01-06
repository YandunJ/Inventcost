$(document).ready(function () {
    $.fn.dataTable.ext.errMode = 'throw';

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
                console.log({ action: 'cargarKardex', fechaInicio, fechaFin, categoria });

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
            { data: 'Observacion' }
        ],
        language: dataTableLanguage
    });

    // Manejar el evento de clic en el botón "Ver"
    $('#tablaKardex').on('click', '.ver-entradas', function () {
        const articuloId = $(this).data('id');
        const fecha = $('#monthPicker').val();
        const [month, year] = fecha.split('/');
        const fechaInicio = `${year}-${month}-01`;
        const fechaFin = `${year}-${String(parseInt(month)).padStart(2, '0')}-${new Date(year, month, 0).getDate()}`;

        if (!articuloId) {
            Swal.fire('Error', 'No se pudo identificar el artículo.', 'error');
            return;
        }

        $('#contenidoEntradas').html('<p class="text-center">Cargando datos...</p>');

        $.ajax({
            url: '../AJAX/ctrInvFrutas.php', // Usar el controlador del módulo de lotes de frutas
            type: 'POST',
            data: {
                action: 'cargarMateriaPrima', // Acción para cargar los datos
                articuloId: articuloId,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin
            },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    if (response.data.length > 0) {
                        let tablaHTML = `
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Fecha y Hora</th>
                                        <th>Lote</th>
                                        <th>Proveedor</th>
                                        <th>Artículo</th>
                                        <th>Presentación</th>
                                        <th>Cant. Inicial</th>
                                        <th>Cant. Disp.</th>
                                        <th>Precio Unit.</th>
                                        <th>Precio Total</th>
                                        <th>Estado</th>
                                        <th>Brix</th>
                                        <th>Observación</th>
                                    </tr>
                                </thead>
                                <tbody>
                        `;
                        response.data.forEach(item => {
                            tablaHTML += `
                                <tr>
                                    <td>${item.FechaHora}</td>
                                    <td>${item.Lote}</td>
                                    <td>${item.Proveedor}</td>
                                    <td>${item.Articulo}</td>
                                    <td>${item.Presentacion}</td>
                                    <td>${item.CantidadInicial}</td>
                                    <td>${item.CantidadDisponible}</td>
                                    <td>${item.PrecioUnitario}</td>
                                    <td>${item.PrecioTotal}</td>
                                    <td>${item.Estado}</td>
                                    <td>${item.Brix}</td>
                                    <td>${item.Observacion}</td>
                                </tr>
                            `;
                        });
                        tablaHTML += `</tbody></table>`;
                        $('#contenidoEntradas').html(tablaHTML);
                    } else {
                        $('#contenidoEntradas').html('<p class="text-center">No hay registros para este artículo en el rango de fechas.</p>');
                    }
                } else {
                    Swal.fire('Error', response.message || 'No se encontraron datos.', 'error');
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                console.error("Respuesta del servidor:", xhr.responseText);
                $('#contenidoEntradas').html('<p class="text-center text-danger">Ocurrió un error al cargar los datos.</p>');
            }
        });

        $('#modalEntradas').modal('show');
    });
});