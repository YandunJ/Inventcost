<?php
session_start();
$nombreCompleto = isset($_SESSION['nombre']) ? $_SESSION['nombre'] . ' ' . $_SESSION['apellido'] : 'User Name';
?>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
            <!-- Brand Logo -->
            <a href="index.php" class="brand-link">
                <img src="../FILES/solologo2.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
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
                <!-- Gestión de Inventario -->
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-boxes"></i>
                        <p>
                            Almacen
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="proveedores.php" class="nav-link">
                                <i class="nav-icon fas fa-truck"></i>
                                <p>Proveedores</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Catalogo.php" class="nav-link">
                                <i class="nav-icon fas fa-edit"></i>
                                <p>Catálogo</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Presentacion.php" class="nav-link">
                                <i class="nav-icon fas fa-box"></i>
                                <p>Presentaciones</p>
                            </a>
                        </li>
                    </ul>
                </li>
                
                         

                        <li class="nav-item">
                            <a href="InvFrutas.php" class="nav-link">
                                <i class="nav-icon fas fa-apple-alt"></i>
                                <p>Lotes Frutas</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="InvInsumos.php" class="nav-link">
                                <i class="nav-icon fas fa-boxes"></i>
                                <p>Lotes Insumos</p>
                            </a>
                        </li>

                        </li>
                             
                        <li class="nav-item">
                                    <a href="PRODUCCION.php" class="nav-link">
                                        <i class="nav-icon fas fa-industry"></i>
                                        <p>Produccion</p>
                                    </a>
                                </li>

                                <li class="nav-item">
                    <a href="Costos.php" class="nav-link">
                        <i class="nav-icon fas fa-dollar-sign"></i>
                        <p>Costos</p>
                    </a>
                </li>
                    
                <li class="nav-item">
                                    <a href="Kardex.php" class="nav-link">
                                        <i class="nav-icon fas fa-clipboard-list"></i>
                                        <p>Kardex</p>
                                    </a>
                                </li>
                     
    
                        <!-- Gestión de Personal -->
                        <li class="nav-item has-treeview">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-solid fa-users"></i>
                                <p>
                                     Usuarios
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="usuarios.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Mis Usuarios</p>
                                    </a>
                                </li>
                                <!-- <li class="nav-item">
                                    <a href="empleados.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Empleados</p>
                                    </a>
                                </li> -->
                                <li class="nav-item">
                                    <a href="roles.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Roles de usuario</p> 
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