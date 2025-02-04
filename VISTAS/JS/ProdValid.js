// DTesp específicas para Materia Prima
function validarCantidadMateriaPrima(input) {
    let valor = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al stock
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Ajustar a múltiplos de 0.5
    valor = Math.round(valor * 2) / 2;

    // Mostrar siempre con dos decimales
    input.val(valor.toFixed(2));
}

// Evento para validar la cantidad ingresada manualmente (Materia Prima)
$('#LotesMP').on('input', '.cantidad-consumir', function () {
    validarCantidadMateriaPrima($(this));
});

// Evento para manejar los botones de incremento y decremento (Materia Prima)
$('#LotesMP').on('click', '.incrementar, .decrementar', function () {
    const input = $(this).closest('.input-group').find('input');
    let valorActual = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;
    const incremento = $(this).hasClass('incrementar') ? 0.5 : -0.5;

    let nuevoValor = valorActual + incremento;
    if (nuevoValor < 0) nuevoValor = 0;
    if (nuevoValor > max) nuevoValor = max;

    input.val(nuevoValor.toFixed(2)).trigger('input');
});

// DTesp específicas para Insumos
function validarCantidadInsumos(input) {
    let valor = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al stock
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Ajustar a múltiplos de 0.5
    valor = Math.round(valor * 2) / 2;

    // Mostrar siempre con dos decimales
    input.val(valor.toFixed(2));
}

// Evento para validar la cantidad ingresada manualmente (Insumos)
$('#LotesINS').on('input', '.cantidad-consumir', function () {
    validarCantidadInsumos($(this));
});

// Evento para manejar los botones de incremento y decremento (Insumos)
$('#LotesINS').on('click', '.incrementar, .decrementar', function () {
    const input = $(this).closest('.input-group').find('input');
    let valorActual = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;
    const incremento = $(this).hasClass('incrementar') ? 0.5 : -0.5;

    let nuevoValor = valorActual + incremento;
    if (nuevoValor < 0) nuevoValor = 0;
    if (nuevoValor > max) nuevoValor = max;

    input.val(nuevoValor.toFixed(2)).trigger('input');
});


// DTesp específicas para Mano de Obra
function validarCantidadPersonas(input) {
    let valor = parseInt(input.val()) || 0;
    const max = parseInt(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al máximo permitido
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Mostrar siempre como entero
    input.val(valor);
}

function validarCantidadHorasCosto(input) {
    let valor = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al máximo permitido
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Ajustar a múltiplos de 0.5
    valor = Math.round(valor * 2) / 2;

    // Mostrar siempre con dos decimales
    input.val(valor.toFixed(2));
}

// Evento para validar la cantidad ingresada manualmente (Mano de Obra)
$('#tablaManoObra').on('input', '.cantidad-personas', function () {
    validarCantidadPersonas($(this));
});

$('#tablaManoObra').on('input', '.horas-por-dia, .precio-ht', function () {
    validarCantidadHorasCosto($(this));
});

// Evento para manejar los botones de incremento y decremento (Mano de Obra)
$('#tablaManoObra').on('click', '.incrementar, .decrementar', function () {
    const input = $(this).closest('.input-group').find('input');
    let valorActual = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;
    const incremento = $(this).hasClass('incrementar') ? (input.hasClass('cantidad-personas') ? 1 : 0.5) : (input.hasClass('cantidad-personas') ? -1 : -0.5);

    let nuevoValor = valorActual + incremento;
    if (nuevoValor < 0) nuevoValor = 0;
    if (nuevoValor > max) nuevoValor = max;

    input.val(nuevoValor.toFixed(input.hasClass('cantidad-personas') ? 0 : 2)).trigger('input');
});


// DTesp específicas para Costos Indirectos
function validarCantidadCostos(input) {
    let valor = parseInt(input.val()) || 0;
    const max = parseInt(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al máximo permitido
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Mostrar siempre como entero
    input.val(valor);
}

function validarPrecioUnitarioCostos(input) {
    let valor = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al máximo permitido
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Ajustar a múltiplos de 0.5
    valor = Math.round(valor * 2) / 2;

    // Mostrar siempre con dos decimales
    input.val(valor.toFixed(2));
}

// Evento para validar la cantidad ingresada manualmente (Costos Indirectos)
$('#tablaCostosIndirectos').on('input', '.cantidad-unidades', function () {
    validarCantidadCostos($(this));
});

$('#tablaCostosIndirectos').on('input', '.precio-unitario', function () {
    validarPrecioUnitarioCostos($(this));
});

// Evento para manejar los botones de incremento y decremento (Costos Indirectos)
$('#tablaCostosIndirectos').on('click', '.incrementar, .decrementar', function () {
    const input = $(this).closest('.input-group').find('input');
    let valorActual = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;
    const incremento = $(this).hasClass('incrementar') ? (input.hasClass('cantidad-unidades') ? 1 : 0.5) : (input.hasClass('cantidad-unidades') ? -1 : -0.5);

    let nuevoValor = valorActual + incremento;
    if (nuevoValor < 0) nuevoValor = 0;
    if (nuevoValor > max) nuevoValor = max;

    input.val(nuevoValor.toFixed(input.hasClass('cantidad-unidades') ? 0 : 2)).trigger('input');
});

