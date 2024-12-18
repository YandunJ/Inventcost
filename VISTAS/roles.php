<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Roles</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <!-- Estilo común para formularios -->
    <link rel="stylesheet" href="../FILES/global-style.css">
    <link rel="stylesheet" href="../FILES/Table-Compact.css">
</head>
<body>
<div class="wrapper">
    <!-- Navbar -->
    <?php include 'MODULOS/ModuloNavbar.php'; ?>
    <!-- Sidebar -->
    <?php include 'MODULOS/MDAdminSidebar.php'; ?>
    <!-- Content Wrapper -->
    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <h1 class="text-center"> Roles De Usuario</h1>
                <div class="text-right mb-3">
                    <!-- Botón para abrir el modal -->
                    <button class="btn btn-primary" data-toggle="modal" data-target="#roleModal">Agregar</button>
                </div>
                <!-- Tabla de Roles -->
                <table id="rolesTable" class="table table-bordered table-hover table-compact">
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
                        <!-- Datos llenados mediante AJAX -->
                    </tbody>
                </table>
            </div>
        </section>
    </div>

    <!-- Modal para el formulario -->
    <div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="roleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="roleModalLabel">Agregar Rol</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="roleForm">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="rol_nombre">Nombre del Rol:</label>
                            <input type="text" id="rol_nombre" name="rol_nombre" class="form-control" required maxlength="25" placeholder="Ej. Supervisor">
                        </div>
                        <div class="form-group">
                            <label for="rol_descripcion">Descripción del Rol:</label>
                            <input type="text" id="rol_descripcion" name="rol_descripcion" class="form-control" required maxlength="50" placeholder="Ej. Acceso total al sistema">
                        </div>
                        <div class="form-group">
                            <label for="rol_area_trabajo">Permisos en el Sistema:</label>
                            <select id="rol_area_trabajo" name="rol_area_trabajo" class="form-control" required></select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../Public/plugins/jquery/jquery.min.js"></script>
<script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../Public/dist/js/adminlte.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="JS/roles.js"></script>
<script src="JS/validaciones.js"></script>
</body>
</html>
