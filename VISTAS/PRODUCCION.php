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
<?php include 'MODULOS/BarraHorizontal.php';?>
        <!-- Main Sidebar Container -->
        <?php
        if ($_SESSION['rol_id'] == 1) {
            include 'MODULOS/PanelAdmin.php';
        } elseif ($_SESSION['rol_id'] == 2) {
            include 'MODULOS/PanelInventario.php';
        } elseif ($_SESSION['rol_id'] == 3) {
            include 'MODULOS/PanelProduccion.php';
        }
        ?>

    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <h1>Producción</h1>
                <!-- Botón para abrir el modal -->
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalRegistrarProduccion">
                    Agregar Producción
                </button>
                <!-- Modal para el formulario de producción -->
                <div class="modal fade" id="modalRegistrarProduccion" tabindex="-1" role="dialog" aria-labelledby="produccionModalLabel" aria-hidden="true">
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
                                                <table class="table table-bordered table-hover table-compact" id="LotesINS">
                                                    <thead>
                                                        <tr>
                                                            <th>Lote</th>
                                                            <th>Proveedor</th>
                                                            <th>Insumo</th>
                                                            <th>Ud Medida</th>
                                                            <th>Disponible</th>
                                                            <th>Precio U.</th>
                                                            <th>Cantidad a Consumir</th>
                                                            <th>Seleccionar</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                </table>
                                            </div>
                                            <!-- Pestaña Mano de Obra -->
                                            <div class="tab-pane fade" id="manoObra" role="tabpanel">
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
                                                            <td colspan="5" class="text-right">TOTAL COSTOS INDIRECTOS:</td>
                                                            <td id="totalCostosIndirectos">$0.00</td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
                                            <!-- Pestaña Producto Terminado -->
                                            <div class="tab-pane fade" id="productoTerminado" role="tabpanel">
                                                <form id="formProductoTerminado">
                                                    <div class="form-group row">
                                                        <label for="loteProductoTerminado" class="col-sm-2 col-form-label">Lote</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" id="loteProductoTerminado" placeholder="Lote" readonly>
                                                        </div>
                                                    </div>
                                                    <div id="presentacionesContainer">
                                                        <div class="form-group row">
                                                            <label for="presentacionProducto" class="col-sm-2 col-form-label">Presentación</label>
                                                            <div class="col-sm-4">
                                                                <select class="form-control" id="presentacionProducto">
                                                                    <option value="">Seleccione una presentación</option>
                                                                </select>
                                                            </div>
                                                            <label for="cantidadPresentacion" class="col-sm-2 col-form-label">Cantidad</label>
                                                            <div class="col-sm-4">
                                                                <input type="number" class="form-control" id="cantidadPresentacion" placeholder="Cantidad">
                                                            </div>
                                                        </div>
                                                        <button type="button" class="btn btn-primary" id="btnAgregarPresentacion">Agregar Producto</button>
                                                    </div>
                                                    <div class="mt-4">
                                                        <table class="table table-bordered" id="tablaPresentaciones">
                                                            <thead>
                                                                <tr>
                                                                    <th>Presentación</th>
                                                                    <th>Cantidad</th>
                                                                    <th>Costo Unitario</th>
                                                                    <th>Costo Total</th>
                                                                    <th>Acciones</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody></tbody>
                                                        </table>
                                                    </div>
                                                    <div class="form-group row mt-3">
                                                        <label for="totalPresentaciones" class="col-sm-2 col-form-label">Total Pulpa Producida (gr)</label>
                                                        <div class="col-sm-10">
                                                            <input type="number" class="form-control" id="totalPresentaciones" readonly>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <!-- Sección de Subtotales -->
                                            <div class="row mt-4">
                                                <div class="col-md-12">
                                                    <div class="card subtotales-container">
                                                        <div class="card-header d-flex justify-content-between align-items-center">
                                                            <h5 class="card-title mb-0">Subtotales de Producción</h5>
                                                            <button type="button" class="btn btn-light btn-sm ml-auto" id="toggleSubtotales">
                                                                <i class="fas fa-chevron-down"></i>
                                                            </button>
                                                        </div>
                                                        <div class="card-body" id="subtotalesContent">
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
                                                        </div>
                                                        <div class="card-footer">
                                                            <div class="row">
                                                                <div class="col-md-3 offset-md-9">
                                                                    <label for="totalProduccion">COSTO TOTAL DE PRODUCCIÓN:</label>
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

                <!-- Tabla para mostrar las producciones registradas -->
                
                    <table id="tablaProducciones" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                            <th>ID</th>
                                <th>Fecha de Producción</th>
                                <th>Cantidad Producida (gramos)</th>
                                <th>Subt. Materia Prima</th>
                                <th>Subt. Insumos</th>
                                <th>Subt. Mano de Obra</th>
                                <th>Subt. Costos Indirectos</th>
                                <th>TOTAL</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                
            </div>
        </section>
    </div>
</div>
<!-- Modal para ver los detalles de una producción -->
<div class="modal fade modal-entradas" id="verProduccionModal" tabindex="-1" role="dialog" aria-labelledby="verProduccionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Detalles de Producción</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Menú de Pestañas -->
                <ul class="nav nav-tabs mb-3" id="detalleProduccionTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="costosAsociados-tab" data-toggle="tab" href="#costosAsociados" role="tab">Costos Asociados</a>
                    </li>
                </ul>
                <!-- Contenido de las Pestañas -->
                <div class="tab-content" id="detalleProduccionTabContent">
                    <!-- Pestaña Costos Asociados -->
                    <div class="tab-pane fade show active" id="costosAsociados" role="tabpanel">
                        <table class="table table-bordered table-hover table-compact" id="tablaCostosAsociados">
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
                            <tbody>
                                <!-- Datos ficticios para ilustrar -->
                                <tr>
                                    <td>12</td>
                                    <td>UNIDADES</td>
                                    <td>1.00</td>
                                    <td>2.00</td>
                                    <td>2.00</td>
                                </tr>
                                <tr>
                                    <td>13</td>
                                    <td>UNIDADES</td>
                                    <td>2.00</td>
                                    <td>1.00</td>
                                    <td>2.00</td>
                                </tr>
                            </tbody>
                        </table>
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

<script src="JS/PROD.js"></script>
<script src="JS/ProdPT.js"></script>
<script src="JS/ProdValid.js"></script>
<script src="JS/ProdCalculos.js"></script>
<script src="JS/ProdTable.js"></script>
<!-- <script src="JS/ProdMano.js"></script> -->
<script src="JS/DTesp.js"></script>
</body>
</html>