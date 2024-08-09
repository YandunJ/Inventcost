<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Producto Terminado</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
            <!-- Navbar -->
            <?php include 'MODULOS/ModuloNavbar.php';?>
   
        <?php include 'MODULOS/MDAdminSidebar.php';?>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <!-- Form content goes here -->
                    <h1>Registrar Producto Terminado</h1>
                    <form>
                        <div class="form-group">
                            <label for="nombre_producto">Nombre del Producto</label>
                            <input type="text" class="form-control" id="nombre_producto" placeholder="Nombre del Producto">
                        </div>
                        <div class="form-group">
                            <label for="cantidad_producida">Cantidad Producida</label>
                            <input type="number" class="form-control" id="cantidad_producida" placeholder="Cantidad Producida">
                        </div>
                        <div class="form-group">
                            <label for="unidad_medida">Unidad de Medida</label>
                            <input type="text" class="form-control" id="unidad_medida" placeholder="Unidad de Medida">
                        </div>
                        <div class="form-group">
                            <label for="fecha_produccion">Fecha de Producción</label>
                            <input type="date" class="form-control" id="fecha_produccion">
                        </div>
                        <div class="form-group">
                            <label for="fecha_caducidad">Fecha de Caducidad</label>
                            <input type="date" class="form-control" id="fecha_caducidad">
                        </div>
                        <button type="submit" class="btn btn-primary">Registrar</button>
                    </form>
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
    <script src="assets/js/custom.js"></script>

    <script src="JS/cerrarsesion.js"></script>
</body>
</html>
