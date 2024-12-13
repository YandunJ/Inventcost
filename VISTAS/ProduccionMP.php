<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producción</title>
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="../FILES/tableMP.css">
    <link rel="stylesheet" href="../FILES/InvMPModal.css">

    <style>
        .nav-tabs .nav-link.active {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <?php include 'MODULOS/ModuloNavbar.php'; ?>
    <?php include 'MODULOS/MDAdminSidebar.php'; ?>

    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <h1>Producción</h1>

                <!-- Datos Generales de Producción -->
                <div class="row">
                    <div class="col-md-4">
                        <label for="fecha_produccion">Fecha de Producción:</label>
                        <input type="datetime-local" id="fecha_produccion" class="form-control">
                    </div>
              
                    <div class="col-md-4">
                        <label for="cantidad_producida">Cantidad Producida:</label>
                        <input type="number" id="cantidad_producida" class="form-control">
                    </div>
                </div>

                <!-- Menú de Pestañas -->
                <ul class="nav nav-tabs mt-4" id="myTab" role="tablist">
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
                        <a class="nav-link" id="costosAsociados-tab" data-toggle="tab" href="#costosAsociados" role="tab">Costos Asociados</a>
                    </li>
                </ul>

                <!-- Contenido de las Pestañas -->
                <div class="tab-content mt-3" id="myTabContent">
    <!-- Pestaña Materia Prima -->
    <div class="tab-pane fade show active" id="materiaPrima" role="tabpanel">
        <h3>Seleccionar Materia Prima</h3>
        <table class="table table-bordered" id="tablaSeleccionarMP">
            <thead>
                <tr>
                <th>Lote</th>
                                    <th>Proveedor</th>
                                    <th>Artículo</th>
                                    <th>Unid. Medida</th>
                                    
                                    <th>Saldo Disp.</th>
                                    <th>Precio Unit.</th>
                                    <th>Precio Total</th>
                                    
                    <th>Detalles</th> <!-- Nueva columna -->
                    <th>Cantidad a Consumir</th>
                    <th>Seleccionar</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <!-- Pestaña Insumos -->
    <div class="tab-pane fade" id="insumos" role="tabpanel">
        <h3>Seleccionar Insumos</h3>
        <table class="table table-bordered table-hover table-compact" id="tablaSeleccionarINS">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Proveedor</th>
                            <th>Insumo</th>
                            
                            <th>Ud Medida</th>
                            <th>Cantidad</th>
                            <th>Stock</th>
                            <th>Precio Unitario</th>
                            <th>Precio Total</th>
                            <th>Presentación</th>
                            <th>Estado</th>
                    <th>Cantidad a Consumir</th>
                    <th>Seleccionar</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <!-- Pestaña Mano de Obra -->
    <div class="tab-pane fade" id="manoObra" role="tabpanel">
        <h3>Mano de Obra</h3>
        <!-- Contenido para Mano de Obra -->
    </div>

    <!-- Pestaña Costos Asociados -->
    <div class="tab-pane fade" id="costosAsociados" role="tabpanel">
        <h3>Costos Asociados</h3>
        <!-- Contenido para Costos Asociados -->
    </div>
</div>



<!-- MODAL DETALLES -->z
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
                                        <td><strong>Precio Unitario</strong></td>
                                        <td id="detallePrecioUnitario"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Precio Total</strong></td>
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
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="JS/ProduccionMP.js"></script>
</body>
</html>
