// ============================
// CALCULOS DE SUBTOTALES PESTAÑAS
// ===========================
function recalcularSubtotal(selectorTabla, campoSubtotal, cantidadColumna, precioColumna) {
    let total = 0;
    $(`${selectorTabla} tbody tr`).each(function () {
        const cantidad = parseFloat($(this).find(`td:eq(${cantidadColumna}) .cantidad-consumir`).val()) || 0;
        const precio = parseFloat($(this).find(`td:eq(${precioColumna})`).text()) || 0;
        total += cantidad * precio;
    });
    $(campoSubtotal).val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}

// Recalcular subtotal de Materia Prima
function recalcularSubtotalMateriaPrima() {
    recalcularSubtotal('#LotesMP', '#subtotalMP', 8, 7); // Cantidad Consumo en columna 8, Precio en columna 7
}

// Recalcular subtotal de Insumos
function recalcularSubtotalInsumos() {
    recalcularSubtotal('#LotesINS', '#subtotalINS', 7, 6); // Cantidad Consumo en columna 7, Precio en columna 6
}

// Eventos de cambio en insumos, MP, mano de obra y costos indirectos
$('#LotesMP').on('input', '.cantidad-consumir', recalcularSubtotalMateriaPrima);
$('#LotesINS').on('input', '.cantidad-consumir', recalcularSubtotalInsumos);

//CALCULOS DE COSTOS INDIRECTOS -----
$('#tablaCostosIndirectos').on('input', '.cantidad-unidades, .precio-unitario', function () {
    const row = $(this).closest('tr');
    const cantidadUnidades = parseFloat(row.find('.cantidad-unidades').val()) || 0;
    const precioUnitario = parseFloat(row.find('.precio-unitario').val()) || 0;
    row.find('.costo-total').text(`$${(cantidadUnidades * precioUnitario).toFixed(2)}`);
    recalcularTotalCostosIndirectos();
});

// Recalcular Total de Costos Indirectos
function recalcularTotalCostosIndirectos() {
    let total = 0;
    $('#tablaCostosIndirectos tbody tr').each(function () {
        const costoTotal = parseFloat($(this).find('.costo-total').text().replace('$', '')) || 0;
        total += costoTotal;
    });
    $('#totalCostosIndirectos').text(`$${total.toFixed(2)}`);
    $('#subtotalCA').val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}

// CALCULOS DE MANO DE OBRA ------
$('#tablaManoObra').on('input', '.cantidad-personas, .horas-por-dia, .precio-ht', function () {
    const row = $(this).closest('tr');
    const cantidadPersonas = parseFloat(row.find('.cantidad-personas').val()) || 0;
    const precioHT = parseFloat(row.find('.precio-ht').val()) || 0;
    const horasPorDia = parseFloat(row.find('.horas-por-dia').val()) || 0;
    const horasTrabajador = cantidadPersonas * horasPorDia;
    const costoDia = horasTrabajador * precioHT;
    row.find('.horas-trabajador').text(horasTrabajador);
    row.find('.costo-dia').text(`$${costoDia.toFixed(2)}`);
    recalcularTotalManoObra();
});

// Recalcular Total de Mano de Obra
function recalcularTotalManoObra() {
    let total = 0;
    $('#tablaManoObra tbody tr').each(function () {
        const costoTotal = parseFloat($(this).find('.costo-dia').text().replace('$', '')) || 0;
        total += costoTotal;
    });
    $('#totalManoObra').text(`$${total.toFixed(2)}`);
    $('#subtotalMO').val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}

// COSTO TOTAL DE PRODUCCION -----
function recalcularCostoTotalProduccion() {
    const subtotales = [
        parseFloat($('#subtotalMP').val()) || 0,
        parseFloat($('#subtotalINS').val()) || 0,
        parseFloat($('#subtotalMO').val()) || 0,
        parseFloat($('#subtotalCA').val()) || 0,
    ];

    const totalProduccion = subtotales.reduce((acc, subtotal) => acc + subtotal, 0);
    $('#totalProduccion').val(totalProduccion.toFixed(2));
}