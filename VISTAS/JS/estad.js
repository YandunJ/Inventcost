$(document).ready(function() {
    let pieChart;

// Función de respuesta modificada
function handleAjaxResponse(response, elementId) {
    try {
        const result = JSON.parse(response);
        if (result.status === 'success') {
            $(elementId).text(result.data.cantidad || 0); // Nueva estructura
        } else {
            console.error('Error:', result.message);
        }
    } catch (e) {
        console.error('Error al parsear JSON:', e);
    }
}

// Nuevas solicitudes AJAX
const endpoints = [
    { action: 'obtenerLotesMP', element: '#cantidadLotesMP' },
    { action: 'obtenerLotesINS', element: '#cantidadLotesINS' },
    { action: 'obtenerLotesPT', element: '#cantidadLotesPT' },
    { action: 'obtenerLotesProximosVencer', element: '#cantidadLotesProximos' }
];

endpoints.forEach(endpoint => {
    $.ajax({
        url: '../AJAX/ctrEstadisticas.php',
        type: 'POST',
        data: { action: endpoint.action },
        success: (response) => handleAjaxResponse(response, endpoint.element),
        error: (xhr, status, error) => console.error(error)
    });
});
    // Obtener datos de entradas por categoría y renderizar gráfico de pastel
    function obtenerEntradasPorCategoria(mes, anio) {
        $.ajax({
            url: '../AJAX/ctrEstadisticas.php',
            type: 'POST',
            data: { action: 'obtenerEntradasPorCategoria', mes: mes, anio: anio },
            success: function(response) {
                try {
                    const result = JSON.parse(response);
                    if (result.status === 'success') {
                        const labels = result.data.map(item => item.ctg_nombre);
                        const data = result.data.map(item => item.cantidad);

                        const ctx = document.getElementById('myPieChart').getContext('2d');

                        // Destruir el gráfico existente si existe
                        if (pieChart) {
                            pieChart.destroy();
                        }

                        pieChart = new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: labels,
                                datasets: [{
                                    data: data,
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.2)',
                                        'rgba(54, 162, 235, 0.2)',
                                        'rgba(255, 206, 86, 0.2)',
                                        'rgba(75, 192, 192, 0.2)',
                                        'rgba(153, 102, 255, 0.2)',
                                        'rgba(255, 159, 64, 0.2)'
                                    ],
                                    borderColor: [
                                        'rgba(255, 99, 132, 1)',
                                        'rgba(54, 162, 235, 1)',
                                        'rgba(255, 206, 86, 1)',
                                        'rgba(75, 192, 192, 1)',
                                        'rgba(153, 102, 255, 1)',
                                        'rgba(255, 159, 64, 1)'
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {
                                        position: 'top',
                                    },
                                    tooltip: {
                                        callbacks: {
                                            label: function(tooltipItem) {
                                                return tooltipItem.label + ': ' + tooltipItem.raw;
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    } else {
                        console.error('Error:', result.message);
                    }
                } catch (e) {
                    console.error('Error al parsear JSON:', e);
                    console.error('Respuesta del servidor:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', error);
            }
        });
    }

    // Llamar a la función para obtener los datos de entradas por categoría para el mes actual
    const fechaActual = new Date();
    const mes = fechaActual.getMonth() + 1; // Los meses en JavaScript son 0-indexados
    const anio = fechaActual.getFullYear();
    obtenerEntradasPorCategoria(mes, anio);

    // Manejar el evento de clic en el botón de filtrar
    $('#filtrar').on('click', function() {
        const mes = $('#mes').val();
        const anio = $('#anio').val();
        obtenerEntradasPorCategoria(mes, anio);
    });
});