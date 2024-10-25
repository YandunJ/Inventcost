<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Articulos de Inventario</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="../Public/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
        <?php include 'MODULOS/ModuloNavbar.php';?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/MDAdminSidebar.php';?>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Gestión articulos de Inventario</h1>
                    <div class="form-container">
                        <form id="inventoryForm">
                        <input type="hidden" id="id_articulo" name="id_articulo" value="0">
                            <div class="form-group">
                                <label for="nombre">Nombre del Artículo:</label>
                                <input type="text" id="nombre" name="nombre" class="form-control" required placeholder="Ej: Manzana">
                            </div>
                            <div class="form-group">
                                <label for="descripcion">Descripción:</label>
                                <textarea id="descripcion" name="descripcion" class="form-control" required placeholder="Breve descripción del artículo"></textarea>
                            </div>
                            <div class="form-group"> 
                                <label for="categoria_select">Categoría:</label>
                                <select id="categoria_select" name="categoria_select" class="form-control" required></select>
                            </div>
                            <div class="form-group">
                                <label for="unidad_medida">Unidad de Medida:</label>
                                <input type="text" id="unidad_medida" name="unidad_medida" class="form-control" required placeholder="Ej: Kilogramos, Litros, Unidades">
                            </div>
                            <button type="submit" class="btn btn-primary">Agregar Artículo</button>
                            <button type="button" class="btn btn-secondary" id="cancelButton">Cancelar</button>
                        </form>
                    </div>
    <!-- Botón para abrir el modal -->
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalFormulario">
        Agregar Artículo
    </button>
                    <hr>

                    <table id="inventoryTable" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Categoría</th> <!-- Nuevo -->
                                    <th>Unidad de Medida</th>
                                    <th>Estado</th> <!-- Nuevo -->
                                    <th>Fecha de Creación</th> <!-- Nuevo -->
                                    <th>Stock</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Aquí se agregarán las filas dinámicamente -->
                            </tbody>
                        </table>


<!-- INICIO MODAL  Modal que contiene el formulario  -->
<div class="modal fade" id="modalFormulario" tabindex="-1" aria-labelledby="modalFormularioLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalFormularioLabel">Agregar Artículo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="inventoryForm">
                    <div class="form-group">
                        <label for="nombre">Nombre del Artículo:</label>
                        <input type="text" id="nombre" name="nombre" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="descripcion">Descripción:</label>
                        <textarea id="descripcion" name="descripcion" class="form-control" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="id_categoria">Categoría:</label>
                        <select id="id_categoria" name="id_categoria" class="form-control" required>
                            <option value="">Seleccione una Categoría</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="unidad_medida">Unidad de Medida:</label>
                        <input type="text" id="unidad_medida" name="unidad_medida" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>
   <!-- FINAL DEL MODAL  -->

                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- jQuery -->
        <script src="../Public/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- DataTables -->
        <script src="../Public/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="../Public/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
        <!-- AdminLTE App -->
        <script src="../Public/dist/js/adminlte.min.js"></script>
        <!-- Custom JS -->
        <script src="JS/invCat.js"></script>
    </div>
</body>
</html>
