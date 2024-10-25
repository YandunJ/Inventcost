<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventcost Inventarios FranFruit</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Preloader -->
        <div class="preloader flex-column justify-content-center align-items-center">
            <img class="animation__shake" src="../Public/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
        </div>
        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="index.php" class="nav-link">Home</a>
                </li>
            </ul>
            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <!-- User dropdown menu -->
                <li class="nav-item dropdown">
                <a class="nav-link" data-toggle="dropdown" href="#">
                    <i class="far fa-user"></i> <span id="userName">User Name</span>
                </a>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                        <a href="#" class="dropdown-item logout-link">
                            <i class="fas fa-sign-out-alt"></i> Cerrar sesion
                        </a>
                    </div>
                </li>
            </ul>
        </nav>
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <aside class="main-sidebar sidebar-dark-primary elevation-4">
            <!-- Brand Logo -->
            <a href="index.php" class="brand-link">
                <img src="../Public/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                <span class="brand-text font-weight-light">INVENTCOST</span>
            </a>
            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                    <div class="image">
                        <img src="../FILES/usulogo.png" class="img-circle elevation-2" alt="User Image">
                    </div>
                    <div class="info">
                        <a href="#" class="d-block">User Name</a>
                    </div>
                </div>

                <!-- Sidebar Menu -->
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                        <li class="nav-item">
                            <a href="index.php" class="nav-link">
                                <i class="nav-icon fas fa-home"></i>
                                <p>Home</p>
                            </a>
                        </li>
                      
                        <li class="nav-item has-treeview">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-users-cog"></i>
                                <p>
                                    Gestión de Personal
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="usuarios.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Gestión de Usuarios</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="empleados.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Gestión Empleados</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="roles.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Roles de usuario</p>
                                    </a>
                                </li>
                            </ul>
                        </li>
                               
                        <!-- Other menu items -->
                        <li class="nav-item">
                            <a href="proveedores.php" class="nav-link">
                                <i class="nav-icon fas fa-tachometer-alt"></i>
                                <p>Proveedores</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="insumos.php" class="nav-link">
                                <i class="nav-icon fas fa-tachometer-alt"></i>
                                <p>Insumos</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="InventCatalogo.php" class="nav-link">
                                <i class="nav-icon fas fa-edit"></i>
                                <p>Materia Prima</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-table"></i>
                                <p>Inventarios</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="producto.php" class="nav-link">
                                <i class="nav-icon fas fa-chart-pie"></i>
                                <p>Producto Terminado</p>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- /.sidebar-menu -->
            </div>
            <!-- /.sidebar -->
        </aside>

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
    <script src="assets/js/custom.js"></script>
    <!-- Incluir el script de cierre de sesión -->
<script src="JS/cerrarsesion.js"></script>
<script src="JS/validsesion.js"></script>

</body>
</html>
