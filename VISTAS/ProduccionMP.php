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
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Lote</th>
                    <th>Proveedor</th>
                    <th>Artículo</th>
                    <th>Stock</th>
                    <th>Precio Total</th>
                    <th>Estado</th>
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
        <table class="table table-bordered" id="tablaSeleccionarINS">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Lote</th>
                    <th>Proveedor</th>
                    <th>Insumo</th>
                    <th>Unidad de Medida</th>
                    <th>Cantidad Ingresada</th>
                    <th>Cantidad Restante</th>
                    <th>Precio Unitario</th>
                    <th>Precio Total</th>
                    <th>Presentación</th>
                    <th>Estado</th>
                    <th>Detalles</th>
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



  <!-- Modal de Detalles -->
<div class="modal fade" id="detalleModal" tabindex="-1" role="dialog" aria-labelledby="detalleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalleModalLabel">Detalles del Lote</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
    <!-- Sección de Información General -->
    <div class="modal-section">
        <div class="modal-section-title">Información General</div>
        <p><strong>Fecha de Ingreso:</strong> <span id="detalleFecha"></span></p>
        <p><strong>Hora de Ingreso:</strong> <span id="detalleHora"></span></p>
        <p><strong>Número de Lote:</strong> <span id="detalleLote"></span></p>
        <p><strong>Proveedor:</strong> <span id="detalleProveedor"></span></p>
    </div>

    <!-- Sección de Detalles de Artículo -->
    <div class="modal-section">
        <div class="modal-section-title">Detalles de Artículo</div>
        <p><strong>Artículo:</strong> <span id="detalleArticulo"></span></p>
        <p><strong>Cantidad Ingresada:</strong> <span id="detalleCantidadIngresada"></span></p>
        <p><strong>Cantidad Disponible:</strong> <span id="detalleCantidadRestante"></span></p>
        <p><strong>Unidad de Medida:</strong> <span id="detalleUnidadMedida"></span></p>
        <p><strong>Presentación:</strong> <span id="detallePresentacion"></span></p>
    </div>

    <!-- Sección de Precios -->
    <div class="modal-section">
        <div class="modal-section-title">Precios</div>
        <p><strong>Precio Unitario:</strong> <span id="detallePrecioUnitario"></span></p>
        <p><strong>Precio Total:</strong> <span id="detallePrecioTotal"></span></p>
    </div>

    <!-- Sección de Información Adicional -->
    <div class="modal-section">
        <div class="modal-section-title">Información Adicional</div>
        <p><strong>Estado:</strong> <span id="detalleEstado"></span></p>
        <p><strong>Brix:</strong> <span id="detalleBrix"></span></p>
        <p><strong>Peso Unitario:</strong> <span id="detallePesoUnitario"></span></p>
        <p><strong>Bultos o Canastas:</strong> <span id="detalleBultos"></span></p>
    </div>

    <!-- Sección de Observaciones y Aprobación -->
    <div class="modal-section">
        <div class="modal-section-title">Observaciones y Aprobación</div>
        <p><strong>Observación:</strong> <span id="detalleObservacion"></span></p>
        <p><strong>Aprobación del Lote:</strong> <span id="detalleAprobacion"></span></p>
    </div>
</div>
 

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
                    </div>
                </div>

                <!-- Resumen de Consumo -->
                <div class="mt-4 p-3 border rounded bg-light">
                    <h4>Resumen de Consumo</h4>
                    <p>Total Producción: $<span id="totalProduccion">0.00</span></p>
                </div>

                <!-- Botón de Confirmación -->
                <button type="button" class="btn btn-primary mt-3" id="registrarProduccion">Registrar Producción</button>
            </div>
        </section>
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
