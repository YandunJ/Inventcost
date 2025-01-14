// === PDconfig.js ===
// Configuración genérica de DataTables
function configurarDataTable(selector, ajaxUrl, columnas, customRender) {
    return $(selector).DataTable({
        autoWidth: false,
        responsive: true,
        paging: true,
        searching: true,
        ajax: {
            url: ajaxUrl,
            type: 'POST',
            dataSrc: function (json) {
                return json.status === 'success' ? json.data : [];
            }
        },
        columns: columnas,
        language: dataTableLanguage,
        ...customRender // Configuración opcional específica
    });
}
