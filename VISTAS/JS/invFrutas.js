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

        // Cuando el proveedor cambia, cargar las frutas correspondientes
        $('#proveedor_id').on('change', function() {
            var proveedor_id = $(this).val();
            
            if (proveedor_id) {
                $.ajax({
                    url: "../AJAX/ctrInvFrutas.php",
                    type: "POST",
                    data: { action: 'cargarFrutasPorProveedor', proveedor_id: proveedor_id },
                    dataType: "json",
                    success: function(response) {
                        if (response.status === 'success' && Array.isArray(response.data)) {
                            let options = '<option value="">Seleccione fruta</option>';
                            response.data.forEach(function(fruta) {
                                options += `<option value="${fruta.id_articulo}">${fruta.nombre_articulo}</option>`;
                            });
                            $("#id_articulo").html(options);
                        } else {
                            alert(response.message || "No se encontraron frutas para este proveedor.");
                            $("#id_articulo").html('<option value="">Seleccionar fruta</option>');
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("Ocurrió un error al cargar las frutas.");
                        console.error("Error: ", error);
                        console.error("Response: ", xhr.responseText);
                    }
                });
            } else {
                $("#id_articulo").html('<option value="">Seleccionar fruta</option>');
            }
        });


        
        document.addEventListener("DOMContentLoaded", function () {
            const today = new Date();
            const date = today.toISOString().split('T')[0];
            const time = today.toTimeString().split(' ')[0].slice(0, 5); // Solo horas y minutos

            document.getElementById("fecha").value = date;
            document.getElementById("hora").value = time;
        });
        $(document).ready(function () {
            // Función genérica para actualizar valores con formato
            function updateQuantity(amount, inputId, step) {
                const inputField = document.getElementById(inputId);
                if (!inputField) return;
        
                const minValue = parseFloat(inputField.getAttribute('min')) || 0;
                const currentValue = parseFloat(inputField.value) || minValue;
        
                // Calcula el nuevo valor
                const newValue = Math.max(currentValue + (amount * step), minValue);
        
                // Formatear con dos decimales
                inputField.value = newValue.toFixed(2);
            }
        
            // Botones para incremento y decremento
            $(".btn-minus.quantity-int, .btn-plus.quantity-int").on("click", function () {
                const inputId = $(this).siblings("input").attr("id");
                const step = 1; // Incrementos enteros
                const amount = $(this).hasClass("btn-plus") ? 1 : -1;
                updateQuantity(amount, inputId, step);
            });
        
            $(".btn-minus.quantity-decimal, .btn-plus.quantity-decimal").on("click", function () {
                const inputId = $(this).siblings("input").attr("id");
                const step = 0.01; // Incrementos decimales
                const amount = $(this).hasClass("btn-plus") ? 1 : -1;
                updateQuantity(amount, inputId, step);
            });
        });
        

  
/*
    $('#cantidad, #precio_unit').on('input', function() {
        const cantidad = parseFloat($('#cantidad').val()) || 0;
        const precioUnit = parseFloat($('#precio_unit').val()) || 0;
        const precioTotal = cantidad * precioUnit;
        $('#precio_total').val(precioTotal.toFixed(2));
    });
*/
// Inicializar DataTable
const materiaPrimasTable = $('#tablaMateriaPrimas').DataTable({
    ajax: {
        url: '../AJAX/ctrInvFrutas.php',
        type: 'POST',
        data: { action: 'cargarMateriaPrima' },
        dataSrc: function (json) {
            if (json.status === 'success') {
                return json.data;
            } else {
                Swal.fire('Error', json.message || 'Error al cargar los datos.', 'error');
                return [];
            }
        }
    },
    columns: [
        { data: 'Lote' },
        { data: 'Proveedor' },
        { data: 'Artículo' },
        { data: 'Cantidad_Disponible' },
        { data: 'Estado' },
        { data: 'Precio_Total' },
        {
            data: null,
            render: function (data, type, row) {
                return `
                    <div class="btn-group">
                        <button class="btn btn-secondary dropdown-toggle btn-sm" data-toggle="dropdown">
                            <i class="fas fa-cog"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item details-btn" href="#" data-id="${row.ID}">
                                <i class="fas fa-info-circle"></i> Detalles
                            </a>
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
    ]
});

    $('#tablaMateriaPrimas').on('click', '.details-btn', function() {
        const loteID = $(this).data('id');
        cargarDetallesLote(loteID);
    });
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
                    $('#detalleCantidadIngresada').text(response.data.Cantidad_Ingresada); // Nuevo
                    $('#detalleCantidadRestante').text(response.data.Cantidad_Restante);
                    $('#detalleUnidadMedida').text(response.data.Unidad_Medida); // Nuevo
                    $('#detallePresentacion').text(response.data.Presentación); // Nuevo
                    $('#detallePrecioUnitario').text(response.data.Precio_Unitario); // Nuevo
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
    
/*
document.getElementById('cantidad_ingresada').addEventListener('input', calcularPrecioTotal);
document.getElementById('precio_unitario').addEventListener('input', calcularPrecioTotal);

function calcularPrecioTotal() {
    const cantidad = parseFloat(document.getElementById('cantidad_ingresada').value) || 0;
    const precioUnitario = parseFloat(document.getElementById('precio_unitario').value) || 0;
    const precioTotal = cantidad * precioUnitario;
    document.getElementById('precio_total').value = precioTotal.toFixed(2);
}

  */  
    


    // Botón de estado "A" (Aprobar)
$('#tablaMateriaPrimas').on('click', '.approve-btn', function() {
    const mp_id = $(this).data('id');
    Swal.fire({
        title: '¿Estás seguro de aprobar esta materia prima?',
        text: "Esta acción se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, aprobar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            cambiarEstado(mp_id, 1); // 1 para "aprobado"
        }
    });
});
 // Botón de estado "X" (No Aprobar)
$('#tablaMateriaPrimas').on('click', '.reject-btn', function() {
    const mp_id = $(this).data('id');
    Swal.fire({
        title: '¿Estás seguro de no aprobar esta materia prima?',
        text: "Esta acción se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, no aprobar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            cambiarEstado(mp_id, 3); // 3 para "no_aprobado"
        }
    });
});
      // Al hacer clic en el botón de estado (Aprobar/No Aprobar)
      $('#tablaMateriaPrimas').on('click', '.status-btn',     function() {
        const mp_id = $(this).data('id');
        const estadoActual = $(this).text();
        const nuevoEstado = estadoActual === 'Aprobado' ? 'no_aprobado' : 'aprobado'; // Cambia el estado

        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php',
            type: 'POST',
            data: { action: 'cambiarEstadoMateriaPrima', mp_id: mp_id, estado: nuevoEstado },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Estado actualizado exitosamente.');
                    materiaPrimasTable.ajax.reload(); // Recargar la tabla
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert("Ocurrió un error al cambiar el estado.");
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
});



    function cambiarEstado(mp_id, estado) {
        $.ajax({
            url: '../AJAX/ctrInvenMateriaP.php',
            type: 'POST',
            data: { action: 'cambiarEstadoMateriaPrima', mp_id: mp_id, estado: estado },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    const actionType = $('#mp_id').val() ? 'actualizada' : 'registrada';
                    alert(`Materia prima ${actionType} exitosamente.`);
                    $('#materiaPrimaForm')[0].reset();
                    $('#mp_id').val(''); // Limpia el campo oculto
                    $('.btn-primary.btn-block').text('Agregar Materia Prima');
                    materiaPrimasTable.ajax.reload(null, false); // Recarga la tabla manteniendo la página actual
                } else {
                    alert('Error: ' + response.message);
                }
            },
            
            error: function(xhr, status, error) {
                alert("Ocurrió un error al cambiar el estado.");
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    }
    
 
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
                $('#materiaPrimaForm').find('#fecha').val(data.fecha);
                $('#materiaPrimaForm').find('#hora').val(data.hora);
                $('#materiaPrimaForm').find('#id_articulo').val(data.id_articulo);
                $('#materiaPrimaForm').find('#proveedor_id').val(data.proveedor_id);
                $('#materiaPrimaForm').find('#numero_lote').val(data.numero_lote).prop('readonly', true); // Lote sin cambios
                $('#materiaPrimaForm').find('#cantidad_ingresada').val(data.cantidad_ingresada);
                $('#materiaPrimaForm').find('#precio_unitario').val(data.precio_unitario);
                $('#materiaPrimaForm').find('#brix').val(data.brix);
                $('#materiaPrimaForm').find('#presentacion').val(data.presentacion);
                $('#materiaPrimaForm').find('#bultos_o_canastas').val(data.bultos_o_canastas);
                $('#materiaPrimaForm').find('#peso_unitario').val(data.peso_unitario);
                $('#materiaPrimaForm').find('#observacion').val(data.observacion);

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


// Enviar el formulario para agregar o actualizar la materia prima
$('.form-actions .btn-primary').on('click', function (event) {
    event.preventDefault();

    const $form = $('#materiaPrimaForm');
    const isEditing = $('#Form_MP').data('isEditing');
    const action = isEditing ? 'actualizarMateriaPrima' : 'guardarMateriaPrima';

    // No tocar el número de lote en edición
    if (isEditing) {
        $('#numero_lote').prop('readonly', false); // Permite enviarlo al backend
    }

    $.ajax({
        url: '../AJAX/ctrInvFrutas.php',
        type: 'POST',
        data: $form.serialize() + `&action=${action}`,
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                Swal.fire(
                    'Éxito',
                    isEditing ? 'Registro actualizado correctamente' : 'Registro agregado correctamente',
                    'success'
                ).then(() => {
                    $('#Form_MP').modal('hide');
                    materiaPrimasTable.ajax.reload();
                });
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'Ocurrió un error al guardar los datos.', 'error');
        }
    });
});


// Al hacer clic en el botón Eliminar
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

    
        // let formModified = false;

        // // Detectar cambios en el formulario
        // $("#materiaPrimaForm input, #materiaPrimaFormselect").on("input change", function() {
        //     formModified = true;
        // });
        
        // // Evento beforeunload para detectar si se intenta cerrar o recargar la página
        // window.addEventListener("beforeunload", function(e) {
        //     if (formModified) {
        //         const confirmationMessage = "Tienes datos sin guardar. ¿Estás seguro de que deseas salir?";
        //         e.returnValue = confirmationMessage; // Establece el mensaje
        //         return confirmationMessage;
        //     }
        // });
        
        // Capturar clics en el menú lateral
        // $("a").on("click", function(e) {
        //     if (formModified) {
        //         e.preventDefault(); // Prevenir la navegación
        //         Swal.fire({
        //             title: "Tienes datos sin guardar",
        //             text: "¿Estás seguro de que deseas salir sin guardar?",
        //             icon: "warning",
        //             showCancelButton: true,
        //             confirmButtonText: "Sí, salir",
        //             cancelButtonText: "Cancelar"
        //         }).then((result) => {
        //             if (result.isConfirmed) {
        //                 window.location.href = $(this).attr("href"); // Redirigir si confirma
        //             }
        //         });
        //     }
        // });
        
        // El botón de cancelar regresa a la página anterior
       // El botón de cancelar regresa a la página anterior
            $("#cancelarBtn").on("click", function() {

            if (formModified) {
                Swal.fire({
                    title: "Tienes datos sin guardar",
                    text: "¿Estás seguro de que deseas salir sin guardar?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "Sí, salir",
                    cancelButtonText: "Cancelar"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.history.back(); // Regresa a la página anterior
                    }
                });
            } else {
                window.history.back(); // Regresa a la página anterior
            }
        });
        


});
