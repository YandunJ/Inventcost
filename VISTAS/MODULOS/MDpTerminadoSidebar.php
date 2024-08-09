<?php
session_start();
$nombreCompleto = isset($_SESSION['nombre']) ? $_SESSION['nombre'] . ' ' . $_SESSION['apellido'] : 'User Name';
?>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
            <!-- Brand Logo -->
            <a href="index.php" class="brand-link">
                <img src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                <span class="brand-text font-weight-light">INVENTCOST</span>
            </a>
            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                    <div class="image">
                        <img src="../FILES/usulog.png" class="img-circle elevation-2" alt="User Image">
                        </div>
                            <div class="info">
                                <a href="#" class="d-block"><?php echo $nombreCompleto; ?></a>
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
                               
                        <!-- Other menu items -->
                                
                        <li class="nav-item">
                            <a href="producto.php" class="nav-link">
                                <i class="nav-icon fas fa-box-open"></i>
                                <p>Producto Terminado</p>
                            </a>
                        </li>

                                </li>
                                <li class="nav-item">
                                    <a href="proveedores.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Proveedores</p>
                                    </a>
                                </li>

                              
                            </ul>
                        </li>
                    </ul>
                </nav>
                <!-- /.sidebar-menu -->
            </div>
            <!-- /.sidebar -->
        </aside>