$(document).ready(function () {
    $('#toggleSubtotales').on('click', function () {
        $('#subtotalesContent').slideToggle();
        $(this).find('i').toggleClass('fa-chevron-down fa-chevron-up');
    });
});

$(document).ready(function () {
// ============================
    // Inicialización de DataTables
    // ============================
 
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
        { data: 'FechaHora' },
        { data: 'Lote' },
        { data: 'Proveedor' },
        { data: 'Articulo' },
        { data: 'UnidadMedida' },
        { data: 'Brix' },
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
                    <input type="text" class="form-control cantidad-consumir text-center" 
                           value="0" min="0" max="${row.CantidadDisponible}" step="0.01" disabled>
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
        { data: 'FechaHora' },
        { data: 'Lote' },
        { data: 'Proveedor' },
        { data: 'Insumo' },
        { data: 'UnidadMedida' },
        { data: 'CantidadRestante' },
        { data: 'PrecioUnitario' },
        {
            data: null,
            render: function (data, type, row) {
                return `
                <div class="input-group cantidad-group">
                    <div class="input-group-prepend">
                        <button type="button" class="btn btn-outline-secondary btn-sm decrementar" disabled>-</button>
                    </div>
                    <input type="text" class="form-control cantidad-consumir text-center" 
                           value="0" min="0" max="${row.CantidadRestante}" step="0.01" disabled>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-outline-secondary btn-sm incrementar" disabled>+</button>
                    </div>
                </div>`;
            }
        },
        {
            data: 'ID',
            render: function (data) {
                return `<input type="checkbox" class="form-check-input seleccionar-checkbox" value="${data}">`;
            }
        }
    ];

    const LotesINS = inicializarDataTable(
        '#LotesINS',
        '../AJAX/ctrInvInsumos.php',
        { action: 'cargarInsumosTabla' },
        columnasINS,
        function (row) {
            return row.CantidadRestante > 0; // Filtro: solo mostrar registros con cantidad restante
        }
    );
    // Función para recargar los DataTables de Materia Prima e Insumos
    function recargarTablas() {
        LotesMP.ajax.reload();
        LotesINS.ajax.reload();
    }

    // Llamar a la función para recargar los DataTables después de registrar una producción
    $(document).on('produccionRegistrada', function () {
        recargarTablas();
    });

    // Eventos de cambio en insumos, MP, mano de obra y costos indirectos
    $('#LotesMP').on('input', '.cantidad-consumir', recalcularSubtotalMateriaPrima);
    $('#LotesINS').on('input', '.cantidad-consumir', recalcularSubtotalInsumos);

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
                    <input type="text" class="form-control precio-ht" min="0" step="0.01" value="0">
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
                    <input type="text" class="form-control horas-por-dia" min="0" value="0">
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
                    <input type="text" class="form-control cantidad-unidades" value="0">
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
                    <input type="text" class="form-control precio-unitario" value="0">
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

    // Función para validar los datos de cada pestaña
    function validarDatosProduccion() {
        // Validar Materia Prima
        let validMP = false;
        $('#LotesMP tbody tr').each(function () {
            if ($(this).find('.select-mp').is(':checked')) {
                const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
                if (cantidad > 0) {
                    validMP = true;
                    return false; // Salir del bucle
                }
            }
        });

        // Validar Insumos
        let validINS = false;
        $('#LotesINS tbody tr').each(function () {
            if ($(this).find('.seleccionar-checkbox').is(':checked')) {
                const cantidad = parseFloat($(this).find('.cantidad-consumir').val()) || 0;
                if (cantidad > 0) {
                    validINS = true;
                    return false; // Salir del bucle
                }
            }
        });

        // Validar Mano de Obra
        let validMO = false;
        $('#tablaManoObra tbody tr').each(function () {
            const cantidadPersonas = parseFloat($(this).find('.cantidad-personas').val()) || 0;
            const horasTrabajadas = parseFloat($(this).find('.horas-por-dia').val()) || 0;
            const precioHora = parseFloat($(this).find('.precio-ht').val()) || 0;
            if (cantidadPersonas > 0 && horasTrabajadas > 0 && precioHora > 0) {
                validMO = true;
                return false; // Salir del bucle
            }
        });

        // Validar Costos Indirectos
        let validCI = false;
        $('#tablaCostosIndirectos tbody tr').each(function () {
            const cantidadUnidades = parseFloat($(this).find('.cantidad-unidades').val()) || 0;
            const precioUnitario = parseFloat($(this).find('.precio-unitario').val()) || 0;
            if (cantidadUnidades > 0 && precioUnitario > 0) {
                validCI = true;
                return false; // Salir del bucle
            }
        });

        return validMP && validINS && validMO && validCI;
    }

    $('#btnRegistrarProduccionModal').on('click', function () {
        if (!validarDatosProduccion()) {
            Swal.fire('Error', 'Por favor, complete todos los datos necesarios en cada pestaña antes de registrar la producción.', 'error');
            return;
        }

        Swal.fire({
            title: '¿Estás seguro?',
            text: '¿Deseas registrar esta producción? Si has ingresado algún dato incorrecto, tendrás que cancelar esta producción y registrarla nuevamente.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, registrar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                const cant_producida = $('#totalPresentaciones').val() || 0; // Usar el total de presentaciones como cantidad producida
                const lotes_mp = JSON.stringify(getLotesMP());
                const lotes_ins = JSON.stringify(getLotesINS());
                const mano_obra = JSON.stringify(getDatosManoObra());
                const costos_indirectos = JSON.stringify(getCostosIndirectos());
                const presentaciones_pt = JSON.stringify(getPresentacionesPT());
                const lote_pt = $('#loteProductoTerminado').val(); // Obtener el lote de Producto Terminado

                console.log("Datos de Materia Prima:", JSON.parse(lotes_mp));
                console.log("Datos de Insumos:", JSON.parse(lotes_ins));
                console.log("Datos de Mano de Obra:", JSON.parse(mano_obra));
                console.log("Datos de Costos Indirectos:", JSON.parse(costos_indirectos));
                console.log("Datos de Producto Terminado:", JSON.parse(presentaciones_pt));
                console.log("Lote de Producto Terminado:", lote_pt);

                $.ajax({
                    url: '../AJAX/ctrProduccionMP.php',
                    type: 'POST',
                    data: {
                        action: 'registrarProduccion',
                        cant_producida: cant_producida,
                        lotes_mp: lotes_mp,
                        lotes_ins: lotes_ins,
                        mano_obra: mano_obra,
                        costos_indirectos: costos_indirectos,
                        presentaciones_pt: presentaciones_pt,
                        lote_pt: lote_pt
                    },
                    success: function (response) {
                        try {
                            const result = JSON.parse(response);
                            if (result.status === 'success') {
                                Swal.fire('Éxito', 'Producción registrada correctamente.', 'success').then(() => {
                                    // Cerrar el modal
                                    $('#modalRegistrarProduccion').modal('hide');
                                    // Limpiar el formulario
                                    limpiarFormularioProduccion();
                                    // Disparar el evento personalizado para recargar los DataTables
                                    $(document).trigger('produccionRegistrada');
                                });
                            } else {
                                Swal.fire('Error', result.message || 'Ocurrió un error inesperado.', 'error');
                            }
                        } catch (e) {
                            Swal.fire('Error', 'Error en la respuesta del servidor: ' + response, 'error');
                        }
                    },
                    error: function (xhr, status, error) {
                        Swal.fire('Error', 'Error de comunicación con el servidor', 'error');
                        console.error("Error: ", error);
                        console.error("Response: ", xhr.responseText);
                    }
                });
            }
        });
    });

// Función para obtener los datos de Producto Terminado
function getPresentacionesPT() {
    let presentaciones = [];
    $('#tablaPresentaciones tbody tr').each(function () {
        const presentacion = $(this).find('td:eq(0)').text();
        const cant_disponible = parseFloat($(this).find('td:eq(1)').text()) || 0;
        const p_u = parseFloat($(this).find('.costo-unitario').text().replace('$', '')) || 0;
        const p_t = parseFloat($(this).find('.costo-total').text().replace('$', '')) || 0;
        presentaciones.push({
            presentacion: presentacion,
            cant_disponible: cant_disponible,
            p_u: p_u,
            p_t: p_t
        });
    });
    return presentaciones;
}
// Funciones para obtener los datos de las pestañas
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
    if (!isChecked) {
        cantidadInput.val('0');
        recalcularSubtotalMateriaPrima(); // Recalcular subtotal al desmarcar
    }
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

    if (!isChecked) {
        cantidadInput.val('0');
        recalcularSubtotalInsumos(); // Recalcular subtotal al desmarcar
    }
});

function limpiarFormularioProduccion() {
    // Limpiar campos de Materia Prima
    $('#LotesMP tbody tr').each(function () {
        $(this).find('.select-mp').prop('checked', false);
        $(this).find('.cantidad-consumir').val('0').prop('disabled', true);
        $(this).find('.incrementar').prop('disabled', true);
        $(this).find('.decrementar').prop('disabled', true);
    });

    // Limpiar campos de Insumos
    $('#LotesINS tbody tr').each(function () {
        $(this).find('.seleccionar-checkbox').prop('checked', false);
        $(this).find('.cantidad-consumir').val('0').prop('disabled', true);
        $(this).find('.incrementar').prop('disabled', true);
        $(this).find('.decrementar').prop('disabled', true);
    });

    // Limpiar campos de Mano de Obra
    $('#tablaManoObra tbody tr').each(function () {
        $(this).find('.cantidad-personas').val('0');
        $(this).find('.precio-ht').val('0');
        $(this).find('.horas-por-dia').val('0');
        $(this).find('.horas-trabajador').text('0');
        $(this).find('.costo-dia').text('$0.00');
    });

    // Limpiar campos de Costos Indirectos
    $('#tablaCostosIndirectos tbody tr').each(function () {
        $(this).find('.cantidad-unidades').val('0');
        $(this).find('.precio-unitario').val('0');
        $(this).find('.costo-total').text('$0.00');
    });

    // Limpiar campos de Producto Terminado
    $('#loteProductoTerminado').val('');
    $('#presentacionProducto').val('');
    $('#cantidadPresentacion').val('');
    $('#tablaPresentaciones tbody').empty();
    $('#totalPresentaciones').val('0');

    // Limpiar subtotales
    $('#subtotalMP').val('0.00');
    $('#subtotalINS').val('0.00');
    $('#subtotalMO').val('0.00');
    $('#subtotalCA').val('0.00');
    $('#totalProduccion').val('0.00');
}




});