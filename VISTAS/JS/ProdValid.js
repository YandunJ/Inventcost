// Función para mantener la posición del cursor
function mantenerPosicionCursor(input, nuevoValor) {
    const start = input.selectionStart;
    const end = input.selectionEnd;
    input.value = nuevoValor;
    input.setSelectionRange(start, end);
}

// Función para validar la cantidad a consumir (Materia Prima)
function validarCantidadMateriaPrima(input) {
    let valor = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al stock
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Mostrar siempre con dos decimales
    mantenerPosicionCursor(input[0], valor.toFixed(2));
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
    const incremento = $(this).hasClass('incrementar') ? 0.01 : -0.01;

    let nuevoValor = valorActual + incremento;
    if (nuevoValor < 0) nuevoValor = 0;
    if (nuevoValor > max) nuevoValor = max;

    mantenerPosicionCursor(input[0], nuevoValor.toFixed(2));
    input.trigger('input');
});

// Función para validar la cantidad a consumir (Insumos)
function validarCantidadInsumos(input) {
    let valor = parseFloat(input.val()) || 0;
    const max = parseFloat(input.attr('max')) || Infinity;

    // No permitir valores negativos ni mayores al stock
    if (valor < 0) valor = 0;
    if (valor > max) valor = max;

    // Obtener la unidad de medida de la fila actual
    const unidadMedida = input.closest('tr').find('td:eq(4)').text().toLowerCase();

    // Si la unidad de medida es "unidades", redondear a entero
    if (unidadMedida === 'unidades') {
        valor = Math.floor(valor);
    }

    // Mostrar siempre con dos decimales (excepto para "unidades")
    mantenerPosicionCursor(input[0], unidadMedida === 'unidades' ? valor : valor.toFixed(2));
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
    const unidadMedida = input.closest('tr').find('td:eq(4)').text().toLowerCase();

    // Definir el incremento según la unidad de medida
    const incremento = $(this).hasClass('incrementar') ? (unidadMedida === 'unidades' ? 1 : 0.01) : (unidadMedida === 'unidades' ? -1 : -0.01);

    let nuevoValor = valorActual + incremento;
    if (nuevoValor < 0) nuevoValor = 0;
    if (nuevoValor > max) nuevoValor = max;

    // Mostrar el valor ajustado según la unidad de medida
    mantenerPosicionCursor(input[0], unidadMedida === 'unidades' ? nuevoValor : nuevoValor.toFixed(2));
    input.trigger('input');
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
// Evento para validar la cantidad ingresada manualmente (Mano de Obra)
$('#tablaManoObra').on('input', '.cantidad-personas', function () {
    validarCantidadPersonas($(this));
});



// Función para validar el precio por hora (decimales)
function validarPrecioHora(input) {
    let valor = parseFloat(input.val().replace(',', '.')) || 0; // Permitir comas y puntos como separador decimal

    // No permitir valores negativos
    if (valor < 0) valor = 0;

    // Mostrar siempre con dos decimales
    mantenerPosicionCursor(input[0], valor.toFixed(2));
}

// Evento para validar la cantidad ingresada manualmente (Precio por hora)
$('#tablaManoObra').on('input', '.precio-ht', function () {
    validarPrecioHora($(this));
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
    let valor = parseFloat(input.val().replace(',', '.')) || 0; // Permitir comas y puntos como separador decimal

    // No permitir valores negativos
    if (valor < 0) valor = 0;

    // Mostrar siempre con dos decimales
    mantenerPosicionCursor(input[0], valor.toFixed(2));
}

function validarPrecioUnitarioCostos(input) {
    let valor = parseFloat(input.val().replace(',', '.')) || 0; // Permitir comas y puntos como separador decimal

    // No permitir valores negativos
    if (valor < 0) valor = 0;

    // Mostrar siempre con dos decimales
    mantenerPosicionCursor(input[0], valor.toFixed(2));
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

