<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kardex de Inventario</title>
    <link rel="stylesheet" href="../FILES/global.css">
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
 
                            </select>
                        </div>
                        <!-- Botón para consultar -->
                        <div class="col-md-4 text-right">
                            <button class="btn btn-primary mt-4" id="btnFiltrar">
                                <i class="fas fa-search"></i> Consultar
                            </button>
                            <button class="btn btn-secondary mt-4" id="btnGenerarPDF">
                                <i class="fas fa-file-pdf"></i> Generar PDF
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
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Se llenará por JS -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Modal para mostrar los detalles -->
        <div class="modal fade" id="detalleModal" tabindex="-1" role="dialog" aria-labelledby="detalleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detalleModalLabel">Detalles del Kardex</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Se llenará por JS -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>&copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>. Derechos Reservados.
        </footer>
    </div>

    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <!-- Script simplificado para cargar datos de ejemplo -->
    <script src="JS/DTesp.js"></script>
    <script src="JS/kardex.js"></script>

    <script>
        $(document).ready(function () {
            $('#btnGenerarPDF').on('click', function () {
                const categoria_id = $('#selectCategoria').val();
                const mes = $('#monthPicker').val();
                const fecha_inicio = mes + '-01';
                const fecha_fin = new Date(mes.split('-')[0], mes.split('-')[1], 0).toISOString().split('T')[0];

                const url = `../AJAX/PDF.php?categoria_id=${categoria_id}&fecha_inicio=${fecha_inicio}&fecha_fin=${fecha_fin}`;
                window.open(url, '_blank');
            });
        });
    </script>
</body>
</html>