<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kardex de Inventario</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="../Public/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
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
                                <div class="input-group-append"></div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="selectCategoria">Categoría:</label>
                            <select id="selectCategoria" class="form-control">
                                <!-- Las categorías se cargarán aquí -->
                            </select>
                        </div>

                        <div class="col-md-4 text-right">
                            <button class="btn btn-primary mt-4" id="btnFiltrar">
                                <i class="fas fa-search"></i> Consultar
                            </button>
                            <button id="btnReporteEntradas" class="btn btn-primary">Imp. Reporte</button>
                        </div>
                    </div>

                    <table id="tablaKardex" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Artículo</th>
                                <th>Presentación</th>
                                <th>Entradas</th>
                                <th>Salidas</th>
                                <th>Saldo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>

    <!-- Modal para mostrar los registros de entradas -->
    <div class="modal fade" id="modalEntradas" tabindex="-1" role="dialog" aria-labelledby="modalEntradasLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalEntradasLabel">Registros de Entradas</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="contenidoEntradas">
                        <table id="tablaEntradas" class="table table-bordered table-hover table-compact">
                            <thead>
                                <tr>
                                    <th>Fecha y Hora</th>
                                    <th>Lote</th>
                                    <th>Proveedor</th>
                                    <th>Artículo</th>
                                    <th>Presentación</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unitario</th>
                                    <th>Precio Total</th>
                                    <th>Tipo de Movimiento</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script src="../Public/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../Public/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="JS/kardex.js"></script>
    <script src="JS/DTesp.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>