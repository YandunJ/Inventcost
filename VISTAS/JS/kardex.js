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

    // Cargar categorías desde la base de datos
    function cargarCategorias() {
        $.ajax({
            url: '../AJAX/ctrKardex.php',
            type: 'POST',
            data: { action: 'obtenerCategorias' },
            success: function (response) {
                const result = JSON.parse(response);
                if (result.status === 'success') {
                    let opciones = '';
                    result.data.forEach(function (categoria) {
                        opciones += `<option value="${categoria.ctg_id}">${categoria.ctg_nombre}</option>`;
                    });
                    $('#selectCategoria').html(opciones);
                } else {
                    console.error("Error al cargar categorías: ", result.message);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    }

    // Configuración general para DataTables en español
    const dataTableLanguage = {
        lengthMenu: "Ver _MENU_ registros",
        zeroRecords: "No se encontraron resultados",
        info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
        infoEmpty: "No hay registros disponibles",
        infoFiltered: "(filtrado de _MAX_ registros totales)",
        search: "Buscar:",
        paginate: {
            first: "Primero",
            last: "Último",
            next: "Siguiente",
            previous: "Anterior"
        },
        loadingRecords: "Cargando...",
        processing: "Procesando..."
    };

    // Función para inicializar DataTables
    function inicializarDataTable(selector, ajaxUrl, data, columnas) {
        return $(selector).DataTable({
            autoWidth: false,
            responsive: true,
            paging: true,
            searching: true,
            ajax: {
                url: ajaxUrl,
                type: 'POST',
                data: data,
                dataSrc: function (json) {
                    if (json.status === 'success') {
                        return json.data;
                    }
                    return [];
                }
            },
            columns: columnas,
            language: dataTableLanguage
        });
    }

    // Inicializar DataTable para la vista general
    const columnasKardex = [
        { data: 'ID' },
        { data: 'Fecha' },
        { data: 'Artículo' },
        { data: 'Presentación' },
        { data: 'Entradas' },
        { data: 'Salidas' },
        { data: 'Saldo' },
        {
            data: null,
            render: function (data, type, row) {
                return `
                    <button class="btn btn-primary btn-sm ver-entradas" data-id="${row.ID}">
                        Ver
                    </button>
                `;
            }
        }
    ];

    const tablaKardex = inicializarDataTable('#tablaKardex', '../AJAX/ctrKardex.php', function () {
        const fecha = $('#monthPicker').val();
        const categoria = $('#selectCategoria').val();
        return { action: 'cargarKardex', fecha, categoria };
    }, columnasKardex);

    // Botón para filtrar manualmente
    $('#btnFiltrar').on('click', function () {
        const fecha = $('#monthPicker').val();
        if (/^(0[1-9]|1[0-2])\/\d{4}$/.test(fecha)) {
            tablaKardex.ajax.reload();
        } else {
            Swal.fire('Atención', 'Por favor selecciona un mes válido en formato MM/AAAA.', 'warning');
        }
    });

    // Inicializar DataTable para el modal
    const columnasEntradas = [
        { data: 'Fecha y Hora' },
        { data: 'Lote' },
        { data: 'Proveedor' },
        { data: 'Artículo' },
        { data: 'Presentación' },
        { data: 'Cantidad' },
        { data: 'Precio Unitario' },
        { data: 'Precio Total' },
        { data: 'Tipo de Movimiento' }
    ];

    const tablaEntradas = $('#tablaEntradas').DataTable({
        autoWidth: false,
        responsive: true,
        paging: true,
        searching: true,
        columns: columnasEntradas,
        language: dataTableLanguage
    });

    // Manejar el evento de clic en el botón "Ver"
    $('#tablaKardex').on('click', '.ver-entradas', function () {
        const articuloId = $(this).data('id');
        const fecha = $('#monthPicker').val();
        const [month, year] = fecha.split('/');
        const fechaInicio = `${year}-${month}-01`;
        const fechaFin = `${year}-${String(parseInt(month)).padStart(2, '0')}-${new Date(year, month, 0).getDate()}`;
        const categoria = $('#selectCategoria').val();

        if (!articuloId) {
            Swal.fire('Error', 'No se pudo identificar el artículo.', 'error');
            return;
        }

        $('#contenidoEntradas').html('<p class="text-center">Cargando datos...</p>');

        $.ajax({
            url: '../AJAX/ctrKardex.php',
            type: 'POST',
            data: {
                action: 'cargarDetalleKardex',
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
                categoria: categoria,
                articulo: articuloId
            },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    tablaEntradas.clear().rows.add(response.data).draw();
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

    // Cargar categorías al iniciar
    cargarCategorias();
});