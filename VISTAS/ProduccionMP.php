<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producción de Materia Prima</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

    <link rel="stylesheet" href="../FILES/centrForm.css">
    <style>
.table td {
    text-align: center; /* Centra todo el contenido en las celdas */
}

.form-check-input {
    margin: 0; /* Elimina el margen para que no se desplace */
}
    </style>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

    <!-- Navbar -->
    <?php include 'MODULOS/ModuloNavbar.php';?>
    <!-- Main Sidebar Container -->
    <?php include 'MODULOS/MDAdminSidebar.php';?>
    <!-- Content Wrapper -->
    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <h1>Producción de Materia Prima</h1>

                <!-- Contenedor para Fecha de Producción y Selección de Lote -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="fecha_produccion">Fecha de Producción:</label>
                            <input type="datetime-local" id="fecha_produccion" name="fecha_produccion" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="lote">Seleccionar Lote:</label>
                            <select id="lote" name="lote" class="form-control">
                                <option value="Lote 1">Lote 1</option>
                                <option value="Lote 2">Lote 2</option>
                                <option value="Lote 3">Lote 3</option>
                                <option value="Lote 4">Lote 4</option>
                                <option value="Lote 5">Lote 5</option>
                            </select>
                        </div>
                    </div>
                </div>


<div class="section">
    <h2 onclick="toggleSection('inventorySelection')">Selección de Lotes de Inventario</h2>
    <div id="inventorySelection" class="section-content">
        <table class="table">
            <tr>
                <th>Seleccionar</th>
                <th>Lote</th>
                <th>Cantidad Restante</th>
                <th>Unidad</th>
            </tr>
            <!-- Datos de ejemplo -->
            <tr>
                <td><input type="checkbox"></td>
                <td>Lote 001</td>
                <td>50 kg</td>
                <td>kg</td>
            </tr>
        </table>
    </div>
</div>


            <!-- Contenedor para la tabla de selección de materia prima -->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="mp_id">Seleccionar Materia Prima del Inventario:</label>
                                    <table id="tablaSeleccionarMP" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Fecha Entrada</th>
                                                <th>Fruta</th>
                                                <th>Proveedor</th>
                                                <th>Stock</th>
                                                <th>Precio Unitario</th>
                                                
                                                <th>Cantidad a Consumir (kg)</th>
                                                <th>Seleccionar</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Los datos se llenarán automáticamente -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>


                <button type="submit" class="btn btn-primary">Agregar Producción</button>
            </div>
        </section>
    </div>
    <!-- Footer -->
    <footer class="main-footer">
        <!-- Footer content here -->
    </footer>
</div>
<!-- jQuery -->
<script src="../Public/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../Public/dist/js/adminlte.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<!-- Custom JS -->
<script src="JS/ProduccionMP.js"></script>

<!-- Incluir el script de cierre de sesión -->
<script src="JS/cerrarsesion.js"></script>

</body>
</html>
