
    
   // Configuración general para DataTables en español
const dataTableLanguage = {
    lengthMenu: "Ver _MENU_ registros",
    zeroRecords: "No se encontraron resultados",
    info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
    infoEmpty: "No hay registros disponibles",
    infoFiltered: "(filtrado de _MAX_ registros totales)",
    search: "Buscar:",
    paginate: {
        first: "Primero",
        last: "Último",
        next: "Siguiente",
        previous: "Anterior"
    },
    loadingRecords: "Cargando...",
    processing: "Procesando..."
};

$(document).ready(function () {
    const dtInstance = $('#tablaMateriaPrimas').DataTable();

    // Detectar cambios en el estado del panel lateral
    $('.sidebar-mini').on('collapsed.lte.pushmenu expanded.lte.pushmenu', function () {
        setTimeout(() => {
            dtInstance.columns.adjust().draw(); // Ajustar columnas
        }, 300); // Tiempo de espera para asegurar la animación
    });
});




