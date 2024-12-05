<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario de Insumos</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.5/css/responsive.dataTables.min.css">

    <link rel="stylesheet" href="../FILES/InvMPform.css">
    <link rel="stylesheet" href="../FILES/InvMPModal.css">
    <!-- REVISAR LOS ESTILOS QUE SOLO QUEDE LOS NECESARIOS Y EN CASO DE SER UTIL CENTRALIZAR UN ESTILO PARA DEJAR SOLO UNO PARA TODOS -->
    <link rel="stylesheet" href="../FILES/Table-Compact.css">

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
            <h1 class="text-center">Gestión de Insumos</h1>
                    <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#Form_Insumos" data-is-new="true">
                        Agregar
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="Form_Insumos" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Registro de Insumos</h5>
                                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="InsumosForm" class="modal-form-container">
                                        <!-- Fila 1 -->
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="proveedor_id">Proveedor:</label>
                                                <select id="proveedor_id" name="proveedor_id" class="form-control" required>
                                                    <option value="">Seleccione un proveedor</option>
                                                </select>
                                                
                                            </div>
                                            <div class="form-group">
                                                <label for="id_articulo">Insumo:</label>
                                                <select id="id_articulo" name="id_articulo" class="form-control" required>
                                                    <option value="">Seleccione un insumo</option>
                                                </select>
                                                
                                            </div>
                                            <div class="form-group">
                                                <label for="fecha">Fecha:</label>
                                                <input type="date" id="fecha" name="fecha" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="hora">Hora:</label>
                                                <input type="time" id="hora" name="hora" class="form-control" required>
                                            </div>
                                        </div>

                                        <!-- Fila 2 -->
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="numero_lote">N Lote:</label>
                                                <input type="text" id="numero_lote" name="numero_lote" class="form-control" readonly>
                                            </div>
                                            <div class="form-group">
                                            <label for="cantidad_ingresada">Cantidad Ingresada:</label>
                                                <div class="quantity-input">
                                                    <button type="button" class="btn-decrement">-</button>
                                                    <input type="number" id="cantidad_ingresada" name="cantidad_ingresada" class="form-control" value="0" required>
                                                    <button type="button" class="btn-increment">+</button>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="unidad_medida">Unidad de Medida:</label>
                                                <input type="text" id="unidad_medida" name="unidad_medida" class="form-control" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="precio_unitario">Precio Unitario:</label>
                                                <input type="number" step="0.01" id="precio_unitario" name="precio_unitario" class="form-control" required>
                                            </div>
                                        </div>

                                        <!-- Fila 3 -->
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="presentacion">Presentación:</label>
                                                <select id="presentacion" name="presentacion" class="form-control" required>
                                                    <option value="cajas">Cajas</option>
                                                    <option value="bultos">Bultos</option>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- Botones -->
                                        <div class="form-actions">
                                            <button type="submit" class="btn btn-primary">Guardar</button>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                    <hr>
                    <table id="inventarioInsumosdt" class="table table-bordered table-hover table-compact">
    <thead>
        <tr>

                            <th>ID</th>
                            <th>Insumo</th>
                            <th>Proveedor</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Ud Medida</th>
                            <th>Cantidad</th>
                            <th>Stock</th>
                            <th>Precio Unitario</th>
                            <th>Precio Total</th>
                            <th>Presentación</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Rows will be populated dynamically from the backend -->
                        </tbody>
                    </table>
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
    <!-- AdminLTE App -->
    <script src="../Public/dist/js/adminlte.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.5/js/dataTables.responsive.min.js"></script>

    <!-- Custom JS  -->
    <script src="JS/invInsumos.js"></script>
    <script src="JS/cerrarsesion.js"></script>

    
</body>
</html>
