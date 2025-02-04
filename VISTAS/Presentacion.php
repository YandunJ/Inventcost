<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Presentaciones</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="../Public/plugins/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css">
    <style>
        .filter-container {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 1rem;
        }
        .filter-container select {
            width: auto;
            max-width: 300px;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
        <?php include 'MODULOS/BarraHorizontal.php'; ?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/PanelAdmin.php'; ?>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Catálogo de Presentaciones</h1>
                    <div class="text-right mb-3">
                        <!-- Botón para abrir el modal -->
                        <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#modalFormulario" data-action="add">
                            <i class="fas fa-plus"></i> Agregar
                        </button>
                    </div>
                    
                    <!-- Filtro de categorías -->
                    <div class="filter-container">
                        <label for="filtroCategoria">Ver Presentaciones: </label>
                        <select id="filtroCategoria" class="form-control">
                            <option value="">Seleccione una categoría</option>
                            <option value="2">Insumos</option>
                            <option value="3">Producto Terminado</option>
                        </select>
                    </div>

                    <!-- Modal para el formulario -->
                    <div class="modal fade" id="modalFormulario" tabindex="-1" aria-labelledby="modalFormularioLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalFormularioLabel">Agregar </h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="presentacionForm">
                                        <input type="hidden" id="id_presentacion" name="id_presentacion" value="0">
                                        <div class="form-group">
                                            <label for="categoria">Categoría:</label>
                                            <select id="categoria" name="categoria" class="form-control" required>
                                                <option value="">Seleccione una categoría</option>
                                                <option value="2">Insumos</option>
                                                <option value="3">Producto Terminado</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="nombre">Nombre de la Presentación:</label>
                                            <input type="text" id="nombre" name="nombre" class="form-control" required placeholder="Ej: 200 gr, 2 kg">
                                        </div>
                                        <div class="form-group" id="abreviacionContainer">
                                            <label for="abreviacion">Abreviación:</label>
                                            <input type="text" id="abreviacion" name="abreviacion" class="form-control" placeholder="Ej: gr, kg">
                                        </div>
                                        <div class="form-group" id="equivalenciaContainer" style="display: none;">
                                            <label for="equivalencia">Equivalencia en Gramos:</label>
                                            <input type="number" id="equivalencia" name="equivalencia" class="form-control" placeholder="Ej: 200, 2000">
                                        </div>
                                        <div class="form-group" id="estadoContainer" style="display: none;">
                                            <label for="estado">Estado:</label>
                                            <div class="custom-switch-container">
                                                <label class="switch">
                                                    <input type="checkbox" id="estado" name="estado" value="vigente" checked>
                                                    <span class="slider round"></span>
                                                </label>
                                                <span id="estado-text">Vigente</span>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Guardar</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Tabla de presentaciones -->
                    <table id="presentacionTable" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th class="abreviacion-column">Abreviación</th>
                                <th class="categoria-column" style="display: none;">Categoría</th>
                                <th class="equivalencia-column">Equivalencia (gr)</th>
                                <th class="estado-column">Estado</th>
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
            <strong>&copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>. Derechos Reservados.</strong>
        </footer>
    </div>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../Public/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script src="../Public/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
    <script src="JS/presentacion.js"></script>
</body>
</html>