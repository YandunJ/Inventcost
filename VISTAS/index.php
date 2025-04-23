<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <!-- Default content goes here -->
                    <h1>Bienvenido al sistema </h1>
                    <div class="row">
    <!-- Lotes MP -->
    <div class="col-lg-3 col-6">
        <div class="small-box bg-info">
            <div class="inner">
                <h3 id="cantidadLotesMP">0</h3>
                <p>Lotes de Fruta Disponible</p>
            </div>
            <div class="icon">
                <i class="fas fa-boxes"></i>
            </div>
        </div>
    </div>
    
    <!-- Lotes INS -->
    <div class="col-lg-3 col-6">
        <div class="small-box bg-success">
            <div class="inner">
                <h3 id="cantidadLotesINS">0</h3>
                <p>Lotes de Insumos Disponible</p>
            </div>
            <div class="icon">
                <i class="fas fa-pallet"></i>
            </div>
        </div>
    </div>
    
    <!-- Lotes PT -->
    <div class="col-lg-3 col-6">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3 id="cantidadLotesPT">0</h3>
                <p>Lotes de Pulpas Disponibles</p>
            </div>
            <div class="icon">
                <i class="fas fa-warehouse"></i>
            </div>
        </div>
    </div>
    
    <!-- Lotes Próximos a Vencer -->
    <div class="col-lg-3 col-6">
        <div class="small-box bg-danger">
            <div class="inner">
                <h3 id="cantidadLotesProximos">0</h3>
                <p>Lotes de Pulpa por Vencer</p>
            </div>
            <div class="icon">
                <i class="fas fa-clock"></i>
            </div>
        </div>
    </div>
</div>


<div class="col-lg-12">
    <div class="card shadow-sm" style="border: 1px solid #e2e8f0; border-radius: 8px; overflow: hidden;"> <!-- Contenedor tipo tarjeta -->
        <div class="card-header bg-white" style="border-bottom: 1px solid #e2e8f0; padding: 10px 15px;">
            <h5 class="card-title mb-0" style="font-size: 1.1rem; color: #2d3748;">Stock de Pulpas por Presentación</h5>
        </div>
        <div class="card-body p-3" style="padding: 15px;"> <!-- Reduce el padding interno -->
            <div class="chart-container" style="position: relative; margin: auto; padding: 15px; height: 400px; width: 100%;"> <!-- Control de tamaño -->
                <canvas id="myPieChart"></canvas>
            </div>
        </div>
    </div>
</div>
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
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../Public/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <!-- Custom JS -->
    <script src="JS/cerrarsesion.js"></script>
    <!-- <script src="JS/validsesion.js"></script> -->
    <script src="JS/estad.js"></script> <!-- Incluir el archivo JS para las estadísticas -->
</body>
</html>