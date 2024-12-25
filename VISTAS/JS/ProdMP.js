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
        ]
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
        ]
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


    function calcularManoObra() {
        let totalManoObra = 0;

        $('#tablaManoObra tbody tr').each(function () {
            const cantidadPersonas = parseInt($(this).find('.cantidad-personas').val()) || 0;
            const precioHT = parseFloat($(this).find('.precio-ht').val()) || 0;
            const horasPorDia = parseInt($(this).find('.horas-por-dia').val()) || 0;

            // Cálculos
            const totalHorasTrabajador = cantidadPersonas * horasPorDia;
            const costoDia = totalHorasTrabajador * precioHT;
            const costoTotal = costoDia; // Por ahora se iguala al costo día

            // Mostrar valores calculados
            $(this).find('.horas-trabajador').text(totalHorasTrabajador);
            $(this).find('.costo-dia').text(`$${costoDia.toFixed(2)}`);
            $(this).find('.costo-total').text(`$${costoTotal.toFixed(2)}`);

            // Acumular total general
            totalManoObra += costoTotal;
        });

        // Mostrar total en el footer
        $('#totalManoObra').text(`$${totalManoObra.toFixed(2)}`);
    }

    // Eventos para recalcular cuando los valores cambien
    $('#tablaManoObra').on('input', '.cantidad-personas, .horas-por-dia', calcularManoObra);

    // Inicializar cálculo al cargar
    calcularManoObra();









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
