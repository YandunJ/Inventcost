<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Rol</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
</head> 
<body>
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
                <h1>Agregar Rol</h1>
                <form id="roleForm">
                    <div class="form-group">
                        <label for="rol_nombre">Nombre del Rol:</label>
                        <input type="text" id="rol_nombre" name="rol_nombre" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="rol_descripcion">Descripción del Rol:</label>
                        <input type="text" id="rol_descripcion" name="rol_descripcion" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="rol_area_trabajo">Permisos en el Sistema:</label>
                        <select id="rol_area_trabajo" name="rol_area_trabajo" class="form-control" required></select>
                    </div>
                    <button type="submit" class="btn btn-primary">Agregar Rol</button>
                </form>

                <!-- DataTable para mostrar los roles -->
                <h2>Listado de Roles</h2>
                <table id="rolesTable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre del Rol</th>
                            <th>Descripción del Rol</th>
                            <th>Tipo Permiso</th>
                            <th>Fecha de Registro</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Los datos se llenarán mediante AJAX -->
                    </tbody>
                </table>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<!-- Custom JS -->
<script src="JS/roles.js"></script> <!-- Ruta al archivo JS -->
<!-- Incluir el script de cierre de sesión -->
<script src="JS/cerrarsesion.js"></script>
<script src="JS/validsesion.js"></script>
</body>
</html>
