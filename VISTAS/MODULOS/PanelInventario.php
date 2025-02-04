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
                <li class="nav-item">
                    <a href="index.php" class="nav-link">
                        <i class="nav-icon fas fa-home"></i>
                        <p>Inicio</p>
                    </a>
                </li>
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
                <li class="nav-item">
                    <a href="Costos.php" class="nav-link">
                        <i class="nav-icon fas fa-dollar-sign"></i>
                        <p>Costos</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="LotesFrutas.php" class="nav-link">
                        <i class="nav-icon fas fa-apple-alt"></i>
                        <p>Lotes Frutas</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="LotesInsumos.php" class="nav-link">
                        <i class="nav-icon fas fa-boxes"></i>
                        <p>Lotes Insumos</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="Kardex.php" class="nav-link">
                        <i class="nav-icon fas fa-clipboard-list"></i>
                        <p>Kardex</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="Insumos.php" class="nav-link">
                        <i class="nav-icon fas fa-cogs"></i>
                        <p>Insumos</p>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>