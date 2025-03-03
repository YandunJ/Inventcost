$(document).ready(function() {
    // Datos de ejemplo
    const datosPresentaciones = [
        { presentacion: '100 gr', lote: 'Lote1', composicion: 'Manzana', cantidad_disponible: 50, precio_unitario: 0.60 },
        { presentacion: '100 gr', lote: 'Lote2', composicion: 'Manzana', cantidad_disponible: 30, precio_unitario: 0.60 },
        { presentacion: '200 gr', lote: 'Lote1', composicion: 'Manzana', cantidad_disponible: 20, precio_unitario: 1.20 },
        { presentacion: '200 gr', lote: 'Lote2', composicion: 'Manzana', cantidad_disponible: 10, precio_unitario: 1.20 }
    ];

    // Inicializar DataTable para buscar productos
    const tablaProductos = $('#tablaProductos').DataTable({
        data: datosPresentaciones,
        columns: [
            { data: 'presentacion' },
            { data: 'lote' },
            { data: 'composicion' },
            { data: 'cantidad_disponible' },
            { data: 'precio_unitario' },
            {
                data: null,
                render: function(data, type, row) {
                    return `<input type="checkbox" class="select-producto" data-presentacion="${row.presentacion}" data-lote="${row.lote}" data-composicion="${row.composicion}" data-cantidad="${row.cantidad_disponible}" data-precio="${row.precio_unitario}">`;
                }
            }
        ],
        language: dataTableLanguage // Usar la configuración de idioma desde DTesp.js
    });

    // Función para agregar productos seleccionados a la tabla de despacho
    $('#btnAgregarSeleccionados').on('click', function() {
        $('.select-producto:checked').each(function() {
            const presentacion = $(this).data('presentacion');
            const lote = $(this).data('lote');
            const composicion = $(this).data('composicion');
            const cantidadDisponible = $(this).data('cantidad');
            const precioUnitario = $(this).data('precio');

            const fila = `
                <tr>
                    <td>${presentacion}</td>
                    <td>${lote}</td>
                    <td>${composicion}</td>
                    <td><input type="number" class="form-control cantidad-despacho" data-cantidad-disponible="${cantidadDisponible}" value="1" min="1" max="${cantidadDisponible}"></td>
                    <td><input type="number" class="form-control precio-unitario" value="${(precioUnitario * 1.20).toFixed(2)}" step="0.01" data-precio-unitario="${precioUnitario}"></td>
                    <td class="precio-total">${(precioUnitario * 1.20).toFixed(2)}</td>
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
        $('#tablaDespacho tbody tr').each(function() {
            const cantidad = $(this).find('.cantidad-despacho').val();
            const precioUnitario = $(this).find('.precio-unitario').val();
            const precioTotal = cantidad * precioUnitario;
            $(this).find('.precio-total').text(precioTotal.toFixed(2));
        });
    }

    // Validar precio de venta
    function validarPrecio(precioUnitario, precioVenta) {
        const precioMinimo = precioUnitario * 1.20; // Margen de ganancia mínimo del 20%
        const precioMaximo = precioUnitario * 2.00; // Margen de ganancia máximo del 100%
        if (precioVenta < precioMinimo) {
            return `El precio de venta no puede ser inferior a ${precioMinimo.toFixed(2)}`;
        }
        if (precioVenta > precioMaximo) {
            return `El precio de venta no puede ser superior a ${precioMaximo.toFixed(2)}`;
        }
        return null;
    }

    // Actualizar precios al cambiar cantidad o precio unitario
    $('#tablaDespacho').on('input', '.cantidad-despacho, .precio-unitario', function() {
        const precioUnitario = $(this).data('precio-unitario');
        const precioVenta = parseFloat($(this).val());
        const mensajeValidacion = validarPrecio(precioUnitario, precioVenta);
        if (mensajeValidacion) {
            Swal.fire('Error', mensajeValidacion, 'error');
            $(this).val((precioUnitario * 1.20).toFixed(2)); // Revertir al precio mínimo permitido
        } else {
            actualizarPrecios();
        }
    });

    // Eliminar fila de la tabla de despacho
    $('#tablaDespacho').on('click', '.btnEliminar', function() {
        $(this).closest('tr').remove();
        actualizarPrecios();
    });

    // Procesar Despacho
    $('#btnRegistrarDespacho').on('click', function() {
        const despacho = [];
        $('#tablaDespacho tbody tr').each(function() {
            const presentacion = $(this).find('td').eq(0).text();
            const lote = $(this).find('td').eq(1).text();
            const composicion = $(this).find('td').eq(2).text();
            const cantidad = $(this).find('.cantidad-despacho').val();
            const precioUnitario = $(this).find('.precio-unitario').val();
            const precioTotal = $(this).find('.precio-total').text();
            despacho.push({ presentacion, lote, composicion, cantidad, precioUnitario, precioTotal });
        });

        if (despacho.length === 0) {
            Swal.fire('Error', 'Debe agregar al menos un producto para despachar', 'error');
            return;
        }

        // Aquí puedes enviar los datos del despacho al servidor para procesarlos
        console.log('Despacho:', despacho);

        Swal.fire('Éxito', 'Despacho registrado correctamente', 'success');
    });
});