$(document).ready(function() {
    // Función para manejar la respuesta AJAX
    function handleAjaxResponse(response, elementId) {
        try {
            const result = JSON.parse(response);
            if (result.status === 'success') {
                $(elementId).text(result.data.cantidad_presentaciones || result.data.length || result.data.cantidad_proveedores || result.data.cantidad_mano_obra || result.data.cantidad_costos_indirectos);
            } else {
                console.error('Error:', result.message);
            }
        } catch (e) {
            console.error('Error al parsear JSON:', e);
            console.error('Respuesta del servidor:', response);
        }
    }

    // Obtener cantidad de frutas
    $.ajax({
        url: '../AJAX/ctrEstadisticas.php',
        type: 'POST',
        data: { action: 'obtenerCantidadFrutas' },
        success: function(response) {
            handleAjaxResponse(response, '#cantidadFrutas');
        },
        error: function(xhr, status, error) {
            console.error('Error en la solicitud AJAX:', error);
        }
    });

    // Obtener cantidad de proveedores
    $.ajax({
        url: '../AJAX/ctrEstadisticas.php',
        type: 'POST',
        data: { action: 'obtenerCantidadProveedores' },
        success: function(response) {
            handleAjaxResponse(response, '#cantidadProveedores');
        },
        error: function(xhr, status, error) {
            console.error('Error en la solicitud AJAX:', error);
        }
    });

    // Obtener cantidad de presentaciones
    $.ajax({
        url: '../AJAX/ctrEstadisticas.php',
        type: 'POST',
        data: { action: 'obtenerCantidadPresentaciones' },
        success: function(response) {
            handleAjaxResponse(response, '#cantidadPresentaciones');
        },
        error: function(xhr, status, error) {
            console.error('Error en la solicitud AJAX:', error);
        }
    });

    // Obtener cantidad de mano de obra
    $.ajax({
        url: '../AJAX/ctrEstadisticas.php',
        type: 'POST',
        data: { action: 'obtenerCantidadManoObra' },
        success: function(response) {
            handleAjaxResponse(response, '#cantidadManoObra');
        },
        error: function(xhr, status, error) {
            console.error('Error en la solicitud AJAX:', error);
        }
    });

    // Obtener cantidad de costos indirectos
    $.ajax({
        url: '../AJAX/ctrEstadisticas.php',
        type: 'POST',
        data: { action: 'obtenerCantidadCostosInd' },
        success: function(response) {
            handleAjaxResponse(response, '#cantidadCostosInd');
        },
        error: function(xhr, status, error) {
            console.error('Error en la solicitud AJAX:', error);
        }
    });
});