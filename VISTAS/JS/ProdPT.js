$(document).ready(function () {
    // Validación para acceder a la pestaña de Producto Terminado
    function validarAccesoProductoTerminado() {
        const lotesMP = getLotesMP();
        const lotesINS = getLotesINS();
        const manoObra = getDatosManoObra();
        const costosIndirectos = getCostosIndirectos();

        return lotesMP.length > 0 && lotesINS.length > 0 && manoObra.length > 0 && costosIndirectos.length > 0;
    }

    $('#productoTerminado-tab').on('show.bs.tab', function (e) {
        if (!validarAccesoProductoTerminado()) {
            e.preventDefault();
            alert('Debe completar todas las pestañas anteriores antes de acceder a Producto Terminado.');
        }
    });

    // ============================
    // PESTAÑA PRODUCTO TERMINADO
    // ===========================
    // Generar lote automáticamente (puedes ajustar esta lógica según tus necesidades)
    function generarLote() {
        const fecha = new Date();
        const lote = 'L' + fecha.getFullYear() + (fecha.getMonth() + 1).toString().padStart(2, '0') + fecha.getDate().toString().padStart(2, '0') + fecha.getHours().toString().padStart(2, '0') + fecha.getMinutes().toString().padStart(2, '0') + fecha.getSeconds().toString().padStart(2, '0');
        $('#loteProductoTerminado').val(lote);
    }

    // Cargar presentaciones de Producto Terminado en el select box
    function cargarPresentacionesPT() {
        $.ajax({
            url: '../AJAX/ctrProduccionMP.php',
            type: 'POST',
            data: { action: 'obtenerPresentacionesPT' },
            success: function (response) {
                const result = JSON.parse(response);
                if (result.status === 'success') {
                    let opciones = '<option value="">Seleccione una presentación</option>';
                    result.data.forEach(function (presentacion) {
                        opciones += `<option value="${presentacion.prs_id}" data-equivalencia="${presentacion.equivalencia}">${presentacion.prs_nombre}</option>`;
                    });
                    $('#presentacionProducto').html(opciones);
                } else {
                    console.error("Error al cargar presentaciones: ", result.message);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    }

    // Agregar nueva presentación
    $('#btnAgregarPresentacion').on('click', function () {
        const presentacionId = $('#presentacionProducto').val();
        const cantidad = parseFloat($('#cantidadPresentacion').val()) || 0;

        if (presentacionId && cantidad > 0) {
            const presentacionText = $('#presentacionProducto option:selected').text();
            const equivalencia = parseFloat($('#presentacionProducto option:selected').attr('data-equivalencia'));
            const nuevaFila = `
                <tr>
                    <td data-equivalencia="${equivalencia}">${presentacionText}</td>
                    <td>${cantidad}</td>
                    <td class="costo-unitario"></td>
                    <td class="costo-total"></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-sm eliminar-presentacion">Eliminar</button>
                    </td>
                </tr>`;
            $('#tablaPresentaciones tbody').append(nuevaFila);
            recalcularTotalPresentaciones();
        } else {
            alert('Por favor, seleccione una presentación y una cantidad válida.');
        }
    });

    // Eliminar presentación
    $('#tablaPresentaciones').on('click', '.eliminar-presentacion', function () {
        $(this).closest('tr').remove();
        recalcularTotalPresentaciones();
    });

    // Calcular total de presentaciones en gramos
    function recalcularTotalPresentaciones() {
        let totalPresentacionesGramos = 0;
        $('#tablaPresentaciones tbody tr').each(function () {
            const cantidad = parseFloat($(this).find('td:eq(1)').text()) || 0;
            const equivalencia = parseFloat($(this).find('td:eq(0)').attr('data-equivalencia')) || 0;
            totalPresentacionesGramos += cantidad * equivalencia;
        });
        $('#totalPresentaciones').val(totalPresentacionesGramos);
        recalcularCostoPorPresentacion();
    }

    // Calcular costo por presentación
    function recalcularCostoPorPresentacion() {
        const totalProduccion = parseFloat($('#totalProduccion').val()) || 0;
        const totalPresentacionesGramos = parseFloat($('#totalPresentaciones').val()) || 0;

        if (totalPresentacionesGramos > 0) {
            const costoPorGramo = totalProduccion / totalPresentacionesGramos;

            $('#tablaPresentaciones tbody tr').each(function () {
                const cantidad = parseFloat($(this).find('td:eq(1)').text()) || 0;
                const equivalencia = parseFloat($(this).find('td:eq(0)').attr('data-equivalencia')) || 0;
                const costoUnitario = costoPorGramo * equivalencia;
                const costoTotalPresentacion = cantidad * costoUnitario;
                $(this).find('.costo-unitario').text(`$${costoUnitario.toFixed(2)}`);
                $(this).find('.costo-total').text(`$${costoTotalPresentacion.toFixed(2)}`);
            });
        }
    }

    // Inicializar el formulario con valores predeterminados
    generarLote();
    cargarPresentacionesPT();
    $('#cantidadProducida').val(10); // Ejemplo de cantidad producida, puedes ajustar este valor según tus necesidades
});