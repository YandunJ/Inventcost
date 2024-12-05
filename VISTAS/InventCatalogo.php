<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artículos de Inventario</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="../Public/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <link rel="stylesheet" href="../FILES/Table-Compact.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
        <?php include 'MODULOS/ModuloNavbar.php'; ?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/MDAdminSidebar.php'; ?>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h3 class="text-center">Catálogo Frutas e Insumos    </h3>

                    <!-- Botón para abrir el modal -->
                    <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#modalFormulario">
                        Agregar 
                    </button>

                    
            <!-- Modal para el formulario -->
            <div class="modal fade" id="modalFormulario" tabindex="-1" aria-labelledby="modalFormularioLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalFormularioLabel">Agregar insumos al Catálogo</h5>
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
                                        <label for="descripcion">Descripción:</label>
                                        <textarea id="descripcion" name="descripcion" class="form-control" required placeholder="Breve descripción"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="categoria_select">Categoría:</label>
                                        <select id="categoria_select" name="id_categoria" class="form-control" required></select>
                                    </div>
                                    <div class="form-group">
                                        <label for="unidad_medida">Unidad de Medida:</label>
                                        <select id="unidad_medida" name="unidad_medida" class="form-control" required></select>
                                    </div>
                                    <div class="form-group">
                                        <label for="proveedor_id">Proveedor:</label>
                                        <select id="proveedor_id" name="proveedor_id" class="form-control" required></select>
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
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Categoría</th>
                                <th>Proveedor</th>
                                <th>Unidad de Medida</th>
                                <th>Estado</th>
                                <th>Fecha de Creación</th>
                                <th>Stock</th>
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
        <!-- /.content-wrapper -->

        <!-- Scripts -->
        <script src="../Public/plugins/jquery/jquery.min.js"></script>
        <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../Public/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="../Public/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="../Public/dist/js/adminlte.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

        <script src="JS/invCat.js"></script>
    </div>
</body>
</html>
