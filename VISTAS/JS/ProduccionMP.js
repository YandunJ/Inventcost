$(document).ready(function() {
    const tablaSeleccionarMP = $('#tablaSeleccionarMP').DataTable({
        ajax: {
            url: '../AJAX/ctrProduccionMP.php',
            type: 'POST',
            data: { action: 'obtenerMateriaPrima' },
            dataSrc: function(json) {
                if (json.status === 'success') {
                    return json.data;
                } else {
                    alert('Error: ' + json.message);
                    return [];
                }
            }
        },
        columns: [
            { data: 'Lote' },
            { data: 'Proveedor' },
            { data: 'Artículo' },
            { data: 'unidad_medida' },
            
            { data: 'Cantidad_Disponible' },
            { data: 'precio_unitario' },
            { data: 'Precio_Total' },
            
            {
                data: 'ID', // Reutilizando el campo ID
                render: function(data, type, row) {
                    return `
                        <button class="btn btn-info btn-sm details-btn" data-id="${data}">
                            <i class="fas fa-info-circle"></i> Detalles
                        </button>
                    `;
                }
            },
            {   
                data: null,
                render: function(data, type, row) {
                    return `<input type="number" class="form-control cantidad-consumir" min="0" max="${row.Cantidad_Disponible}" step="0.01" disabled>`;
                }
            },
            {
                data: 'ID',
                render: function(data, type, row) {
                    return `<input type="checkbox" class="form-check-input select-mp" value="${data}">`;
                }
            }
           
        ]
    });
    const tablaSeleccionarINS = $('#tablaSeleccionarINS').DataTable({
        ajax: {
            url: '../AJAX/ctrInvInsumos.php', // Usamos el controlador correcto
            type: 'POST',
            data: { action: 'cargarInsumosTabla' },
            dataSrc: function(json) {
                if (json.status === 'success') {
                    return json.data;
                } else {
                    alert('Error: ' + json.message);
                    return [];
                }
            }
        },
        columns: [
            { data: 'Lote' },
            { data: 'Proveedor' },
            { data: 'Insumo' },
            
            
            
            { data: 'Unidad_Medida' },
            { data: 'Cantidad' },
            { data: 'Cantidad_Restante' },
            { data: 'Precio_Unitario' },
            { data: 'Precio_Total' },
            { data: 'Presentacion' },
            { data: 'Estado' },
            {
                data: null,
                render: function(data, type, row) {
                    return `<input type="number" class="form-control cantidad-consumir" 
                                   min="0" max="${row.Cantidad_Restante}" step="0.01" disabled>`;
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    return `<input type="checkbox" class="seleccionar-checkbox">`;
                }
            }
        ]
    });
    // Habilitar/Deshabilitar cantidad a consumir
    $('#tablaSeleccionarMP tbody').on('change', '.select-mp', function() {
        const row = $(this).closest('tr');
        const cantidadInput = row.find('.cantidad-consumir');
        cantidadInput.prop('disabled', !this.checked);
        if (!this.checked) cantidadInput.val('');
    });

    // Registrar Producción
    $('#registrarProduccion').click(function() {
        alert("Producción registrada correctamente.");
    });

       // Manejar el clic en el botón "Detalles"
       $('#tablaSeleccionarMP').on('click', '.details-btn', function() {
        const loteID = $(this).data('id');
        cargarDetallesLote(loteID);
    });

    // Función para cargar detalles del lote (reutilizada)
    function cargarDetallesLote(loteID) {
        $.ajax({
            url: '../AJAX/ctrInvFrutas.php',
            type: 'POST',
            data: { action: 'obtenerDetalleLote', lote_id: loteID },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    // Llenar el modal con los datos recibidos
                    $('#detalleFecha').text(response.data.Fecha);
                    $('#detalleHora').text(response.data.Hora);
                    $('#detalleLote').text(response.data.Numero_Lote);
                    $('#detalleProveedor').text(response.data.Proveedor);
                    $('#detalleArticulo').text(response.data.Artículo);
                    $('#detalleCantidadIngresada').text(response.data.Cantidad_Ingresada);
                    $('#detalleCantidadRestante').text(response.data.Cantidad_Restante);
                    $('#detalleUnidadMedida').text(response.data.Unidad_Medida);
                    $('#detallePresentacion').text(response.data.Presentación);
                    $('#detallePrecioUnitario').text(response.data.Precio_Unitario);
                    $('#detallePrecioTotal').text(response.data.Precio_Total);
                    $('#detalleEstado').text(response.data.Estado);
                    $('#detalleBrix').text(response.data.Brix);
                    $('#detallePesoUnitario').text(response.data.Peso_Unitario);
                    $('#detalleBultos').text(response.data.Bultos_Canastas);
                    $('#detalleObservacion').text(response.data.Observación);
                    $('#detalleAprobacion').text(response.data.Aprobación);

                    // Mostrar el modal
                    $('#detalleModal').modal('show');
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function() {
                alert('Error en la solicitud AJAX.');
            }
        });
    }
});
