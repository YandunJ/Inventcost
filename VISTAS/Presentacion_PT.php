<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Presentaciones de Producto Terminado</title>
    <link rel="stylesheet" href="../FILES/global.css">
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
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Presentaciones de Producto Terminado</h1>
                    <div class="text-right mb-3">
                        <button id="btnAgregar" class="btn btn-primary" data-toggle="modal" data-target="#modalFormulario">
                            <i class="fas fa-plus"></i> Agregar Presentación
                        </button>
                    </div>
                    <div id="tablaPresentacionesPT_wrapper">
                        <table id="presentacionTable" class="table table-bordered table-hover table-compact">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Equivalencia</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Datos cargados dinámicamente -->
                            </tbody>
                        </table>
                    </div>
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Modal Formulario -->
        <div class="modal fade" id="modalFormulario" tabindex="-1" role="dialog" aria-labelledby="modalFormularioLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalFormularioLabel">Agregar Presentación de Producto Terminado</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="presentacionForm">
                        <div class="modal-body">
                            <input type="hidden" id="prs_id" name="prs_id" value="0">
                            <div class="form-group">
                                <label for="prs_nombre">Nombre</label>
                                <input type="text" class="form-control" id="prs_nombre" name="prs_nombre" required>
                            </div>
                            <div class="form-group">
                                <label for="equivalencia">Equivalencia</label>
                                <input type="number" class="form-control" id="equivalencia" name="equivalencia" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>&copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>. Derechos Reservados.</strong>
        </footer>
    </div>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script src="JS/DTesp.js"></script>
    <script src="JS/presentacionPT.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>