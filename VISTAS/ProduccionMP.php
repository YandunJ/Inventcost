<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producción de Materia Prima</title>
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
        <!-- Content Wrapper -->
        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1>Producción de Materia Prima</h1>
                    <form id="produccionMateriaPrimaForm">
                        <div class="form-group">
                            <label for="fecha_produccion">Fecha de Producción:</label>
                            <input type="datetime-local" id="fecha_produccion" name="fecha_produccion" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="mp_id">Materia Prima:</label>
                            <select id="mp_id" name="mp_id" class="form-control" required>
                                <!-- Options will be populated dynamically from the backend -->
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="cantidad_utilizada">Cantidad Utilizada:</label>
                            <input type="number" step="0.01" id="cantidad_utilizada" name="cantidad_utilizada" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="cantidad_obtenida">Cantidad Obtenida:</label>
                            <input type="number" step="0.01" id="cantidad_obtenida" name="cantidad_obtenida" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="costo_total">Costo Total:</label>
                            <input type="number" step="0.01" id="costo_total" name="costo_total" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="estado">Estado:</label>
                            <select id="estado" name="estado" class="form-control" required>
                                <option value="aprobado">Aprobado</option>
                                <option value="no_aprobado">No Aprobado</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Agregar Producción</button>
                    </form>
                    <hr>
                    <table id="produccionMateriaPrimaTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Fecha de Producción</th>
                                <th>Materia Prima</th>
                                <th>Cantidad Utilizada</th>
                                <th>Cantidad Obtenida</th>
                                <th>Costo Total</th>
                                <th>Estado</th>
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
        <!-- Footer -->
        <footer class="main-footer">
            <!-- Footer content here -->
        </footer>
    </div>
    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/produccionMateriaPrima.js"></script>

        <!-- Incluir el script de cierre de sesión -->
<script src="JS/cerrarsesion.js"></script>
<script src="JS/validsesion.js"></script>
</body>
</html>
