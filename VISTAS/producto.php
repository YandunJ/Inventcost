<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lotes Producto Terminado</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/rowreorder/1.2.8/css/rowReorder.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
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
                    <h1>Lotes de Producto Terminado</h1>
                    <div class="mb-3">
                        <select id="filtroTipo">
                            <option value="lotes">Lotes</option>
                            <option value="presentaciones">Presentaciones</option>
                        </select>
                        <select id="filtroEstado">
                            <option value="">Todos</option>
                            <option value="disponible">Disponible</option>
                            <option value="stock bajo">Stock bajo</option>
                            <option value="agotado">Agotado</option>
                        </select>
                        <input type="text" id="fechaInicio" placeholder="Desde">
                        <input type="text" id="fechaFin" placeholder="Hasta">
                        <button id="btnConsultar" class="btn btn-primary">Consultar</button>
                    </div>
                    <div id="tablaLotesPT_wrapper">
                        <table id="tablaLotesPT" class="table table-bordered table-hover">
                            <thead>
                                <tr id="columnasTabla">
                                    <!-- Columnas dinámicas -->
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Datos cargados dinámicamente -->
                            </tbody>
                        </table>
                    </div>
                    <div id="tablaPresentacionesPT_wrapper" style="display: none;">
                        <table id="tablaPresentacionesPT" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Presentación</th>
                                    <th>Cantidad Disponible</th>
                                    <th>Precio Unitario</th>
                                    <th>Precio Venta Sugerido</th>
                                    <th>Composición</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
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
    <script src="https://cdn.datatables.net/rowreorder/1.2.8/js/dataTables.rowReorder.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/invTerminado.js"></script>
</body>
</html>