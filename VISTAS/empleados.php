<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empleados</title>
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
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1>Empleados</h1>
                    <!-- Aquí puedes agregar el código PHP para obtener y mostrar los empleados -->
                    <?php
                    require_once "../CONFIG/conexion.php";
                    $sql = "SELECT * FROM empleados";
                    $result = ejecutarConsultaSP($sql);
                    if ($result->num_rows > 0) {
                        echo '<table class="table table-bordered">';
                        echo '<thead><tr><th>ID</th><th>Cédula</th><th>Nombre</th><th>Apellido</th><th>Teléfono</th><th>Correo</th><th>Dirección</th></tr></thead>';
                        echo '<tbody>';
                        while ($row = $result->fetch_assoc()) {
                            echo '<tr>';
                            echo '<td>' . $row['emp_id'] . '</td>';
                            echo '<td>' . $row['emp_cedula'] . '</td>';
                            echo '<td>' . $row['emp_nombre'] . '</td>';
                            echo '<td>' . $row['emp_apellido'] . '</td>';
                            echo '<td>' . $row['emp_telefono'] . '</td>';
                            echo '<td>' . $row['emp_correo'] . '</td>';
                            echo '<td>' . $row['emp_direccion'] . '</td>';
                            echo '</tr>';
                        }
                        echo '</tbody>';
                        echo '</table>';
                    } else {
                        echo '<p>No se encontraron empleados.</p>';
                    }
                    ?>
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Main Footer -->
        <!-- ... Footer code as in your template ... -->
    </div>
    <!-- ./wrapper -->

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- Custom JS -->
    <script src="assets/js/custom.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>
