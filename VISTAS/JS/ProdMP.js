$(document).ready(function () {
// ============================
// Inicialización de DataTables
// ===========================
function inicializarDataTable(selector, ajaxUrl, data, columnas, filtro = null) {
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
                    // Aplica el filtro si existe
                    if (filtro) {
                        return json.data.filter(filtro);
                    }
                    return json.data;
                }
                return [];
            }
        },
        columns: columnas,
        language: dataTableLanguage
    });
}

   // Función para obtener los lotes de materia prima seleccionados
   function getLotesMP() {
    let lotes = [];
    $('#LotesMP tbody tr').each(function () {
        if ($(this).find('.select-mp').is(':checked')) {
            const id_inv = $(this).find('.select-mp').val();
            const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
            lotes.push({ id_inv: id_inv, cantidad: cantidad });
        }
    });
    return lotes;
}

// Función para obtener los lotes de insumos seleccionados
function getLotesINS() {
    let lotes = [];
    $('#LotesINS tbody tr').each(function () {
        if ($(this).find('.seleccionar-checkbox').is(':checked')) {
            const id_inv = $(this).find('.seleccionar-checkbox').val();
            const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
            lotes.push({ id_inv: id_inv, cantidad: cantidad });
        }
    });
    return lotes;
}
function recalcularSubtotal(selectorTabla, campoSubtotal, precioColumna) {
    let total = 0;
    $(`${selectorTabla} tbody tr`).each(function () {
        const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
        const precio = parseFloat($(this).find(`td:eq(${precioColumna})`).text()) || 0;
        total += cantidad * precio;
    });
    $(campoSubtotal).val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}
  // Función para registrar la producción
  $('#btnRegistrarProduccionModal').on('click', function () {
    const cant_producida = $('#cant_producida').val() || 0;
    const lotes_mp = JSON.stringify(getLotesMP());
    const lotes_ins = JSON.stringify(getLotesINS());

    $.ajax({
        url: '../AJAX/ctrProduccionMP.php',
        type: 'POST',
        data: {
            action: 'registrarProduccion',
            cant_producida: cant_producida,
            lotes_mp: lotes_mp,
            lotes_ins: lotes_ins
        },
        success: function (response) {
            try {
                const result = JSON.parse(response);
                if (result.status === 'success') {
                    alert('Producción registrada correctamente');
                    location.reload();
                } else {
                    alert('Error: ' + result.message);
                }
            } catch (e) {
                alert('Error en la respuesta del servidor: ' + response);
            }
        },
        error: function (xhr, status, error) {
            alert('Error en la solicitud AJAX: ' + error);
        }
    });
});


//   $('#btnRegistrarProduccionModal').on('click', function () {
//     const lote = $('#lote').val();
//     const cant_producida = $('#cant_producida').val();
//     const estado = $('#estado').val() || 'en proceso'; // Valor predeterminado
//     const subtotal_mtpm = $('#subtotalMP').val();
//     const subtotal_ins = $('#subtotalINS').val();
//     const subtotal_mo = $('#subtotalMO').val();
//     const subtotal_ci = $('#subtotalCA').val();
//     const total = $('#totalProduccion').val();
//     const detalle = JSON.stringify(getDetalle());
//     const mano_obra = JSON.stringify(getManoObra());
//     const costos_indirectos = JSON.stringify(getCostosIndirectos());

//     $.ajax({
//         url: '../AJAX/ctrProduccionMP.php',
//         type: 'POST',
//         data: {
//             action: 'registrarProduccion',
//             lote: lote,
//             cant_producida: cant_producida,
//             estado: estado,
//             subtotal_mtpm: subtotal_mtpm,
//             subtotal_ins: subtotal_ins,
//             subtotal_mo: subtotal_mo,
//             subtotal_ci: subtotal_ci,
//             total: total,
//             detalle: detalle,
//             mano_obra: mano_obra,
//             costos_indirectos: costos_indirectos
//         },
//         success: function (response) {
//             try {
//                 const result = JSON.parse(response);
//                 if (result.status === 'success') {
//                     alert('Producción registrada correctamente');
//                     location.reload();
//                 } else {
//                     alert('Error: ' + result.message);
//                 }
//             } catch (e) {
//                 alert('Error en la respuesta del servidor: ' + response);
//             }
//         },
//         error: function (xhr, status, error) {
//             alert('Error en la solicitud AJAX: ' + error);
//         }
//     });
// });

function getDetalle() {
    let detalles = [];
    $('#LotesMP tbody tr').each(function () {
        if ($(this).find('.select-mp').is(':checked')) {
            const inv_id = $(this).find('.select-mp').val();
            const inv_lote = $(this).find('td:eq(0)').text(); // Asumiendo que el lote está en la primera columna
            const pdet_cantidad_usada = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
            detalles.push({
                inv_id: inv_id,
                inv_lote: inv_lote,
                pdet_cantidad_usada: pdet_cantidad_usada,
                pdet_cantidad_producida: 0, // Ajusta según sea necesario
                pdet_cantidad_desperdiciada: 0 // Ajusta según sea necesario
            });
        }
    });
    return detalles;
}

function getManoObra() {
    let manoObra = [];
    $('#tablaManoObra tbody tr').each(function () {
        const cat_id = $(this).find('td:eq(0)').data('cat-id'); // Asegúrate de que el ID de la categoría esté en la primera columna
        const mo_cant_personas = parseFloat($(this).find('.cantidad-personas').val()) || 0;
        const mo_precio_hora = parseFloat($(this).find('.precio-ht').val()) || 0;
        const mo_horas_trabajadas = parseFloat($(this).find('.horas-por-dia').val()) || 0;
        const mo_horas_totales = mo_cant_personas * mo_horas_trabajadas;
        const mo_costo_dia = mo_horas_totales * mo_precio_hora;
        const mo_costo_total = mo_costo_dia; // Ajusta según sea necesario
        manoObra.push({
            cat_id: cat_id,
            mo_cant_personas: mo_cant_personas,
            mo_precio_hora: mo_precio_hora,
            mo_horas_trabajadas: mo_horas_trabajadas,
            mo_horas_totales: mo_horas_totales,
            mo_costo_dia: mo_costo_dia,
            mo_costo_total: mo_costo_total
        });
    });
    return manoObra;
}

function getCostosIndirectos() {
    let costosIndirectos = [];
    $('#tablaCostosIndirectos tbody tr').each(function () {
        const cat_id = $(this).find('td:eq(0)').data('cat-id'); // Asegúrate de que el ID de la categoría esté en la primera columna
        const cost_cant = parseFloat($(this).find('.cantidad-unidades').val()) || 0;
        const cost_unit = parseFloat($(this).find('.precio-unitario').val()) || 0;
        const cost_total = cost_cant * cost_unit;
        costosIndirectos.push({
            cat_id: cat_id,
            cost_cant: cost_cant,
            cost_unit: cost_unit,
            cost_total: cost_total
        });
    });
    return costosIndirectos;
}

    // MP
const columnasMP = [
        { data: 'Lote' },
        { data: 'Proveedor' },
        { data: 'Articulo' },
        { data: 'UnidadMedida' },
        { data: 'CantidadDisponible' },
        { data: 'PrecioUnitario' },
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
        },
        {
            data: 'ID',
            render: function (data) {
                return `<input type="checkbox" class="form-check-input select-mp" value="${data}">`;
            }
        }
];
    

// INSUMOS
const columnasINS = [
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
                       value="0" min="0" max="${row.Cantidad_Restante}" step="1" disabled>
                <div class="input-group-append">
                    <button type="button" class="btn btn-outline-secondary btn-sm incrementar" disabled>+</button>
                </div>
            </div>`;
        }
    },
    {
        data: null,
        render: function (data, type, row) {
            return `<input type="checkbox" class="form-check-input seleccionar-checkbox" value="${row.ID}">`;
        }
    }
    
];

const LotesMP = inicializarDataTable(
    '#LotesMP',
    '../AJAX/ctrInvFrutas.php',
    { action: 'cargarMateriaPrima' },
    columnasMP,
    function (row) {
        return row.CantidadDisponible > 0; // Filtro: solo mostrar registros con cantidad disponible
    }
);

const LotesINS = inicializarDataTable(
    '#LotesINS',
    '../AJAX/ctrInvInsumos.php',
    { action: 'cargarInsumosTabla' },
    columnasINS,
    function (row) {
        return row.Cantidad_Restante > 0; // Filtro: solo mostrar registros con cantidad restante
    }
);


$('#LotesMP').on('input', '.cantidad-consumir', function () {
    recalcularSubtotal('#LotesMP', '#subtotalMP', 5);
});

$('#LotesINS').on('input', '.cantidad-consumir', function () {
    recalcularSubtotal('#LotesINS', '#subtotalINS', 5);
});

// Evento para recalcular el subtotal de materia prima al cambiar cantidades
$('#LotesMP').on('input', '.cantidad-consumir', recalcularSubtotalMateriaPrima);
$('#LotesINS').on('input', '.cantidad-consumir', recalcularSubtotalInsumos);

// TABLA MANO DE OBRA
const table = $('#tablaManoObra').DataTable({
    "ajax": {
        "url": "../AJAX/ctrCost.php",
        "type": "POST",
        "data": { action: "obtenerCostos", opcion: 1 },
        "dataSrc": function (json) {
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

// Funcion TOTAL MANO SE OBRA 
function recalcularTotalManoObra() {
    let total = 0;
    $('#tablaManoObra tbody tr').each(function () {
        const costoTotal = parseFloat($(this).find('.costo-total').text().replace('$', '')) || 0;
        total += costoTotal;
    });
    $('#totalManoObra').text(`$${total.toFixed(2)}`);
    $('#subtotalMO').val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}

$('#tablaManoObra').on('input', '.cantidad-personas, .horas-por-dia, .precio-ht', function () {
    const row = $(this).closest('tr');
    const cantidadPersonas = parseFloat(row.find('.cantidad-personas').val()) || 0;
    const precioHT = parseFloat(row.find('.precio-ht').val()) || 0;
    const horasPorDia = parseFloat(row.find('.horas-por-dia').val()) || 0;

    const horasTrabajador = cantidadPersonas * horasPorDia;
    const costoDia = horasTrabajador * precioHT;
    const costoTotal = costoDia;

    row.find('.horas-trabajador').text(horasTrabajador);
    row.find('.costo-dia').text(`$${costoDia.toFixed(2)}`);
    row.find('.costo-total').text(`$${costoTotal.toFixed(2)}`);

    recalcularTotalManoObra();
});

      // Inicializar el DataTable  Costos Indirectos
      const tablaCostosIndirectos = $('#tablaCostosIndirectos').DataTable({
        "ajax": {
            "url": "../AJAX/ctrCost.php",
            "type": "POST",
            "data": { action: "obtenerCostos", opcion: 1 },
            "dataSrc": function (json) {
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
    
    
 // Función Calculo TOTAL COSTOS INDIRECTOS 
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

$('#tablaCostosIndirectos').on('input', '.cantidad-unidades, .precio-unitario', function () {
    const row = $(this).closest('tr');
    const cantidadUnidades = parseFloat(row.find('.cantidad-unidades').val()) || 0;
    const precioUnitario = parseFloat(row.find('.precio-unitario').val()) || 0;

    const costoTotal = cantidadUnidades * precioUnitario;

    row.find('.costo-total').text(`$${costoTotal.toFixed(2)}`);

    recalcularTotalCostosIndirectos();
});

//COSTO TOTAL PRODUCCION
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

// Recalcular subtotales
// $('#LotesMP, #LotesINS, #tablaManoObra, #tablaCostosIndirectos').on('input', '.cantidad-consumir, .cantidad-personas, .cantidad-unidades', function () {
//     const tablaID = $(this).closest('table').attr('id');

//     if (tablaID === 'LotesMP') recalcularSubtotal('#LotesMP', '#subtotalMP');
//     if (tablaID === 'LotesINS') recalcularSubtotal('#LotesINS', '#subtotalINS');
//     if (tablaID === 'tablaManoObra') recalcularSubtotal('#tablaManoObra', '#subtotalMO');
//     if (tablaID === 'tablaCostosIndirectos') recalcularSubtotal('#tablaCostosIndirectos', '#subtotalCA');
// });

// ============================
// Eventos de Interacción
// ============================
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

// Función para incrementar o decrementar valores
function ajustarCantidad(button, incrementar = true) {
    const input = $(button).closest('.input-group').find('input');
    const valorActual = parseFloat(input.val()) || 0;
    const nuevoValor = incrementar ? valorActual + 1 : Math.max(0, valorActual - 1);
    input.val(nuevoValor).trigger('input');
}

// Eventos para manejar botones incrementar y decrementar
$(document).on('click', '.incrementar', function () {
    ajustarCantidad(this, true);
});
$(document).on('click', '.decrementar', function () {
    ajustarCantidad(this, false);
});
   // Validación para redondear valores a enteros
   $('#LotesMP').on('blur', '.cantidad-consumir', function () {
    const input = $(this);
    const valorActual = parseFloat(input.val()) || 0;
    const valorRedondeado = Math.round(valorActual);
    input.val(valorRedondeado);
});

// ============================
// Funciones de Recalculo
// ============================
// Función para recalcular el subtotal de materia prima
function recalcularSubtotalMateriaPrima() {
    let total = 0;
    $('#LotesMP tbody tr').each(function() {
        const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
        const precioUnitario = parseFloat($(this).find('td:eq(5)').text()) || 0;
        total += cantidad * precioUnitario;
    });
    $('#subtotalMP').val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}

// Función para recalcular el subtotal de insumos
function recalcularSubtotalInsumos() {
    let total = 0;
    $('#LotesINS tbody tr').each(function() {
        const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
        const precioUnitario = parseFloat($(this).find('td:eq(5)').text()) || 0;
        total += cantidad * precioUnitario;
    });
    $('#subtotalINS').val(total.toFixed(2));
    recalcularCostoTotalProduccion();
}

    // Evento para recalcular el costo total de producción al cambiar cantidades
$('#LotesMP, #LotesINS').on('input', '.cantidad-consumir', recalcularCostoTotalProduccion);
// Registrar Producción
$('#registrarProduccion').click(function() {
    alert("Producción registrada correctamente.");
});

// // Manejar el clic en el botón "Detalles"
// $('#LotesMP').on('click', '.details-btn', function() {
//     const loteID = $(this).data('id');
//     cargarDetallesLote(loteID);
// });

// // Función para cargar detalles del lote (reutilizada)
// function cargarDetallesLote(loteID) {
//     $.ajax({
//         url: '../AJAX/ctrInvFrutas.php',
//         type: 'POST',
//         data: { action: 'obtenerDetalleLote', lote_id: loteID },
//         dataType: 'json',
//         success: function(response) {
//             if (response.status === 'success') {
//                 // Llenar el modal con los datos recibidos
//                 $('#detalleFecha').text(response.data.Fecha);
//                 $('#detalleHora').text(response.data.Hora);
//                 $('#detalleLote').text(response.data.Numero_Lote);
//                 $('#detalleProveedor').text(response.data.Proveedor);
//                 $('#detalleArticulo').text(response.data.Artículo);
//                 $('#detalleCantidadIngresada').text(response.data.Cantidad_Ingresada);
//                 $('#detalleCantidadRestante').text(response.data.Cantidad_Restante);
//                 $('#detalleUnidadMedida').text(response.data.Unidad_Medida);
//                 $('#detallePresentacion').text(response.data.Presentación);
//                 $('#detallePrecioUnitario').text(response.data.Precio_Unitario);
//                 $('#detallePrecioTotal').text(response.data.Precio_Total);
//                 $('#detalleEstado').text(response.data.Estado);
//                 $('#detalleBrix').text(response.data.Brix);
//                 $('#detallePesoUnitario').text(response.data.Peso_Unitario);
//                 $('#detalleBultos').text(response.data.Bultos_Canastas);
//                 $('#detalleObservacion').text(response.data.Observación);
//                 $('#detalleAprobacion').text(response.data.Aprobación);

//                 // Mostrar el modal
//                 $('#detalleModal').modal('show');
//             } else {
//                 alert('Error: ' + response.message);
//             }
//         },
//         error: function() {
//             alert('Error en la solicitud AJAX.');
//         }
//     });
// }
});