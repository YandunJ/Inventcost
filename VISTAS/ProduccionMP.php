<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producción</title>
    <link rel="stylesheet" href="../FILES/global.css">

</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <?php include 'MODULOS/ModuloNavbar.php'; ?>
    <?php include 'MODULOS/MDAdminSidebar.php'; ?>

    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <h1>Producción</h4>
              <!-- Botón para abrir el modal -->
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#produccionModal">
                    Agregar Producción
                </button>
                <!-- Modal para el formulario de producción -->
                <div class="modal fade" id="produccionModal" tabindex="-1" role="dialog" aria-labelledby="produccionModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3>Registrar Producción</h3>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <!-- Aquí se moverá el contenido del formulario -->

                                
                      <!-- Contenido del formulario de producción -->
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <!-- Menú de Pestañas -->
                                        <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="materiaPrima-tab" data-toggle="tab" href="#materiaPrima" role="tab">Materia Prima</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="insumos-tab" data-toggle="tab" href="#insumos" role="tab">Insumos</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="manoObra-tab" data-toggle="tab" href="#manoObra" role="tab">Mano de Obra</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="costosAsociados-tab" data-toggle="tab" href="#costosAsociados" role="tab">Costos Indirectos</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="productoTerminado-tab" data-toggle="tab" href="#productoTerminado" role="tab">Producto Terminado</a>
                                            </li>
                                        </ul>
                                        <!-- Contenido de las Pestañas -->
                                        <div class="tab-content" id="myTabContent">
                                            <!-- Pestaña Materia Prima -->
                                            <div class="tab-pane fade show active" id="materiaPrima" role="tabpanel">
                                                <!-- <div class="alert alert-info alert-dismissible fade show" role="alert">
                                                    <strong>Estimado usuario:</strong> Seleccione el lote que va a consumir e ingrese la cantidad.
                                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div> -->
                                                <table class="table table-bordered table-hover table-compact" id="LotesMP">
                                                    <thead>
                                                        <tr>
                                                            <th>Lote</th>
                                                            <th>Proveedor</th>
                                                            <th>Fruta</th>
                                                            <th>Unid. Medida</th>
                                                            <th>Disponible</th>
                                                            <th>Precio U.</th>
                                                            <th>Cantidad a Consumir</th>
                                                            <th>Seleccionar</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                </table>
                                            </div>
                                            <!-- Pestaña Insumos -->
                                            <div class="tab-pane fade" id="insumos" role="tabpanel">
                                                <!-- <div class="alert alert-info alert-dismissible fade show" role="alert">
                                                    <strong>Estimado usuario:</strong> Seleccione los insumos necesarios e ingrese la cantidad.
                                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div> -->
                                                <table class="table table-bordered table-hover table-compact" id="LotesINS">
                                                    <thead>
                                                        <tr>
                                                            <th>Fecha</th>
                                                            <th>Proveedor</th>
                                                            <th>Insumo</th>
                                                            <th>Ud Medida</th>
                                                            <th>Disponible</th>
                                                            <th>Precio Unitario</th>
                                                            <th>Cantidad a Consumir</th>
                                                            <th>Seleccionar</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                </table>
                                            </div>
                                            <!-- Pestaña Mano de Obra -->
                                            <div class="tab-pane fade" id="manoObra" role="tabpanel">
                                                <!-- <div class="alert alert-info alert-dismissible fade show" role="alert">
                                                    <strong>Estimado usuario:</strong> Ingrese los detalles de la mano de obra requerida.
                                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div> -->
                                                <table class="table table-bordered table-hover table-compact" id="tablaManoObra">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Actividad</th>
                                                            <th>Cantidad Personas</th>
                                                            <th>Costo / Hora</th>
                                                            <th>Horas / Persona</th>
                                                            <th>Total Horas / Actividad</th>
                                                            <th>Costo Mano Obra / Actividad</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                    <tfoot>
                                                        <tr class="font-weight-bold">
                                                            <td colspan="6" class="text-right">TOTAL MANO DE OBRA:</td>
                                                            <td id="totalManoObra">$0.00</td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
                                            <!-- Pestaña Costos Indirectos -->
                                            <div class="tab-pane fade" id="costosAsociados" role="tabpanel">
                                                <!-- <div class="alert alert-info alert-dismissible fade show" role="alert">
                                                    <strong>Estimado usuario:</strong> Ingrese los costos indirectos asociados a la producción.
                                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div> -->
                                                <table class="table table-bordered table-hover table-compact" id="tablaCostosIndirectos">
                                                    <thead>
                                                        <tr>
                                                        <th>ID</th>
                                                            <th>Descripción</th>
                                                            <th>Unidad de Medida</th>
                                                            <th>Cantidad</th>
                                                            <th>Precio Unitario ($)</th>
                                                            <th>Costo Total ($)</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                    <tfoot>
                                                        <tr class="font-weight-bold">
                                                            <td colspan="3" class="text-right">TOTAL COSTOS INDIRECTOS:</td>
                                                            <td id="totalCostosIndirectos">$0.00</td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
   <!-- Pestaña Producto Terminado -->
<div class="tab-pane fade" id="productoTerminado" role="tabpanel">
    <!-- <div class="alert alert-info alert-dismissible fade show" role="alert">
        <strong>Estimado usuario:</strong> Ingrese los detalles del producto terminado.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div> -->
    <form id="formProductoTerminado">
        <div class="form-group row">
            <label for="loteProductoTerminado" class="col-sm-2 col-form-label">Lote</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="loteProductoTerminado" placeholder="Lote" readonly>
            </div>
        </div>
        <div class="form-group row">
            <label for="cantidadProducida" class="col-sm-2 col-form-label">Cantidad Producida (kg)</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" id="cantidadProducida" placeholder="Cantidad Producida" readonly>
            </div>
        </div>
        <div id="presentacionesContainer">
            <div class="form-group row">
                <label for="presentacionProducto" class="col-sm-2 col-form-label">Presentación</label>
                <div class="col-sm-4">
                    <select class="form-control presentacionProducto">
                        <option value="100">100 gr</option>
                        <option value="50">50 gr</option>
                    </select>
                </div>
                <label for="cantidadPresentacion" class="col-sm-2 col-form-label">Cantidad por Presentación</label>
                <div class="col-sm-4">
                    <input type="number" class="form-control cantidadPresentacion" placeholder="Cantidad por Presentación">
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-secondary" id="btnAgregarPresentacion">Agregar Presentación</button>
        <button type="button" class="btn btn-primary" id="btnCalcularPresentaciones">Calcular Presentaciones</button>
    </form>
    <div class="form-group row mt-3">
        <label for="totalPresentaciones" class="col-sm-2 col-form-label">Total Presentaciones</label>
        <div class="col-sm-10">
            <input type="number" class="form-control" id="totalPresentaciones" placeholder="Total Presentaciones" readonly>
        </div>
    </div>
</div>
                                            <div class="row mt-4">
                                                <div class="col-md-12">
                                                    <div class="card subtotales-container">
                                                        <div class="card-header bg-primary text-white">
                                                            <h5 class="card-title">Subtotales de Producción</h5>
                                                        </div>
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col-md-3">
                                                                    <label for="subtotalMP">Subtotal Materia Prima:</label>
                                                                    <input type="text" id="subtotalMP" class="form-control text-right font-weight-bold" value="0.00" readonly>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label for="subtotalINS">Subtotal Insumos:</label>
                                                                    <input type="text" id="subtotalINS" class="form-control text-right font-weight-bold" value="0.00" readonly>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label for="subtotalMO">Subtotal Mano de Obra:</label>
                                                                    <input type="text" id="subtotalMO" class="form-control text-right font-weight-bold" value="0.00" readonly>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <label for="subtotalCA">Subtotal Costos Indirectos:</label>
                                                                    <input type="text" id="subtotalCA" class="form-control text-right font-weight-bold" value="0.00" readonly>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3">
                                                                <div class="col-md-3 offset-md-9">
                                                                    <label for="totalProduccion">Costo Total de Producción:</label>
                                                                    <input type="text" id="totalProduccion" class="form-control text-right font-weight-bold text-success" value="0.00" readonly>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                <button type="button" class="btn btn-success" id="btnRegistrarProduccionModal">Registrar Producción</button>
                            </div>
                        </div>
                    </div>
                </div>


<!-- MODAL DETALLES -->
<div class="modal fade" id="detalleModal" tabindex="-1" role="dialog" aria-labelledby="detalleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalleModalLabel">Detalles del Lote</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <!-- Columna 1 -->
                        <div class="col-md-4">
                            <h6 class="section-title">Información General</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Fecha de Ingreso</strong></td>
                                        <td id="detalleFecha"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Hora de Ingreso</strong></td>
                                        <td id="detalleHora"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Número de Lote</strong></td>
                                        <td id="detalleLote"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Proveedor</strong></td>
                                        <td id="detalleProveedor"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- Columna 2 -->
                        <div class="col-md-4">
                            <h6 class="section-title">Detalles de Artículo</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Artículo</strong></td>
                                        <td id="detalleArticulo"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Cantidad Ingresada</strong></td>
                                        <td id="detalleCantidadIngresada"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Cantidad Disponible</strong></td>
                                        <td id="detalleCantidadRestante"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Unidad de Medida</strong></td>
                                        <td id="detalleUnidadMedida"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Presentación</strong></td>
                                        <td id="detallePresentacion"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- Columna 3 -->
                        <div class="col-md-4">
                            <h6 class="section-title">Precios</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Costo U.</strong></td>
                                        <td id="detallePrecioUnitario"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Costo Total</strong></td>
                                        <td id="detallePrecioTotal"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <h6 class="section-title">Información Adicional</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Estado</strong></td>
                                        <td id="detalleEstado"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Brix</strong></td>
                                        <td id="detalleBrix"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Peso Unitario</strong></td>
                                        <td id="detallePesoUnitario"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Bultos o Canastas</strong></td>
                                        <td id="detalleBultos"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <h6 class="section-title">Observaciones y Aprobación</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Observación</strong></td>
                                        <td id="detalleObservacion"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Aprobación del Lote</strong></td>
                                        <td id="detalleAprobacion"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
<!-- Scripts -->
<script src="../Public/plugins/jquery/jquery.min.js"></script>
<script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../Public/dist/js/adminlte.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<script src="JS/ProdMP.js"></script>
<script src="JS/validaciones.js"></script>
</body>
</html>
