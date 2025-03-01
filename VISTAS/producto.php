<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lotes de Producto Terminado</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
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
                    <table id="tablaLotesPT" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID Lote</th>
                                <th>Nombre del Producto</th>
                                <th>Cantidad Disponible</th>
                                <th>Precio Unitario</th>
                                <th>Precio Total</th>
                                <th>Fecha de Producción</th>
                                <th>Fecha de Caducidad</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Datos de los lotes de PT se cargarán aquí -->
                        </tbody>
                    </table>
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Main Footer -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                Custom footer text
            </div>
            <strong>Copyright &copy; 2024 <a href="https://adminlte.io">FranFruit.io</a>.</strong> Derechos Reservados.
        </footer>
    </div>
    <!-- ./wrapper -->

    <!-- jQuery -->
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/LotesPT.js"></script>
</body>
</html>