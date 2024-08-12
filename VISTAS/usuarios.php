<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Usuarios</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
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
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Registrar Usuarios</h1>
                    <div class="form-container">
                        <form id="form-registro-usuario" method="post">
                            <input type="hidden" id="usu_id" name="usu_id" value="">
                            <div class="form-group">
                                <label for="cedula">Cédula</label>
                                <input type="text" class="form-control" id="cedula" name="cedula" placeholder="Cédula" required>
                            </div>
                            <div class="form-group">
                                <label for="nombre">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre" required>
                            </div>
                            <div class="form-group">
                                <label for="apellido">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Apellido" required>
                            </div>
                            <div class="form-group">
                                <label for="telefono">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono" required>
                            </div>
                            <div class="form-group">
                                <label for="direccion">Dirección</label>
                                <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Dirección" required>
                            </div>
                            <div class="form-group">
                                <label for="correo">Correo electrónico</label>
                                <input type="email" class="form-control" id="correo" name="correo" placeholder="Correo electrónico" required>
                            </div>
                            <div class="form-group">
                                <label for="rol">Rol</label>
                                <select class="form-control" id="rol" name="rol_id" required>
                                    <option value="">Seleccione un rol</option>
                                </select>
                            </div>
                            <a href="roles.php" class="btn btn-primary btn-sm">Agregar un nuevo Rol</a>
                            <div class="form-group">
                                <label for="usuario">Nombre de Usuario</label>
                                <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Nombre de Usuario" required>
                            </div>
                            <div class="form-group">
                                <label for="contrasenia">Contraseña</label>
                                <input type="password" class="form-control" id="contrasenia" name="contrasenia" placeholder="Contraseña" required>
                                <small class="form-text text-muted">
                                    La contraseña debe contener al menos 3 mayúsculas, 3 minúsculas, 3 números y 1 carácter especial.
                                </small>
                            </div>
                            <button type="submit" class="btn btn-primary">Registrar Usuario</button>
                        </form>
                    </div>
                    <hr>
                    <table id="tablaUsuarios" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Cédula</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Teléfono</th>
                                <th>Correo</th>
                                <th>Dirección</th>
                                <th>Usuario</th>
                                <th>Rol</th>
                                <th>Fecha de Registro</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
    <!-- jQuery -->
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <!-- DataTables -->
    <script src="../Public/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../Public/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/usu.js"></script> <!-- Ruta al archivo JS -->
    <script src="JS/cerrarsesion.js"></script>
   
</body>
</html>
