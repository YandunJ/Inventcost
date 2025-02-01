// $(document).ready(function () {
//     // ============================
//     // PESTAÑA MANO DE OBRA
//     // ===========================
//     const columnasMO = [
//         { data: 'cat_id'}, // ID oculto
//         { data: 'cat_nombre' },
//         {
//             data: null,
//             render: function () {
//                 return `
//                 <div class="input-group">
//                     <div class="input-group-prepend">
//                         <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
//                     </div>
//                     <input type="number" class="form-control cantidad-personas" min="0" value="0">
//                     <div class="input-group-append">
//                         <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
//                     </div>
//                 </div>`;
//             }
//         },
//         {
//             data: null,
//             render: function () {
//                 return `
//                 <div class="input-group">
//                     <div class="input-group-prepend">
//                         <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
//                     </div>
//                     <input type="number" class="form-control precio-ht" min="0" step="0.01" value="0">
//                     <div class="input-group-append">
//                         <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
//                     </div>
//                 </div>`;
//             }
//         },
//         {
//             data: null,
//             render: function () {
//                 return `
//                 <div class="input-group">
//                     <div class="input-group-prepend">
//                         <button type="button" class="btn btn-outline-secondary btn-sm decrementar">-</button>
//                     </div>
//                     <input type="number" class="form-control horas-por-dia" min="0" value="0">
//                     <div class="input-group-append">
//                         <button type="button" class="btn btn-outline-secondary btn-sm incrementar">+</button>
//                     </div>
//                 </div>`;
//             }
//         },
//         {
//             data: null,
//             render: function () {
//                 return `<span class="horas-trabajador">0</span>`;
//             }
//         },
//         {
//             data: null,
//             render: function () {
//                 return `<span class="costo-dia">$0.00</span>`;
//             }
//         }
//     ];

//     const tablaManoObra = inicializarDataTable('#tablaManoObra', '../AJAX/ctrCost.php', { action: 'obtenerCostos', opcion: 1 }, columnasMO, item => item.categoria === 'Mano de Obra' && item.cat_estado === 'habilitado');

//     // Función para recalcular el total de mano de obra
//     function recalcularTotalManoObra() {
//         let total = 0;
//         $('#tablaManoObra tbody tr').each(function () {
//             const costoTotal = parseFloat($(this).find('.costo-dia').text().replace('$', '')) || 0;
//             total += costoTotal;
//         });
//         $('#totalManoObra').text(`$${total.toFixed(2)}`);
//         $('#subtotalMO').val(total.toFixed(2));
//         recalcularCostoTotalProduccion();
//     }

//     $('#tablaManoObra').on('input', '.cantidad-personas, .horas-por-dia, .precio-ht', function () {
//         const row = $(this).closest('tr');
//         const cantidadPersonas = parseFloat(row.find('.cantidad-personas').val()) || 0;
//         const precioHT = parseFloat(row.find('.precio-ht').val()) || 0;
//         const horasPorDia = parseFloat(row.find('.horas-por-dia').val()) || 0;

//         const horasTrabajador = cantidadPersonas * horasPorDia;
//         const costoDia = horasTrabajador * precioHT;

//         row.find('.horas-trabajador').text(horasTrabajador);
//         row.find('.costo-dia').text(`$${costoDia.toFixed(2)}`);

//         recalcularTotalManoObra();
//     });

//     // Función para obtener los datos de mano de obra
//     function getDatosManoObra() {
//         let manoObra = [];
//         $('#tablaManoObra tbody tr').each(function () {
//             const cat_id = $(this).find('td:eq(0)').text(); // Obtener el ID de la actividad
//             const mo_cant_personas = parseFloat($(this).find('.cantidad-personas').val()) || 0;
//             const mo_horas_trabajadas = parseFloat($(this).find('.horas-por-dia').val()) || 0;
//             const mo_precio_hora = parseFloat($(this).find('.precio-ht').val()) || 0;
//             manoObra.push({
//                 cat_id: cat_id,
//                 mo_cant_personas: mo_cant_personas,
//                 mo_horas_trabajadas: mo_horas_trabajadas,
//                 mo_precio_hora: mo_precio_hora
//             });
//         });
//         return manoObra;
//     }

//     // Exponer la función getDatosManoObra para que pueda ser utilizada desde otros archivos
//     window.getDatosManoObra = getDatosManoObra;
// });