<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Empleados</title>
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
    <?php include 'MODULOS/BarraHorizontal.php';?>
    <!-- Main Sidebar Container -->
    <?php include 'MODULOS/PanelAdmin.php';?>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <h1 class="text-center">Gestión de Empleados</h1>
                     <div class="form-container">

                     <form id="employeeForm">
                     <input type="hidden" id="emp_id" name="emp_id" value="">

                     <div class="form-group">
                            <label for="cedula">Cédula:</label>
                            <input type="text" id="cedula" name="cedula" class="form-control" placeholder="123456789" pattern="\d{10}" title="La cédula debe contener 10 dígitos" required>
                            <small id="cedulaError" class="text-danger"></small>
                        </div>
                            <div class="form-group">
                                <label for="nombre">Nombre:</label>
                                <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Juan" pattern="[A-Za-z\s]+" title="El nombre solo puede contener letras y espacios" required>
                            </div>
                            <div class="form-group">
                                <label for="apellido">Apellido:</label>
                                <input type="text" id="apellido" name="apellido" class="form-control" placeholder="Pérez" pattern="[A-Za-z\s]+" title="El apellido solo puede contener letras y espacios" required>
                            </div>
                            <div class="form-group">
                                <label for="telefono">Teléfono:</label>
                                <input type="text" id="telefono" name="telefono" class="form-control" placeholder="0987654321" pattern="\d{7,15}" title="El teléfono debe contener entre 7 y 15 dígitos" required>
                            </div>
                            <div class="form-group">
                                <label for="correo">Correo:</label>
                                <input type="email" id="correo" name="correo" class="form-control" placeholder="juan.perez@example.com" required>
                            </div>
                            <div class="form-group">
                                <label for="direccion">Dirección:</label>
                                <input type="text" id="direccion" name="direccion" class="form-control" placeholder="Calle 123" minlength="5" maxlength="100" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Agregar Empleado</button>
                        </form>


                     </div>

                <hr>

                <h2 class="text-center">Listado de Empleados</h2>
                <table id="employeesTable" class="table table-bordered table-hover table-compact">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cédula</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Dirección</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Aquí se agregarán las filas dinámicamente -->
                    </tbody>
                </table>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
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
<script src="JS/empleados.js"></script>
<script src="JS/cerrarsesion.js"></script>

</body>
</html>
