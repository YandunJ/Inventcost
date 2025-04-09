$(document).ready(function() {
    // Cargar proveedores
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: "POST",
        data: { action: 'cargarProveedores' },
        dataType: "json",
        success: function(response) {
            let options = '<option value="">Seleccione proveedor</option>';
            if (response.status === 'success' && Array.isArray(response.data)) {
                response.data.forEach(function(proveedor) {
                    options += `<option value="${proveedor.proveedor_id}">${proveedor.nombre_empresa}</option>`;
                });
                $("#proveedor_id").html(options);
            } else {
                alert("Error al cargar los proveedores.");
                console.error("Error loading proveedores: ", response);
            }
        },
        error: function(xhr, status, error) {
            alert("Ocurrió un error al cargar los proveedores.");
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

    // Cargar frutas de forma independiente
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: "POST",
        data: { action: 'cargarFrutas' },
        dataType: "json",
        success: function(response) {
            let options = '<option value="">Seleccione fruta</option>';
            if (response.status === 'success' && Array.isArray(response.data)) {
                response.data.forEach(function(fruta) {
                    options += `<option value="${fruta.cat_id}">${fruta.cat_nombre}</option>`;
                });
                $("#cat_id").html(options);
            } else {
                alert("Error al cargar las frutas.");
                console.error("Error loading frutas: ", response);
            }
        },
        error: function(xhr, status, error) {
            alert("Ocurrió un error al cargar las frutas.");
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
        }
    });

  // Inicializar DataTable
  const materiaPrimasTable = $('#tablaMateriaPrimas').DataTable({
    ajax: {
        url: '../AJAX/ctrInvFrutas.php',
        type: 'POST',
        data: function(d) {
            d.action = 'cargarMateriaPrima';
            d.estado = $('#filtroEstado').val(); // Agregar filtro de estado
        },
        dataSrc: function (json) {
            if (json.status === 'success') {
                return json.data;
            } else {
                Swal.fire('Error', json.message || 'Error al cargar los datos.', 'error');
                return [];
            }
        }
    },
    order: [[0, 'desc']], // Ordenar por la primera columna (Fecha) en orden descendente
    columns: [
        { data: 'FechaHora'},
        { data: 'Lote'},
        { data: 'Proveedor'},
        { data: 'Articulo'},
        { data: 'CantidadIngresada'},
        { data: 'CantidadDisponible' },
        { data: 'PrecioUnitario'},
        { data: 'PrecioTotal' },
        { data: 'Brix'},    
        { data: 'Observacion'},
        { data: 'Estado' },
        {
            data: null,
            render: function (data, type, row) {
                return `
                    <div class="btn-group">
                        <button class="btn btn-secondary dropdown-toggle btn-sm" data-toggle="dropdown">
                            <i class="fas fa-cog"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item edit-btn" href="#" data-id="${row.ID}">
                                <i class="fas fa-edit"></i> Editar
                            </a>
                            <a class="dropdown-item delete-btn" href="#" data-id="${row.ID}">
                                <i class="fas fa-trash-alt"></i> Eliminar
                            </a>
                        </div>
                    </div>
                `;
            }
        }
    ],
    language: dataTableLanguage,
    initComplete: function() {
        // Aplicar filtro inicial para mostrar solo los lotes disponibles
        this.api().column(10).search('Disponible').draw();
    }
});

// Filtro de estado
$('#filtroEstado').on('change', function() {
    materiaPrimasTable.ajax.reload();
});

// Filtro de lotes disponibles/agotados
let mostrarAgotados = false;
$('#filtroLotes').on('click', function() {
    mostrarAgotados = !mostrarAgotados;
    const textoBoton = mostrarAgotados ? 'Mostrar Lotes Disponibles' : 'Mostrar Lotes Agotados';
    $(this).text(textoBoton);

    // Aplicar filtro
    materiaPrimasTable.column(10).search(mostrarAgotados ? 'Agotado' : 'Disponible').draw();
});

    // Función genérica para actualizar los valores
    function updateQuantity(amount, inputId, step) {
        const inputField = document.getElementById(inputId);
        if (!inputField) return;

        const minValue = parseFloat(inputField.getAttribute('min')) || 0;
        const currentValue = parseFloat(inputField.value) || minValue;

        // Calcula el nuevo valor
        const newValue = Math.max(currentValue + (amount * step), minValue);
        inputField.value = newValue.toFixed(2);

        // Dispara el evento de entrada para actualizaciones dinámicas
        inputField.dispatchEvent(new Event('input'));
    }

    // Incremento y decremento de valores
    $(".btn-minus, .btn-plus").on("click", function () {
        const inputId = $(this).siblings("input").attr("id");
        const step = 0.50;
        const amount = $(this).hasClass("btn-plus") ? 1 : -1;
        updateQuantity(amount, inputId, step);
    });

    // Calcular Precio Unitario dinámicamente
    $('#cantidad_ingresada, #precio_total').on('input', function () {
        const cantidad = parseFloat($('#cantidad_ingresada').val()) || 1; // Evitar división por 0
        const precioTotal = parseFloat($('#precio_total').val()) || 0;
        const precioUnitario = precioTotal / cantidad;
        $('#precio_unitario').val(precioUnitario.toFixed(2));
    });

    // Abrir el modal y manejar lógica de nuevo registro
    $('button[data-is-new="true"]').on('click', function () {
        const isNew = $(this).data('is-new'); // Indicar que es un nuevo registro

        if (isNew) {
            // Limpiar el formulario y solicitar un nuevo lote
            $('#materiaPrimaForm')[0].reset(); 
            $('#numero_lote').val(''); // Limpia el campo lote

            // Solicitar el nuevo número de lote al backend
            $.ajax({
                url: "../AJAX/ctrInvFrutas.php",
                type: 'POST',
                data: { action: 'generarNumeroLote' },
                dataType: 'json',
                success: function (response) {
                    if (response.status === 'success') {
                        $('#numero_lote').val(response.numero_lote); // Llenar con el nuevo lote
                    } else {
                        Swal.fire('Error', response.message || 'Error al generar el número de lote', 'error');
                    }
                },
                error: function () {
                    Swal.fire('Error', 'Error al comunicarse con el servidor', 'error');
                }
            });
        }

        // Cambiar el texto del botón para diferenciar acciones
        $('.form-actions .btn-primary').text('Guardar').data('isEditing', false);
        $('#Form_MP').data('isEditing', false);

        // Mostrar el modal
        $('#Form_MP').modal('show');
    });

    // Cargar datos al hacer clic en el botón Editar
    $('#tablaMateriaPrimas').on('click', '.edit-btn', function () {
        const id_inv = $(this).data('id');

        $.ajax({
            url: "../AJAX/ctrInvFrutas.php",
            type: 'POST',
            data: { action: 'obtenerMateriaPrima', id_inv: id_inv },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    const data = response.data;

                    // Llenar el formulario con los datos del registro
                    $('#materiaPrimaForm').find('#id_inv').val(data.id_inv);
                    $('#materiaPrimaForm').find('#cat_id').val(data.id_articulo);
                    $('#materiaPrimaForm').find('#proveedor_id').val(data.proveedor_id);
                    $('#materiaPrimaForm').find('#numero_lote').val(data.numero_lote).prop('readonly', true); // Lote sin cambios
                    $('#materiaPrimaForm').find('#cantidad_ingresada').val(data.cantidad_ingresada);
                    $('#materiaPrimaForm').find('#precio_total').val(data.precio_total); // Cambiado a precio_total
                    $('#materiaPrimaForm').find('#brix').val(data.brix);
                    $('#materiaPrimaForm').find('#observacion').val(data.observacion);

                    // Calcular el precio unitario
                    const cantidad = parseFloat(data.cantidad_ingresada) || 1; // Evitar división por 0
                    const precioTotal = parseFloat(data.precio_total) || 0;
                    const precioUnitario = precioTotal / cantidad;
                    $('#materiaPrimaForm').find('#precio_unitario').val(precioUnitario.toFixed(2));

                    // Cambiar texto del botón para editar
                    $('.form-actions .btn-primary').text('Guardar cambios').data('isEditing', true);
                    $('#Form_MP').data('isEditing', true);

                    // Mostrar el modal
                    $('#Form_MP').modal('show');
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'Ocurrió un error al obtener los datos.', 'error');
            }
        });
    });

    // Enviar el formulario para agregar o actualizar la materia prima con confirmación
    $('.form-actions .btn-primary').on('click', function (event) {
        event.preventDefault();

        const isEditing = $('#Form_MP').data('isEditing');
        const action = isEditing ? 'actualizarMateriaPrima' : 'guardarMateriaPrima';

        // Validar campos obligatorios
        const requiredFields = ['#cat_id', '#proveedor_id', '#numero_lote', '#cantidad_ingresada', '#precio_total', '#precio_unitario', '#brix'];
        let valid = true;
        requiredFields.forEach(function(field) {
            if (!$(field).val()) {
                valid = false;
                $(field).addClass('is-invalid');
            } else {
                $(field).removeClass('is-invalid');
            }
        });

        if (!valid) {
            Swal.fire('Error', 'Por favor, complete todos los campos obligatorios.', 'error');
            return;
        }

        Swal.fire({
            title: '¿Estás seguro?',
            text: isEditing ? "¿Deseas guardar los cambios?" : "¿Deseas agregar este registro?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, guardar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                const formData = $('#materiaPrimaForm').serialize() + `&action=${action}`;
                console.log(formData);  // Verifica los datos que se están enviando

                $.ajax({
                    url: '../AJAX/ctrInvFrutas.php',
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        console.log(response);
                        if (response && response.status === 'success') {
                            Swal.fire(
                                'Éxito',
                                isEditing ? 'Registro actualizado correctamente' : 'Registro agregado correctamente',
                                'success'
                            ).then(() => {
                                $('#Form_MP').modal('hide');
                                materiaPrimasTable.ajax.reload();
                            });
                        } else {
                            Swal.fire('Error', response.message || 'Ocurrió un error inesperado.', 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire('Error', 'Error de comunicación con el servidor', 'error');
                        console.error("Error: ", error);
                        console.error("Response: ", xhr.responseText);
                    }
                });
            }
        });
    });

    // Al hacer clic en el botón Eliminar con confirmación
    $('#tablaMateriaPrimas').on('click', '.delete-btn', function() {
        const id_inv = $(this).data('id'); // Cambiado a id_inv
        Swal.fire({
            title: '¿Estás seguro de que deseas eliminar este registro?',
            text: "Esta acción no se puede deshacer.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '../AJAX/ctrInvFrutas.php',
                    type: 'POST',
                    data: { action: 'eliminarMateriaPrima', id_inv: id_inv }, // Cambiado a id_inv
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            Swal.fire(
                                'Eliminado!',
                                'El registro ha sido eliminado.',
                                'success'
                            );
                            materiaPrimasTable.ajax.reload();
                        } else {
                            Swal.fire('Error', response.message, 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire('Error', 'Ocurrió un error al eliminar el registro.', 'error');
                        console.error("Error: ", error);
                        console.error("Response: ", xhr.responseText);
                    }
                });
            }
        });
    });
});