<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kardex de Inventario</title>
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.5/css/responsive.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="../FILES/global-style.css">
    <link rel="stylesheet" href="../FILES/Table-Compact.css">
   
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <?php include 'MODULOS/ModuloNavbar.php'; ?>
        <?php include 'MODULOS/MDAdminSidebar.php'; ?>

        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Kardex de Inventario</h1>
                    <div class="row mb-3">
    <div class="col-md-4">
        <label for="monthPicker">Mes Inventario:</label>
        <div class="input-group">
        <span class="input-group-text">
                    <i class="far fa-calendar-alt"></i>
                </span>
            <input type="text" id="monthPicker" class="form-control" placeholder="MM/AAAA" readonly>
            <div class="input-group-append">
             
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <label for="selectCategoria">Categoría:</label>
        <select id="selectCategoria" class="form-control">
            <option value="MP">Materia Prima</option>
            <option value="INS">Insumos</option>
            <option value="PT">Producto Terminado</option>
        </select>
    </div>

    <div class="col-md-4 text-right">
        <button class="btn btn-primary mt-4" id="btnFiltrar">
            <i class="fas fa-search"></i> Consultar
        </button>

        <button id="btnReporteEntradas" class="btn btn-primary">Imp. Reporte </button>
    </div>

    

</div>


                    <table id="tablaKardex" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>Insumo</th>
                                <th>Categoría</th>
                                <th>Presentación</th>
                                <th>Unidad</th>
                                <th>Entradas</th>
                                <th>Salidas</th>
                                <th>Saldo</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </section>
        </div>

        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">FRAN FRUIT</div>
            <strong>Copyright &copy; 2024 <a href="https://www.instagram.com/pulpafranfruit">FranFruit.io</a>.</strong> Derechos Reservados.
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.5/js/dataTables.responsive.min.js"></script>
    <script src="JS/kardex.js"></script>
    <script src="JS/validaciones.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>
