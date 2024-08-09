<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario de Insumos</title>
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
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/MDAdminSidebar.php';?>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1>Inventario de Insumos</h1>
                    <div class="form-container"> <!-- Contenedor para centrar el formulario -->
                        <form id="inventinsumosForm">
                            <div class="form-group">
                                <label for="insumo_id">Insumo:</label>
                                <select id="insumo_id" name="insumo_id" class="form-control" required></select>
                                <a href="insumos.php" class="btn btn-primary btn-sm">Agregar Insumos</a>
                            </div>
                            <div class="form-group">
                                <label for="proveedor_id">Proveedor:</label>
                                <select id="proveedor_id" name="proveedor_id" class="form-control" required></select>
                                <a href="proveedores.php" class="btn btn-primary btn-sm">Agregar Proveedor</a>
                            </div>
                            <div class="form-group">
                                <label for="fecha_hora_ing">Fecha de Ingreso:</label>
                                <input type="date" id="fecha_hora_ing" name="fecha_hora_ing" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad:</label>
                                <input type="number" id="cantidad" name="cantidad" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="unidad_medida">Unidad de Medida:</label>
                                <select id="unidad_medida" name="unidad_medida" class="form-control" required>
                                    <option value="u">Unidades (u)</option>
                                    <option value="kg">Kilogramos (kg)</option>
                                    <option value="l">Litros (l)</option>
                                    <!-- Agrega más opciones según sea necesario -->
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="precio_unitario">Precio Unitario:</label>
                                <input type="number" id="precio_unitario" name="precio_unitario" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="precio_total">Precio Total:</label>
                                <input type="number" id="precio_total" name="precio_total" class="form-control" required readonly>
                            </div>
                            <button type="submit" class="btn btn-primary">Agregar al Inventario</button>
                        </form>
                    </div> <!-- Fin del contenedor del formulario -->

                    <hr>

                    <table id="inventarioTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Proveedor</th>
                                <th>Fecha de Ingreso</th>
                                <th>Cantidad</th>
                                <th>Unidad de Medida</th>
                                <th>Precio Unitario</th>
                                <th>Precio Total</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Rows will be populated dynamically from the backend -->
                        </tbody>
                    </table>
                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

    <!-- jQuery -->
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/cerrarsesion.js"></script>
    <script src="JS/validsesion.js"></script>
</body>
</html>
