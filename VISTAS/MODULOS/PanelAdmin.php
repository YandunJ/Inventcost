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
            <div class="info">
                <a href="#" class="d-block" style="font-size: 1.2em; font-weight: bold;">¡Hola! <?php echo $nombreCompleto; ?></a>
            </div>
        </div>
        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Gestión de Inventario -->
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-warehouse"></i>
                        <p>
                            Almacén
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
                            <a href="Presentacion.php" class="nav-link">
                                <i class="nav-icon fas fa-tags"></i>
                                <p>Presentaciones</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Catalogo.php" class="nav-link">
                                <i class="nav-icon fas fa-edit"></i>
                                <p>Catálogo</p>
                            </a>
                        </li>
                    
                    </ul>
                </li>
                <!-- Gestión de Lotes -->
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-boxes"></i>
                        <p>
                            Inventario
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="InvFrutas.php" class="nav-link">
                                <i class="nav-icon fas fa-apple-alt"></i>
                                <p>Lotes Frutas</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="InvInsumos.php" class="nav-link">
                                <i class="nav-icon fas fa-box"></i>
                                <p>Lotes Insumos</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="producto.php" class="nav-link">
                                <i class="nav-icon fas fa-box-open"></i>
                                <p>Lotes Producto Terminado</p>
                            </a>
                        </li>
                     
                    </ul>
                </li>
                <!-- Gestión de Producción -->
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-industry"></i>
                        <p>
                            Producción
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                    <li class="nav-item">
                            <a href="Costos.php" class="nav-link">
                                <i class="nav-icon fas fa-dollar-sign"></i>
                                <p>Costos</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="PRODUCCION.php" class="nav-link">
                                <i class="nav-icon fas fa-cogs"></i>
                                <p>Realizar Producción</p>
                            </a>
                        </li>
                   
                     
                       
                    </ul>
                </li>
                <!-- Gestión de Salidas -->
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-dolly"></i>
                        <p>
                            Despacho Producto 
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                    <li class="nav-item">
                            <a href="producto.php" class="nav-link">
                                <i class="nav-icon fas fa-box-open"></i>
                                <p>Lotes Producto Terminado</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="VentaPT.php" class="nav-link">
                                <i class="nav-icon fas fa-arrow-right"></i>
                                <p>Registrar Venta</p>
                            </a>
                        </li>
                        <!-- <li class="nav-item">
                            <a href="HistorialSalidas.php" class="nav-link">
                                <i class="nav-icon fas fa-history"></i>
                                <p>Historial de Salidas</p>
                            </a>
                        </li> -->
                    </ul>
                </li>
                <!-- Gestión de Kardex -->
                <li class="nav-item">
                    <a href="Kardex.php" class="nav-link">
                        <i class="nav-icon fas fa-clipboard-list"></i>
                        <p>Kardex</p>
                    </a>
                </li>
                <!-- Gestión de Personal -->
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-users"></i>
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
                            <a href="roles.php" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Roles de usuario</p>
                            </a>
                        </li> -->
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>