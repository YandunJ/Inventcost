$(document).ready(function() {
    // Cargar frutas y proveedores
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: "POST",
        data: { action: 'cargarFrutas' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione una fruta</option>';
                response.data.forEach(function(fruta) {
                    options += `<option value="${fruta.id_articulo}">${fruta.nombre_articulo}</option>`;
                });
                $("#id_articulo").html(options);
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
    
    $.ajax({
        url: "../AJAX/ctrInvFrutas.php",
        type: "POST",
        data: { action: 'cargarProveedores' },
        dataType: "json",
        success: function(response) {
            if (response.status === 'success' && Array.isArray(response.data)) {
                let options = '<option value="">Seleccione un proveedor</option>';
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

    
    document.addEventListener("DOMContentLoaded", function () {
        const today = new Date();
        const date = today.toISOString().split('T')[0];
        const time = today.toTimeString().split(' ')[0].slice(0, 5); // Solo horas y minutos

        document.getElementById("fecha").value = date;
        document.getElementById("hora").value = time;
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
            { data: 'ID' },
            { data: 'Fecha' },
            { data: 'Hora' },
            { data: 'Lote' },
            { data: 'Proveedor' },
            { data: 'Artículo' },
            { data: 'Cantidad_Disponible' },
            { data: 'Estado' },
            { data: 'Precio_Total' },
            {
                data: null,
                render: function(data, type, row) {
                    return `
                        <div class="btn-group">
                                  <button class="btn btn-info btn-sm details-btn" data-id="${row.ID}">
                                <i class="fas fa-info-circle"></i> Detalles
                            </button>
                            <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
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

    $('#materiaPrimaForm').on('submit', function(event) {
        event.preventDefault();
    
        const formData = $(this).serializeArray(); // Obtén los datos del formulario
        formData.push({ name: 'action', value: 'guardarMateriaPrima' });
    
        $.ajax({
            url: '../AJAX/ctrInvFrutas.php',
            type: "POST",
            data: formData,
            dataType: "json",
            success: function(response) {
                if (response.status === 'success') {
                    Swal.fire(
                        'Éxito!',
                        'Materia prima registrada exitosamente.',
                        'success'
                    );
                    $('#materiaPrimaForm')[0].reset();
                    $('#id_inv').val(''); // Limpiar el campo oculto de ID
                    $('.btn-primary').text('Agregar Materia Prima'); // Restablecer el texto del botón
                    materiaPrimasTable.ajax.reload(); // Recargar la tabla
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            error: function(xhr, status, error) {
                Swal.fire('Error', 'Ocurrió un error al procesar la solicitud.', 'error');
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    });
    


    // Cargar datos al hacer clic en el botón Editar
$('#tablaMateriaPrimas').on('click', '.edit-btn', function() {
    const id_inv = $(this).data('id');
    $.ajax({
        url: '../AJAX/ctrInvFrutas.php',
        type: 'POST',
        data: { action: 'obtenerMateriaPrima', id_inv: id_inv },
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                const data = response.data;
                $('#fecha').val(data.fecha);
                $('#hora').val(data.hora);
                $('#fruta_id').val(data.fruta_id);
                $('#proveedor_id').val(data.proveedor_id);
                $('#numero_lote').val(data.numero_lote);
                $('#cantidad_ingresada').val(data.cantidad_ingresada);
                $('#precio_unitario').val(data.precio_unitario);
                $('#precio_total').val(data.precio_total);
                $('#brix').val(data.brix);
                $('#presentacion').val(data.presentacion);
                $('#observacion').val(data.observacion);
                $('#id_inv').val(data.id_inv); // Establecer el id_inv para identificar el registro en la actualización
                $('.btn-primary').text('Actualizar Materia Prima'); // Cambiar el texto del botón
            } else {
                Swal.fire('Error', response.message, 'error');
            }
        },
        error: function(xhr, status, error) {
            Swal.fire('Error', 'Ocurrió un error al obtener los datos.', 'error');
            console.error("Error: ", error);
            console.error("Response: ", xhr.responseText);
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

    
        let formModified = false;

        // Detectar cambios en el formulario
        $("#materiaPrimaForm input, #materiaPrimaFormselect").on("input change", function() {
            formModified = true;
        });
        
        // Evento beforeunload para detectar si se intenta cerrar o recargar la página
        window.addEventListener("beforeunload", function(e) {
            if (formModified) {
                const confirmationMessage = "Tienes datos sin guardar. ¿Estás seguro de que deseas salir?";
                e.returnValue = confirmationMessage; // Establece el mensaje
                return confirmationMessage;
            }
        });
        
        // Capturar clics en el menú lateral
        $("a").on("click", function(e) {
            if (formModified) {
                e.preventDefault(); // Prevenir la navegación
                Swal.fire({
                    title: "Tienes datos sin guardar",
                    text: "¿Estás seguro de que deseas salir sin guardar?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "Sí, salir",
                    cancelButtonText: "Cancelar"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = $(this).attr("href"); // Redirigir si confirma
                    }
                });
            }
        });
        
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
