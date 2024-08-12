<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventcost Inventarios FranFruit</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">

    <link rel="stylesheet" href="../Public/css/ColorPanel.css">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
 
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Preloader -->
        <div class="preloader flex-column justify-content-center align-items-center">
            <img class="animation__shake" src="../FILES/solologo2.png" alt="AdminLTELogo" height="60" width="60">
        </div>
            
         <!-- Navbar -->
         <?php include 'MODULOS/ModuloNavbar.php';?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/MDAdminSidebar.php';?>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <!-- Default content goes here -->
                    <h1>Bienvenido al sistema </h1>
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Main Footer -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                Custom footer text
            </div>
            <strong>Copyright &copy; 2024 <a href="https://adminlte.io">FranFruit.io</a>.</strong> Derechos Reservados.
        </footer>
    </div>
    <!-- ./wrapper -->

    <!-- jQuery -->
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <!-- Custom JS -->
  <script src="JS/cerrarsesion.js"></script>
    <script src="JS/validsesion.js"></script>

</body>
</html>
