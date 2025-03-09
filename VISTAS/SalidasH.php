<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial de Salidas</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="../FILES/STdespachoDET.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
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
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Historial de Despachos</h1>
                    <div id="tablaHistorialSalidas_wrapper">
                        <table id="tablaHistorialSalidas" class="table table-bordered table-hover table-compact">
                            <thead>
                                <tr>
                                    <th>Fecha de Despacho</th>
                                    <th>Estado</th>
                                    <th>Cantidad Total</th>
                                    <th>Precio Total</th>
                                    <th>Acciones</th>
                                    <th>Cancelar</th> <!-- Nueva columna para el botón de cancelar -->
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Datos cargados dinámicamente -->
                            </tbody>
                        </table>
                    </div>
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Modal para mostrar detalles de la salida -->
        <div class="modal fade" id="detalleSalidaModal" tabindex="-1" role="dialog" aria-labelledby="detalleSalidaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detalleSalidaModalLabel">Detalles del Despacho</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-12 text-right"> <!-- Ajustar a la derecha -->
                                    <p><strong>N° Comprobante:</strong> <span id="detalleNComprobante"></span></p>
                                    <p><strong>Fecha de Despacho:</strong> <span id="detalleFechaDespacho"></span></p>
                                </div>
                            </div>
                            <hr>
                            <h6>Detalles de los Productos:</h6>
                            <table class="table table-bordered table-custom">
                                <thead>
                                    <tr>
                                        <th>Lote</th>
                                        <th>Producto</th>
                                        <th>Composición</th>
                                        <th>Cantidad Despachada</th>
                                        <th>P.V.P</th>
                                    </tr>
                                </thead>
                                <tbody id="detalleProductos">
                                    <!-- Los detalles de los productos se llenarán aquí dinámicamente -->
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-md-12 text-right"> <!-- Ajustar a la derecha -->
                                    <p><strong>Cantidad Total:</strong> <span id="detalleCantidadTotal"></span></p>
                                    <p><strong>Total:</strong> <span id="detallePrecioTotal"></span> $</p>
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
        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>&copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>. Derechos Reservados.</strong>
        </footer>
    </div>

    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <script src="JS/SalidasH.js"></script>
    <script src="JS/DTesp.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>