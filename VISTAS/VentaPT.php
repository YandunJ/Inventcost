<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Despacho de Producto Terminado</title>
    <link rel="stylesheet" href="../FILES/global.css">
    
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
                    <h1>Despacho de Producto Terminado</h1>
                    <div class="mb-3">
                        <button id="btnBuscarProducto" class="btn btn-primary" data-toggle="modal" data-target="#modalBuscarProducto">Buscar Producto</button>
                        <label class="ml-3">Método de Salida:</label>
                        <input type="checkbox" id="switchMetodoSalida" data-toggle="toggle" data-on="FIFO" data-off="LIFO" data-onstyle="success" data-offstyle="danger" checked>
                    </div>
                    <h2>Productos a Despachar</h2>
<table id="tablaDespacho" class="table table-bordered table-hover">
    <thead>
        <tr>
            <th>Presentación</th>
            <th>Lote</th>
            <th>Pulpa</th>
            <th>Cantidad</th>
            <th>P.V.S.</th>
            <th>Precio Total</th>   
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <!-- Productos a despachar -->
    </tbody>
</table>
<div class="text-right">
    <strong>Precio Total de la Salida: $<span id="precioTotalSalida">0.00</span></strong>
</div>
<button id="btnRegistrarSalida" class="btn btn-primary">Registrar Salida</button>
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Modal para buscar productos -->
        <div class="modal fade" id="modalBuscarProducto" tabindex="-1" role="dialog" aria-labelledby="modalBuscarProductoLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalBuscarProductoLabel">Buscar Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="tablaProductos" class="table table-bordered table-hover mt-3">
                            <thead>
                                <tr>
                                    <th>Presentación</th>
                                    <th>Lote</th>
                                    <th>Pulpa</th>
                                    <th>Costo Unitario</th>
                                    <th>Precio de Venta Sugerido</th>
                                    <th>Disponible</th>
                                    <th>Cantidad a Consumir</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Datos cargados dinámicamente -->
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" id="btnAgregarSeleccionados" class="btn btn-primary">Agregar Seleccionados</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Footer -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>&copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>. Derechos Reservados.</strong>
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="JS/DTesp.js"></script> <!-- Incluir el archivo de configuración de DataTables en español -->
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
    <!-- Custom JS -->
    <script src="JS/VentaPT.js"></script>
</body>
</html>