
// === PDeventos.js ===
$(document).on('click', '.incrementar', function () {
    ajustarCantidad(this, true);
});

$(document).on('click', '.decrementar', function () {
    ajustarCantidad(this, false);
}); 
