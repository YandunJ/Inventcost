<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Usuarios</title>
    <link rel="stylesheet" href="../FILES/global.css">
    
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
        <?php include 'MODULOS/BarraHorizontal.php';?>
        <!-- Main Sidebar Container -->
        <?php
        if ($_SESSION['rol_id'] == 1) {
            include 'MODULOS/PanelAdmin.php';
        } elseif ($_SESSION['rol_id'] == 2) {
            include 'MODULOS/PanelInventario.php';
        } elseif ($_SESSION['rol_id'] == 3) {
            include 'MODULOS/PanelProduccion.php';
        }
        ?>
        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Gestionar Usuarios</h1>
                    <div class="text-right mb-3">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#modalRegistroUsuario">
                        <i class="fas fa-plus"></i> Agregar Usuario
                        </button>
                    </div>
                    <table id="tablaUsuarios" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>Cédula</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Usuario</th>
                                <th>Rol</th>
                                <th>Correo</th>
                                <th>Teléfono</th>
                                
                                
                                <th>Estado</th>
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

        <!-- Modal para registrar/actualizar usuarios -->
        <div class="modal fade" id="modalRegistroUsuario" tabindex="-1" role="dialog" aria-labelledby="modalRegistroUsuarioLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalRegistroUsuarioLabel">Registrar Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="form-registro-usuario" method="post">
                            <input type="hidden" id="usu_id" name="usu_id" value="">
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="cedula">Cédula</label>
                                    <input type="text" class="form-control" id="cedula" name="cedula" placeholder="Ej. 1050478237" maxlength="13" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="nombre">Nombre</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ej. Juan" maxlength="50" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="apellido">Apellido</label>
                                    <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Ej. Pérez" maxlength="50" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="correo">Correo Electrónico</label>
                                    <input type="email" class="form-control" id="correo" name="correo" placeholder="Ej. juan.perez@example.com" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="telefono">Teléfono</label>
                                    <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Ej. 809-123-4567" maxlength="10" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="rol">Rol</label>
                                    <select class="form-control" id="rol" name="rol_id" required>
                                        <option value="">Seleccione un rol</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <label for="usuario">Nombre de Usuario</label>
                                    <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Ej. jperez" maxlength="30" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <label for="contrasenia">Contraseña</label>
                                    <input type="password" class="form-control" id="contrasenia" name="contrasenia" placeholder="Contraseña">
                                    <small class="form-text text-muted">
                                        La contraseña debe contener al menos 3 mayúsculas, 3 minúsculas, 3 números y 1 carácter especial.
                                    </small>
                                </div>
                            </div>
                            <div class="text-center">
                                <button type="submit" id="btn-registro" class="btn btn-primary">Guardar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Footer -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                Custom footer text
            </div>
            <strong>&copy; 2024 <a href="https://adminlte.io">FranFruit.io</a>. Derechos Reservados.</strong>
        </footer>
    </div>
    <!-- ./wrapper -->
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <script src="JS/usu.js"></script> 
    <script src="JS/DTesp.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>