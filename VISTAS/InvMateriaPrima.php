<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Materia Prima</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
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
                    <h1>Gestión de Materia Prima</h1>
                    <form id="materiaPrimaForm">
                        <div class="form-group">
                            <label for="fruta_id">Fruta:</label>
                            <select id="fruta_id" name="fruta_id" class="form-control" required>
                                <!-- Options will be populated dynamically from the backend -->
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="fecha_cad">Fecha Limite de Producción:</label>
                            <input type="date" id="fecha_cad" name="fecha_cad" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="proveedor_id">Proveedor:</label>
                            <select id="proveedor_id" name="proveedor_id" class="form-control" required>
                                <!-- Options will be populated dynamically from the backend -->
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="cantidad">Cantidad:</label>
                            <input type="number" step="0.01" id="cantidad" name="cantidad" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="precio_unit">Precio Unitario:</label>
                            <input type="number" step="0.01" id="precio_unit" name="precio_unit" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="precio_total">Precio Total:</label>
                            <input type="number" step="0.01" id="precio_total" name="precio_total" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="birx">Brix:</label>
                            <input type="number" step="0.01" id="birx" name="birx" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="estado">Estado:</label>
                            <select id="estado" name="estado" class="form-control" required>
                                <option value="aprobado">Aprobado</option>
                                <option value="no_aprobado">No Aprobado</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="observaciones">Observaciones:</label>
                            <textarea id="observaciones" name="observaciones" class="form-control" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Agregar Materia Prima</button>
                    </form>

                    <hr>

                    <table id="materiaPrimaTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Fruta</th>
                                <th>Fecha y Hora de Ingreso</th>
                                <th>Fecha de Caducidad</th>
                                <th>Proveedor</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Precio Total</th>
                                <th>Brix</th>
                                <th>Estado</th>
                                <th>Observaciones</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Rows will be populated dynamically from the backend -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
        <!-- /.content-wrapper -->

        <!-- Footer -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-block">
                <b>Version</b> 3.0.5
            </div>
            <strong>Copyright &copy; 2014-2019 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
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
    <script src="JS/InvenMateriaP.js"></script>
        <!-- Incluir el script de cierre de sesión -->
<script src="JS/cerrarsesion.js"></script>
<script src="JS/validsesion.js"></script>
</body>
</html>
 