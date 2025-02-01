$(document).ready(function () {
    $('#toggleSubtotales').on('click', function () {
        $('#subtotalesContent').slideToggle();
        $(this).find('i').toggleClass('fa-chevron-down fa-chevron-up');
    });
});

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
    
const LotesMP = inicializarDataTable(
    '#LotesMP',
    '../AJAX/ctrInvFrutas.php',
    { action: 'cargarMateriaPrima' },
    columnasMP,
    function (row) {
        return row.CantidadDisponible > 0; // Filtro: solo mostrar registros con cantidad disponible
    }
);

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
                           value="0" min="0" max="${row.Cantidad_Restante}" step="0.5" disabled>
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

    const LotesINS = inicializarDataTable(
        '#LotesINS',
        '../AJAX/ctrInvInsumos.php',
        { action: 'cargarInsumosTabla' },
        columnasINS,
        function (row) {
            return row.Cantidad_Restante > 0; // Filtro: solo mostrar registros con cantidad restante
        }
    );

    // MANO DE OBRA
    const columnasMO = [
        { data: 'cat_id'}, // ID oculto
        { data: 'cat_nombre' },
        {
            data: null,
            render: function () {
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
            data: null,
            render: function () {
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
            data: null,
            render: function () {
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
        {
            data: null,
            render: function () {
                return `<span class="horas-trabajador">0</span>`;
            }
        },
        {
            data: null,
            render: function () {
                return `<span class="costo-dia">$0.00</span>`;
            }
        }
    ];

    const tablaManoObra = inicializarDataTable('#tablaManoObra', 
        '../AJAX/ctrCost.php', { action: 'obtenerCostos', opcion: 1 }, 
        columnasMO, item => item.categoria === 'Mano de Obra' && item.cat_estado === 'habilitado'); 

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
        { "data": 'cat_id'},
        { "data": "cat_nombre" },
        { "data": "prs_nombre" },
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

// Registrar Producción
$('#registrarProduccion').click(function() {
    alert("Producción registrada correctamente.");
});
 
// REGISTRAR PRODUCCIÓN
// ===========================
 // Función para registrar la producción
 $('#btnRegistrarProduccionModal').on('click', function () {
    const cant_producida = $('#cant_producida').val() || 0;
    const lotes_mp = JSON.stringify(getLotesMP());
    const lotes_ins = JSON.stringify(getLotesINS());
    const mano_obra = JSON.stringify(getDatosManoObra());
    const costos_indirectos = JSON.stringify(getCostosIndirectos());

    console.log("Datos de Materia Prima:", JSON.parse(lotes_mp));
    console.log("Datos de Insumos:", JSON.parse(lotes_ins));
    console.log("Datos de Mano de Obra:", JSON.parse(mano_obra));
    console.log("Datos de Costos Indirectos:", JSON.parse(costos_indirectos));

    $.ajax({
        url: '../AJAX/ctrProduccionMP.php',
        type: 'POST',
        data: {
            action: 'registrarProduccion',
            cant_producida: cant_producida,
            lotes_mp: lotes_mp,
            lotes_ins: lotes_ins,
            mano_obra: mano_obra,
            costos_indirectos: costos_indirectos
        },
        success: function (response) {
            try {
                const result = JSON.parse(response);
                if (result.status === 'success') {
                    alert('Producción registrada correctamente');
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
// OBTENER DATOS DE LAS PESTAÑAS       
// ===========================
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

    // Función para obtener los datos de mano de obra
    function getDatosManoObra() {
        let manoObra = [];
        $('#tablaManoObra tbody tr').each(function () {
            const cat_id = $(this).find('td:eq(0)').text(); // Obtener el ID de la actividad
            const mo_cant_personas = parseFloat($(this).find('.cantidad-personas').val()) || 0;
            const mo_horas_trabajadas = parseFloat($(this).find('.horas-por-dia').val()) || 0;
            const mo_precio_hora = parseFloat($(this).find('.precio-ht').val()) || 0;
            manoObra.push({
                cat_id: cat_id,
                mo_cant_personas: mo_cant_personas,
                mo_horas_trabajadas: mo_horas_trabajadas,
                mo_precio_hora: mo_precio_hora
            });
        });
        return manoObra;
    }

    // Función para obtener los datos de costos indirectos
    function getCostosIndirectos() {
        let costosIndirectos = [];
        $('#tablaCostosIndirectos tbody tr').each(function () {
            const cat_id = $(this).find('td:eq(0)').text(); // Obtener el ID del costo indirecto
            const cst_cant = parseFloat($(this).find('.cantidad-unidades').val()) || 0;
            const cst_presentacion = $(this).find('td:eq(2)').text(); // Obtener la presentación
            const cst_precio_ht = parseFloat($(this).find('.precio-unitario').val()) || 0;
            const cst_costo_total = cst_cant * cst_precio_ht;
            costosIndirectos.push({
                cat_id: cat_id,
                cst_cant: cst_cant,
                cst_presentacion: cst_presentacion,
                cst_precio_ht: cst_precio_ht,
                cst_costo_total: cst_costo_total
            });
        });
        return costosIndirectos;
    }

    // Exponer las funciones globalmente
    window.getLotesMP = getLotesMP;
    window.getLotesINS = getLotesINS;
    window.getDatosManoObra = getDatosManoObra;
    window.getCostosIndirectos = getCostosIndirectos;

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

});