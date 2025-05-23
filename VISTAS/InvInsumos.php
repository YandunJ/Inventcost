<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario de Insumos</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../FILES/global.css">
    <link rel="stylesheet" href="../FILES/STmodalINS.css">
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
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
            <div class="container-fluid">
            <h1 class="text-center">Inventario de Insumos</h1>
            <div class="text-right mb-3">
                    <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#Form_Insumos" data-is-new="true">
                    <i class="fas fa-plus"></i> Registrar Entrada
                    </button>
                    </div>
                 
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
                            <select id="cat_id" name="id_articulo" class="form-control" required>
                                <option value="">Seleccione un insumo</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="fecha_elaboracion">Fecha Elaboración:</label>
                            <input type="date" id="fecha_elaboracion" name="fecha_elaboracion" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="fecha_caducidad">Fecha Caducidad:</label>
                            <input type="date" id="fecha_caducidad" name="fecha_caducidad" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="numero_lote">N Lote:</label>
                            <input type="text" id="numero_lote" name="numero_lote" class="form-control" readonly>
                        </div>
                    </div>

                    <!-- Fila 2 -->
                    <div class="form-row">
                    <div class="form-group">
    <label for="cantidad_ingresada">Cantidad a Ingresar:</label>
    <div class="input-quantity">
        <button type="button" class="btn-minus quantity-int">-</button>
        <input type="number" id="cantidad_ingresada" name="cantidad_ingresada" class="form-control" value="0" min="0" step="0.01" required>
        <button type="button" class="btn-plus quantity-int">+</button>
    </div>
</div>
<div class="form-group">
    <label for="unidad_medida">Presentación:</label>
    <input type="text" id="unidad_medida" name="unidad_medida" class="form-control" readonly>
</div>
                        <div class="form-group">
                            <label for="precio_total">Precio Total:</label>
                            <div class="input-quantity">
                                <button type="button" class="btn-minus quantity-decimal">-</button>
                                <input type="number" step="0.01" id="precio_total" name="precio_total" class="form-control" value="0.00">
                                <button type="button" class="btn-plus quantity-decimal">+</button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="precio_unitario">Precio Unitario:</label>
                            <input type="number" step="0.01" id="precio_unitario" name="precio_unitario" class="form-control" readonly>
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
        <th>Fecha</th>
            <th>Lote</th>
            <th>Proveedor</th>
            <th>Insumo</th>
            <th>Presentación</th>
            <th>Cant. Inicial</th>
            <th>Cant. Disp.</th>
            <th>Precio Unit.</th>
            <th>Precio Total</th>
            <th>Fecha Elaboración</th>
            <th>Fecha Caducidad</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <!-- Las filas se cargarán dinámicamente con DataTable -->
    </tbody>
</table>

                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
     
           <!-- Main Footer -->
           <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>&copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>.</strong> Derechos Reservados.
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <!-- Custom JS  -->
    <script src="JS/invInsumos.js"></script>
    <script src="JS/DTesp.js"></script>
    <script src="JS/cerrarsesion.js"></script>

    
</body>
</html>