<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artículos de Inventario</title>

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

                   <!-- Contenedor del título con ayuda -->
<div class="page-header" style="position: relative;">
    <h1 class="text-center">
        Catálogo Inventario 
        <!-- <button id="helpButton" class="btn btn-link p-0" title="Ayuda">
            <i class="fas fa-info-circle fa-lg"></i>
        </button> -->
    </h1>
    <div id="customHelp" class="help-message">
        Este módulo permite gestionar el catálogo de inventario. Aquí puedes agregar, editar y consultar insumos.
    </div>
</div>

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
                                    <h5 class="modal-title" id="modalFormularioLabel">Agregar Insumo</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    
                                    <form id="inventoryForm">
                                        <input type="hidden" id="id_articulo" name="id_articulo" value="0">
                                        <div class="form-group">
                                            <label for="nombre">Nombre del artículo:</label>
                                            <input type="text" id="nombre" name="nombre" class="form-control" required placeholder="Ej: Manzana">
                                        </div>
                                        <div class="form-group">
                                            <label for="categoria_select">Categoría:</label>
                                            <select id="categoria_select" name="id_categoria" class="form-control" required></select>
                                        </div>
                                        <div class="form-group">
                                            <label for="unidad_medida">Unidad de Medida:</label>
                                            <select id="unidad_medida" name="unidad_medida" class="form-control" required></select>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Guardar</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Tabla de inventario -->
                    <table id="inventoryTable" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                
                                <th>Nombre</th>
                                <th>Categoría</th>
                                <th>Presentacion</th>
                                <th>Estado</th>
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

    <script src="JS/invCat.js"></script>
    <script src="JS/DTesp.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>