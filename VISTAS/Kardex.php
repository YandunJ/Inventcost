<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kardex de Inventario</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="../Public/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <?php include 'MODULOS/BarraHorizontal.php'; ?>
        <?php
        if ($_SESSION['rol_id'] == 1) {
            include 'MODULOS/PanelAdmin.php';
        } elseif ($_SESSION['rol_id'] == 2) {
            include 'MODULOS/PanelInventario.php';
        } elseif ($_SESSION['rol_id'] == 3) {
            include 'MODULOS/PanelProduccion.php';
        }
        ?>
        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Kardex de Inventario</h1>
                    <div class="row mb-3">
                        <!-- Control de selección de mes usando input type="month" -->
                        <div class="col-md-4">
                            <label for="monthPicker">Mes Inventario:</label>
                            <input type="month" id="monthPicker" class="form-control" value="2025-01">
                        </div>
                        <!-- Selector de Categoría -->
                        <div class="col-md-4">
                            <label for="selectCategoria">Categoría:</label>
                            <select id="selectCategoria" class="form-control">
                                <option value="1">Materia Prima</option>
                                <option value="2">Insumos</option>
                                <option value="3">Producto Terminado</option>
                                <option value="4">Mano de Obra</option>
                                <option value="5">Costos Indirectos</option>
                            </select>
                        </div>
                        <!-- Botón para consultar -->
                        <div class="col-md-4 text-right">
                            <button class="btn btn-primary mt-4" id="btnFiltrar">
                                <i class="fas fa-search"></i> Consultar
                            </button>
                        </div>
                    </div>

                    <!-- Tabla de vista general del Kardex con columna de unidad/presentación -->
                    <table id="tablaKardex" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>Artículo</th>
                                <th>Presentación</th>
                                <th>Entradas</th>
                                <th>Salidas</th>
                                <th>Saldo Final</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Se llenará por JS -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
  

    <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>Copyright &copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>.</strong> Derechos Reservados.
        </footer>
    </div>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../Public/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <!-- Script simplificado para cargar datos de ejemplo -->
    <script src="JS/DTesp.js"></script>
    <script src="JS/kardex.js"></script>
</body>
</html>