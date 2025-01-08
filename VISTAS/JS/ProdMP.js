$(document).ready(function () {
    // Inicializa DataTables solo una vez
    const LotesMP = $('#LotesMP').DataTable({
        autoWidth: false,
        responsive: true,
        paging: true,
        searching: true,
        ajax: {
            url: '../AJAX/ctrInvFrutas.php',
            type: 'POST',
            data: { action: 'cargarMateriaPrima' },
            dataSrc: function (json) {
                return json.status === 'success' ? json.data : [];
            }
        },
        columns: [
            { data: 'Lote' },
            { data: 'Proveedor' },
            { data: 'Articulo' },
            { data: 'UnidadMedida' },
            { data: 'CantidadDisponible' },
            { data: 'PrecioUnitario' },
            // {
            //     data: 'ID',
            //     render: function (data) {
            //         return `<button class="btn btn-info btn-sm details-btn" data-id="${data}">
            //                     <i class="fas fa-info-circle"></i> Detalles
            //                 </button>`;
            //     }
            // },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                    <div class="input-group cantidad-group">
                        <div class="input-group-prepend">
                            <button type="button" class="btn btn-outline-secondary btn-sm decrementar" disabled>-</button>
                        </div>
                        <input type="number" class="form-control cantidad-consumir text-center" 
                               value="0" min="0" max="${row.Cantidad_Disponible}" step="1" disabled>
                        <div class="input-group-append">
                            <button type="button" class="btn btn-outline-secondary btn-sm incrementar" disabled>+</button>
                        </div>
                    </div>`;
                }
            }
            ,
            {
                data: 'ID',
                render: function (data) {
                    return `<input type="checkbox" class="form-check-input select-mp" value="${data}">`;
                }
            }
        ],
        "language": dataTableLanguage
    });

    const LotesINS = $('#LotesINS').DataTable({
        autoWidth: false,
        responsive: true,
        paging: true,
        searching: true,
        ajax: {
            url: '../AJAX/ctrInvInsumos.php',
            type: 'POST',
            data: { action: 'cargarInsumosTabla' },
            dataSrc: function (json) {
                return json.status === 'success' ? json.data : [];
            }
        },
        columns: [
            { data: 'Lote' },
            { data: 'Proveedor' },
            { data: 'Insumo' },
            { data: 'Unidad_Medida' },
            { data: 'Cantidad_Restante' },
            { data: 'Precio_Unitario' },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                    <div class="input-group cantidad-group">
                        <div class="input-group-prepend">
                            <button type="button" class="btn btn-outline-secondary btn-sm decrementar" disabled>-</button>
                        </div>
                        <input type="number" class="form-control cantidad-consumir text-center" 
                               value="0" min="0" max="${row.Cantidad_Disponible}" step="1" disabled>
                        <div class="input-group-append">
                            <button type="button" class="btn btn-outline-secondary btn-sm incrementar" disabled>+</button>
                        </div>
                    </div>`;
                }
            }
            ,
            {
                data: null,
                render: function () {
                    return `<input type="checkbox" class="form-check-input seleccionar-checkbox">`;
                }
            }
        ],
        "language": dataTableLanguage
    });
    // Ajustar columnas al cambiar de pestaña
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        const target = $(e.target).attr("href");
        if (target === "#materiaPrima") {
            LotesMP.columns.adjust();
        } else if (target === "#insumos") {
            LotesINS.columns.adjust();
        }
    });

   // Evento para habilitar/deshabilitar campo y botones (Materia Prima)
$('#LotesMP tbody').on('change', '.select-mp', function () {
    const row = $(this).closest('tr');
    const cantidadInput = row.find('.cantidad-consumir');
    const incrementarBtn = row.find('.incrementar');
    const decrementarBtn = row.find('.decrementar');

    // Activa o desactiva los elementos según el checkbox
    const isChecked = this.checked;
    cantidadInput.prop('disabled', !isChecked);
    incrementarBtn.prop('disabled', !isChecked);
    decrementarBtn.prop('disabled', !isChecked);

    // Reinicia el valor si el checkbox se desmarca
    if (!isChecked) cantidadInput.val('0');
});

// Evento para habilitar/deshabilitar campo y botones (Insumos)
$('#LotesINS tbody').on('change', '.seleccionar-checkbox', function () {
    const row = $(this).closest('tr');
    const cantidadInput = row.find('.cantidad-consumir');
    const incrementarBtn = row.find('.incrementar');
    const decrementarBtn = row.find('.decrementar');

    const isChecked = this.checked;
    cantidadInput.prop('disabled', !isChecked);
    incrementarBtn.prop('disabled', !isChecked);
    decrementarBtn.prop('disabled', !isChecked);

    if (!isChecked) cantidadInput.val('0');
});

// Incrementar valor
$(document).on('click', '.incrementar', function () {
    const cantidadInput = $(this).closest('.cantidad-group').find('.cantidad-consumir');
    let valorActual = parseInt(cantidadInput.val()) || 0;
    const max = parseInt(cantidadInput.attr('max')) || 0;

    if (valorActual < max) {
        cantidadInput.val(valorActual + 1);
    }
});

// Decrementar valor
$(document).on('click', '.decrementar', function () {
    const cantidadInput = $(this).closest('.cantidad-group').find('.cantidad-consumir');
    let valorActual = parseInt(cantidadInput.val()) || 0;

    if (valorActual > 0) {
        cantidadInput.val(valorActual - 1);
    }
});


    // Registrar Producción
    $('#registrarProduccion').click(function() {
        alert("Producción registrada correctamente.");
    });

  
    // Inicializar el DataTable para Mano de Obra
    var table = $('#tablaManoObra').DataTable({
        "ajax": {
            "url": "../AJAX/ctrCost.php",
            "type": "POST",
            "data": { action: "obtenerCostos", opcion: 1 }, // Usar la opción 1
            "dataSrc": function (json) {
                // Filtrar los datos para mostrar solo los de la categoría "Mano de Obra" y estado "habilitado"
                return json.data.filter(function (item) {
                    return item.categoria === 'Mano de Obra' && item.cat_estado === 'habilitado';
                });
            }
        },
        "columns": [
            { "data": "cat_nombre" },
            {
                "data": null,
                "render": function () {
                    return `
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
                            </div>
                            <input type="number" class="form-control cantidad-personas" min="0" value="0">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
                            </div>
                        </div>`;
                }
            },
            {
                "data": null,
                "render": function () {
                    return `
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
                            </div>
                            <input type="number" class="form-control precio-ht" min="0" step="0.01" value="0">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
                            </div>
                        </div>`;
                }
            },
            {
                "data": null,
                "render": function () {
                    return `
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
                            </div>
                            <input type="number" class="form-control horas-por-dia" min="0" value="0">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
                            </div>
                        </div>`;
                }
            },
            { "data": null, className: 'horas-trabajador', defaultContent: '0' },
            { "data": null, className: 'costo-dia', defaultContent: '$0.00' },
            { "data": null, className: 'costo-total', defaultContent: '$0.00' }
        ],
        "language": dataTableLanguage
    });

      // Inicializar el DataTable para Costos Indirectos
    var tablaCostosIndirectos = $('#tablaCostosIndirectos').DataTable({
        "ajax": {
            "url": "../AJAX/ctrCost.php",
            "type": "POST",
            "data": { action: "obtenerCostos", opcion: 1 }, // Usar la opción 1
            "dataSrc": function (json) {
                // Filtrar los datos para mostrar solo los de la categoría "Costos Indirectos" y estado "habilitado"
                return json.data.filter(function (item) {
                    return item.categoria === 'Costos Indirectos' && item.cat_estado === 'habilitado';
                });
            }
        },
        "columns": [
            { "data": "cat_nombre" },
            {
                "data": null,
                "render": function () {
                    return `
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
                            </div>
                            <input type="number" class="form-control cantidad-unidades" min="0" value="0">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
                            </div>
                        </div>`;
                }
            },
            {
                "data": null,
                "render": function () {
                    return `
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
                            </div>
                            <input type="number" class="form-control precio-unitario" min="0" step="0.01" value="0">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
                            </div>
                        </div>`;
                }
            },
            { "data": null, className: 'costo-total', defaultContent: '$0.00' }
        ],
        "language": dataTableLanguage
    });

    // Evento para recalcular totales al cambiar cantidades en Costos Indirectos
    $('#tablaCostosIndirectos').on('input', '.cantidad-unidades, .precio-unitario', function () {
        const row = $(this).closest('tr');
        const cantidadUnidades = parseFloat(row.find('.cantidad-unidades').val()) || 0;
        const precioUnitario = parseFloat(row.find('.precio-unitario').val()) || 0;

        const costoTotal = cantidadUnidades * precioUnitario;

        row.find('.costo-total').text(`$${costoTotal.toFixed(2)}`);

        recalcularTotalCostosIndirectos();
    });

    // Función para recalcular el total de Costos Indirectos
    function recalcularTotalCostosIndirectos() {
        let total = 0;
        $('#tablaCostosIndirectos .costo-total').each(function () {
            const costo = parseFloat($(this).text().replace('$', '')) || 0;
            total += costo;
        });
        $('#totalCostosIndirectos').text(`$${total.toFixed(2)}`);
    }


    // Evento para recalcular totales al cambiar cantidades
    $('#tablaManoObra').on('input', '.cantidad-personas, .horas-por-dia, .precio-ht', function () {
        const row = $(this).closest('tr');
        const cantidadPersonas = parseFloat(row.find('.cantidad-personas').val()) || 0;
        const precioHT = parseFloat(row.find('.precio-ht').val()) || 0;
        const horasPorDia = parseFloat(row.find('.horas-por-dia').val()) || 0;

        const horasTrabajador = cantidadPersonas * horasPorDia;
        const costoDia = horasTrabajador * precioHT;
        const costoTotal = costoDia; // Aquí podrías agregar lógica para multiplicar por días de producción.

        row.find('.horas-trabajador').text(horasTrabajador);
        row.find('.costo-dia').text(`$${costoDia.toFixed(2)}`);
        row.find('.costo-total').text(`$${costoTotal.toFixed(2)}`);

        recalcularTotalManoObra();
    });

    // Función para recalcular el total de Mano de Obra
    function recalcularTotalManoObra() {
        let total = 0;
        $('#tablaManoObra .costo-total').each(function () {
            const costo = parseFloat($(this).text().replace('$', '')) || 0;
            total += costo;
        });
        $('#totalManoObra').text(`$${total.toFixed(2)}`);
    }




       // Manejar el clic en el botón "Detalles"
       $('#LotesMP').on('click', '.details-btn', function() {
        const loteID = $(this).data('id');
        cargarDetallesLote(loteID);
    });

    // Función para cargar detalles del lote (reutilizada)
    function cargarDetallesLote(loteID) {
        $.ajax({
            url: '../AJAX/ctrInvFrutas.php',
            type: 'POST',
            data: { action: 'obtenerDetalleLote', lote_id: loteID },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    // Llenar el modal con los datos recibidos
                    $('#detalleFecha').text(response.data.Fecha);
                    $('#detalleHora').text(response.data.Hora);
                    $('#detalleLote').text(response.data.Numero_Lote);
                    $('#detalleProveedor').text(response.data.Proveedor);
                    $('#detalleArticulo').text(response.data.Artículo);
                    $('#detalleCantidadIngresada').text(response.data.Cantidad_Ingresada);
                    $('#detalleCantidadRestante').text(response.data.Cantidad_Restante);
                    $('#detalleUnidadMedida').text(response.data.Unidad_Medida);
                    $('#detallePresentacion').text(response.data.Presentación);
                    $('#detallePrecioUnitario').text(response.data.Precio_Unitario);
                    $('#detallePrecioTotal').text(response.data.Precio_Total);
                    $('#detalleEstado').text(response.data.Estado);
                    $('#detalleBrix').text(response.data.Brix);
                    $('#detallePesoUnitario').text(response.data.Peso_Unitario);
                    $('#detalleBultos').text(response.data.Bultos_Canastas);
                    $('#detalleObservacion').text(response.data.Observación);
                    $('#detalleAprobacion').text(response.data.Aprobación);

                    // Mostrar el modal
                    $('#detalleModal').modal('show');
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function() {
                alert('Error en la solicitud AJAX.');
            }
        });
    }
});
