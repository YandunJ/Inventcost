<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Proveedores</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
        <?php include 'MODULOS/ModuloAdminNavbar.php'; ?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/ModuloAdminSidebar.php'; ?>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1>Registrar Proveedores</h1>
                    <form id="proveedorForm">
                        <input type="hidden" id="proveedor_id" name="proveedor_id">
                        <div class="form-group">
                            <label for="nombre_empresa">Nombre Empresa</label>
                            <input type="text" class="form-control" id="nombre_empresa" name="nombre_empresa" placeholder="Nombre Empresa" required>
                        </div>
                        <div class="form-group">
                            <label for="representante">Representante</label>
                            <input type="text" class="form-control" id="representante" name="representante" placeholder="Representante" required>
                        </div>
                        <div class="form-group">
                            <label for="direccion">Dirección</label>
                            <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Dirección" required>
                        </div>
                        <div class="form-group">
                            <label for="correo">Correo</label>
                            <input type="email" class="form-control" id="correo" name="correo" placeholder="Correo" required>
                        </div>
                        <div class="form-group">
                            <label for="telefono">Teléfono</label>
                            <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Registrar Proveedor</button>
                       
                    </form>

                    <table id="proveedoresTable" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre Empresa</th>
                                <th>Representante</th>
                                <th>Dirección</th>
                                <th>Correo</th>
                                <th>Teléfono</th>
                                <th>Fecha Registro</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Los datos se llenarán dinámicamente con JavaScript -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- DataTables -->
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/prov.js"></script> <!-- Ruta al archivo JS -->

    <script src="JS/cerrarsesion.js"></script>
<script src="JS/validsesion.js"></script>
</body>
</html>
