// === PDsubt.js ===
// Función genérica para recalcular subtotales
function recalcularSubtotal(tablaID, selectorSubtotal, precioColumna) {
    let total = 0;
    $(`#${tablaID} tbody tr`).each(function () {
        const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
        const precio = parseFloat($(this).find(`td:eq(${precioColumna})`).text()) || 0;
        total += cantidad * precio;
    });
    $(selectorSubtotal).val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}
