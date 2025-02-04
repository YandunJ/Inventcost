$(document).ready(function () {
    // Inicializar el DataTable para mostrar las producciones registradas
    const tablaProducciones = $('#tablaProducciones').DataTable({
        ajax: {
            url: '../AJAX/ctrProduccionMP.php',
            type: 'POST',
            data: { action: 'obtenerProducciones' },
            dataSrc: function (json) {
                if (json.status === 'success') {
                    return json.data;
                }
                return [];
            }
        },
        columns: [
            { data: 'pro_fecha' },
            { data: 'pro_cant_producida' },
            { data: 'pro_subtotal_mtpm' },
            { data: 'pro_subtotal_ins' },
            { data: 'pro_subtotal_mo' },
            { data: 'pro_subtotal_ci' },
            { data: 'pro_total' },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-cog"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item ver-btn" href="#" data-id="${row.pro_id}">
                                    <i class="fas fa-eye"></i> Ver
                                </a>
                                <a class="dropdown-item edit-btn" href="#" data-id="${row.pro_id}">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                            </div>
                        </div>
                    `;
                }
            }
        ],
        "language": dataTableLanguage
    });

    // Función para cargar y mostrar los detalles de una producción en el modal
    $('#tablaProducciones').on('click', '.ver-btn', function () {
        const pro_id = $(this).data('id');

        // Datos ficticios para probar el modal
        const datosFicticios = {
            pro_fecha: '2025-01-31 15:21:59',
            pro_cant_producida: '1000.00',
            pro_subtotal_mtpm: '500.00',
            pro_subtotal_ins: '200.00',
            pro_subtotal_mo: '300.00',
            pro_subtotal_ci: '100.00',
            pro_total: '1100.00'
        };

        // Cargar los datos ficticios en el modal
        $('#verFecha').val(datosFicticios.pro_fecha);
        $('#verCantidadProducida').val(datosFicticios.pro_cant_producida);
        $('#verSubtotalMP').val(datosFicticios.pro_subtotal_mtpm);
        $('#verSubtotalINS').val(datosFicticios.pro_subtotal_ins);
        $('#verSubtotalMO').val(datosFicticios.pro_subtotal_mo);
        $('#verSubtotalCI').val(datosFicticios.pro_subtotal_ci);
        $('#verTotal').val(datosFicticios.pro_total);

        // Mostrar el modal
        $('#verProduccionModal').modal('show');
    });
});