<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Proveedores</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
    <!-- REVISAR LOS ESTILOS QUE SOLO QUEDE LOS NECESARIOS Y EN CASO DE SER UTIL CENTRALIZAR UN ESTILO PARA DEJAR SOLO UNO PARA TODOS -->
    <link rel="stylesheet" href="../FILES/Table-Compact.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
        <?php include 'MODULOS/ModuloNavbar.php'; ?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/MDAdminSidebar.php'; ?>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                <h1 class="text-center">Registrar Proveedores</h1>
                <div class="form-container">
                <form id="proveedorForm">
                <input type="hidden" id="proveedor_id" name="proveedor_id">
                    <div class="form-group">
                        <label for="nombre_empresa">Nombre Empresa</label>
                        <input type="text" class="form-control" id="nombre_empresa" name="nombre_empresa" placeholder="Empresa XYZ" required maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="representante">Representante</label>
                        <input type="text" class="form-control" id="representante" name="representante" placeholder="Juan Pérez" required maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="direccion">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Av. Siempre Viva 742" required maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="correo">Correo</label>
                        <input type="email" class="form-control" id="correo" name="correo" placeholder="empresa@correo.com" required maxlength="40">
                    </div>
                   
                            <div class="form-group">
                                <label for="telefono">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono" required>
                            </div>
                    <button type="submit" class="btn btn-primary">Registrar Proveedor</button>
                    <button type="button" class="btn btn-secondary" id="cancelButton">Cancelar</button>
                </form>

                </div>

                <h2 class="text-center">Listado de Proveedores</h2>
                    <table id="proveedoresTable" class="table table-bordered table-hover table-compact">
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- jQuery -->
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <!-- DataTables -->
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/prov.js"></script> <!-- Ruta al archivo JS -->

    <script src="JS/cerrarsesion.js"></script>

</body>
</html>
