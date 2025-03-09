$(document).ready(function() {
    // Inicializar DataTable para buscar productos
    const tablaProductos = $('#tablaProductos').DataTable({
        ajax: {
            url: '../AJAX/ctrVentaPT.php',
            type: 'POST',
            data: { action: 'obtenerInventarioPT' },
            dataSrc: 'data'
        },
        columns: [
            { data: 'presentacion' },
            { data: 'lote' },
            { data: 'pulpa' },
            { data: 'costo_unitario' },
            { data: 'precio_venta_sugerido' },
            { data: 'cantidad_disponible' },
            {
                data: null,
                render: function(data, type, row) {
                    return `
                        <div class="input-group cantidad-group">
                            <div class="input-group-prepend">
                                <button type="button" class="btn btn-outline-secondary btn-sm decrementar" disabled>-</button>
                            </div>
                            <input type="number" class="form-control cantidad-consumir text-center" value="0" min="0" max="${row.cantidad_disponible}" step="1" disabled>
                            <div class="input-group-append">
                                <button type="button" class="btn btn-outline-secondary btn-sm incrementar" disabled>+</button>
                            </div>
                        </div>`;
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    return `<input type="checkbox" class="form-check-input select-producto" data-id-pt="${row.id_pt}" data-lote="${row.lote}" data-cantidad-disponible="${row.cantidad_disponible}" data-pulpa="${row.pulpa}" data-precio-venta-sugerido="${row.precio_venta_sugerido}">`;
                }
            }
        ],
        language: dataTableLanguage // Usar la configuración de idioma desde DTesp.js
    });

    // Habilitar/deshabilitar campo y botones al seleccionar producto
    $('#tablaProductos tbody').on('change', '.select-producto', function() {
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
        }
    });

    // Incrementar/decrementar cantidad a consumir
    $('#tablaProductos tbody').on('click', '.incrementar, .decrementar', function() {
        const input = $(this).closest('.input-group').find('input');
        let valorActual = parseInt(input.val()) || 0;
        const max = parseInt(input.attr('max')) || Infinity;
        const incremento = $(this).hasClass('incrementar') ? 1 : -1;

        let nuevoValor = valorActual + incremento;
        if (nuevoValor < 0) nuevoValor = 0;
        if (nuevoValor > max) nuevoValor = max;

        input.val(nuevoValor).trigger('input');
    });

    // Validar que solo se ingresen enteros en el campo de cantidad a consumir
    $('#tablaProductos tbody').on('input', '.cantidad-consumir', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    // Función para agregar productos seleccionados a la tabla de despacho
    $('#btnAgregarSeleccionados').on('click', function() {
        $('.select-producto:checked').each(function() {
            const id_pt = $(this).data('id-pt');
            const lote = $(this).data('lote');
            const cantidadDisponible = $(this).data('cantidad-disponible');
            const pulpa = $(this).data('pulpa');
            const precioVentaSugerido = $(this).data('precio-venta-sugerido');
            const cantidadConsumir = parseInt($(this).closest('tr').find('.cantidad-consumir').val());

            // Validar que la cantidad a consumir sea mayor a cero y no exceda la cantidad disponible
            if (cantidadConsumir <= 0 || cantidadConsumir > cantidadDisponible) {
                Swal.fire('Error', 'La cantidad a consumir debe ser mayor a cero y no exceder la cantidad disponible.', 'error');
                return;
            }

            // Validar que la cantidad total a consumir no exceda la cantidad disponible
            let cantidadTotalConsumir = cantidadConsumir;
            $('#tablaDespacho tbody tr').each(function() {
                const filaLote = $(this).find('td').eq(1).text();
                if (filaLote === lote) {
                    cantidadTotalConsumir += parseInt($(this).find('.cantidad-despacho').val());
                }
            });

            if (cantidadTotalConsumir > cantidadDisponible) {
                Swal.fire('Error', `La cantidad total a consumir del lote ${lote} no puede exceder ${cantidadDisponible}.`, 'error');
                return;
            }

            const fila = `
                <tr>
                    <td>${id_pt}</td>
                    <td>${lote}</td>
                    <td>${pulpa}</td>
                    <td><input type="number" class="form-control cantidad-despacho" value="${cantidadConsumir}" min="1" max="${cantidadDisponible}" readonly></td>
                    <td><input type="number" class="form-control precio-venta" value="${precioVentaSugerido}" min="${precioVentaSugerido}" step="0.01"></td>
                    <td class="precio-total">${(cantidadConsumir * precioVentaSugerido).toFixed(2)}</td>
                    <td><button class="btn btn-danger btnEliminar">Eliminar</button></td>
                </tr>
            `;

            $('#tablaDespacho tbody').append(fila);
        });
        actualizarPrecios();
        $('#modalBuscarProducto').modal('hide');
    });

    // Función para actualizar los precios totales
    function actualizarPrecios() {
        let precioTotalSalida = 0;
        $('#tablaDespacho tbody tr').each(function() {
            const cantidad = parseFloat($(this).find('.cantidad-despacho').val());
            const precioVenta = parseFloat($(this).find('.precio-venta').val());
            const precioTotal = cantidad * precioVenta;
            $(this).find('.precio-total').text(precioTotal.toFixed(2));
            precioTotalSalida += precioTotal;
        });
        $('#precioTotalSalida').text(precioTotalSalida.toFixed(2));
    }

    // Actualizar precios totales al cambiar el precio de venta
    $('#tablaDespacho tbody').on('input', '.precio-venta', function() {
        const precioVentaSugerido = parseFloat($(this).attr('min'));
        const precioVenta = parseFloat($(this).val());

        // if (precioVenta < precioVentaSugerido) {
        //     Swal.fire('Error', 'El precio de venta no puede ser menor al precio de venta sugerido.', 'error');
        //     $(this).val(precioVentaSugerido);
        // }

        actualizarPrecios();
    });

    // Eliminar producto de la tabla de despacho
    $('#tablaDespacho tbody').on('click', '.btnEliminar', function() {
        $(this).closest('tr').remove();
        actualizarPrecios();
    });

    // Procesar Despacho
    $('#btnRegistrarSalida').on('click', function() {
        const despacho = [];
        $('#tablaDespacho tbody tr').each(function() {
            const id_pt = $(this).find('td').eq(0).text();
            const lote = $(this).find('td').eq(1).text();
            const cantidad = $(this).find('.cantidad-despacho').val();
            const precioVenta = $(this).find('.precio-venta').val();
            despacho.push({ id_pt, lote, cantidad_despachada: parseFloat(cantidad), precio_venta: parseFloat(precioVenta) });
        });

        if (despacho.length === 0) {
            Swal.fire('Error', 'Debe agregar al menos un producto para despachar', 'error');
            return;
        }

        const precioTotalSalida = parseFloat($('#precioTotalSalida').text());

        // Enviar los datos del despacho al servidor para procesarlos
        $.ajax({
            url: '../AJAX/ctrVentaPT.php',
            type: 'POST',
            data: {
                action: 'registrarDespacho',
                despacho: JSON.stringify(despacho),
                precio_total: precioTotalSalida
            },
            success: function(response) {
                try {
                    const result = JSON.parse(response);
                    if (result.status === 'success') {
                        Swal.fire('Éxito', result.message, 'success').then((result) => {
                            if (result.isConfirmed) {
                                Swal.fire({
                                    title: '¿Desea imprimir el comprobante?',
                                    showCancelButton: true,
                                    confirmButtonText: 'Sí',
                                    cancelButtonText: 'No'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        // Generar el comprobante de salida en PDF
                                        const url = `../AJAX/PDFsalida.php?despacho=${encodeURIComponent(JSON.stringify(despacho))}&precio_total=${precioTotalSalida}`;
                                        window.open(url, '_blank');
                                    }
                                });
                            }
                        });
                        // Limpiar la tabla de despacho
                        $('#tablaDespacho tbody').empty();
                        $('#precioTotalSalida').text('0.00');
                    } else {
                        Swal.fire('Error', result.message, 'error');
                    }
                } catch (e) {
                    Swal.fire('Error', 'Respuesta del servidor no válida', 'error');
                }
            },
            error: function(xhr, status, error) {
                Swal.fire('Error', 'Ocurrió un error al registrar el despacho', 'error');
            }
        });
    });
});