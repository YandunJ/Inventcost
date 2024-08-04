<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario de Insumos</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
         <!-- Navbar -->
         <?php include 'MODULOS/ModuloAdminNavbar.php';?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/ModuloAdminSidebar.php';?>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1>Inventario de Insumos</h1>
                    <form id="inventarioForm">
                        <div class="form-group">
                            <label for="insumo_id">ID del Insumo:</label>
                            <input type="number" id="insumo_id" name="insumo_id" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="proveedor_id">ID del Proveedor:</label>
                            <input type="number" id="proveedor_id" name="proveedor_id" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="fecha_hora_ing">Fecha y Hora de Ingreso:</label>
                            <input type="datetime-local" id="fecha_hora_ing" name="fecha_hora_ing" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="cantidad">Cantidad:</label>
                            <input type="number" id="cantidad" name="cantidad" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="precio_unitario">Precio Unitario:</label>
                            <input type="number" id="precio_unitario" name="precio_unitario" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="precio_total">Precio Total:</label>
                            <input type="number" id="precio_total" name="precio_total" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Agregar al Inventario</button>
                    </form>
                </div>
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
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/Inveninsumos.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>
 