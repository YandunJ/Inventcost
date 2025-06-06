<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Costos</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="../Public/plugins/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css">
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
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Catálogo Costos</h1>
                    <div class="text-right mb-3">
                        <!-- Botón para abrir el modal -->
                        <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#modalFormulario" data-action="add">
                        <i class="fas fa-plus"></i> Agregar
                        </button>
                    </div>
                    
                    <!-- Modal para el formulario -->
                    <div class="modal fade" id="modalFormulario" tabindex="-1" aria-labelledby="modalFormularioLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="mo   dal-title" id="modalFormularioLabel">Agregar Costo al Catálogo</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="costForm">
                                        <input type="hidden" id="id_costo" name="id_costo" value="0">
                                        <div class="form-group">
                                            <label for="nombre">Nombre  o Descripcion de la Actividad:</label>
                                            <input type="text" id="nombre" name="nombre" class="form-control" required placeholder="Ej:Despulpado, Agua, Electricidad">
                                        </div>
                                        <div class="form-group">
                                            <label for="categoria">Categoría:</label>
                                            <select id="categoria" name="categoria" class="form-control" required>
                                                <!-- Opciones se cargarán dinámicamente -->
                                            </select>
                                        </div>
                                        <div class="form-group" id="unidadMedidaGroup" style="display: none;">
                                            <label for="unidad_medida">Unidad de Medida:</label>
                                            <select id="unidad_medida" name="unidad_medida" class="form-control">
                                                <!-- Opciones se cargarán dinámicamente -->
                                            </select>
                                        </div>


                                        <div class="form-group">
    <label for="estado">Estado:</label>
    <div class="custom-switch-container">
        <label class="switch">
            <input type="checkbox" id="estado" name="estado" value="1" checked>
            <span class="slider round"></span>
        </label>
        <span id="estado-text">Habilitado</span>
    </div>
</div>

                                        <button type="submit" class="btn btn-primary">Guardar</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Tabla de costos -->
                    <table id="costTable" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                
                                <th>Nombre</th>
                                <th>Categoría</th>
                                <th>Estado</th>
                                <th>Un. Medida</th>
                                <th>Fecha de Creación</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Filas dinámicas -->
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
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script src="../Public/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>


    <script src="JS/cost.js"></script>
    <script src="JS/DTesp.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>