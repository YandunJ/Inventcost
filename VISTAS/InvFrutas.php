<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lotes Materia Prima</title>
    <link rel="stylesheet" href="../FILES/global.css">

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
                    <h1 class="text-center">Inventario Frutas</h1>
                    <div class="text-right mb-3">
                    <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#Form_MP" data-is-new="true">
    Agregar
</button>
</div>

                
<div class="modal fade" id="Form_MP" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Registro de Materia Prima</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="materiaPrimaForm" class="modal-form-container">
                    <!-- Fila 1 -->
                    <input type="hidden" id="id_inv" name="id_inv">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="proveedor_id">Proveedor:</label>
                            <select id="proveedor_id" name="proveedor_id" required>
                                <option value="">Seleccione proveedor</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="id_articulo">Fruta:</label>
                            <select id="cat_id" name="id_articulo" required>
                                <option value="">Seleccione fruta</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="numero_lote">N Lote:</label>
                            <input type="text" id="numero_lote" name="numero_lote" readonly>
                        </div>
                    </div>

                    <!-- Fila 2 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="cantidad_ingresada">Cantidad:</label>
                            <div class="input-quantity">
                                <button type="button" class="btn-minus quantity-int">-</button>
                                
                                <input type="number" id="cantidad_ingresada" name="cantidad_ingresada" value="1" min="0" step="0.01" required>
                                <span class="currency">Kg</span>
                                <button type="button" class="btn-plus quantity-int">+</button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="precio_total">Precio Total:</label>
                            
                            <div class="input-quantity">
                                <button type="button" class="btn-minus quantity-decimal">-</button>
                                <span class="currency">$</span>
                                <input type="number" id="precio_total" name="precio_total" value="0.00" min="0" step="0.01" required>
                                <button type="button" class="btn-plus quantity-decimal">+</button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="precio_unitario">Precio Unitario:</label>
                            <input type="number" id="precio_unitario" name="precio_unitario" value="0.00" min="0" step="0.01"  readonly  required>
                        </div>
                    </div>

                    <!-- Fila 3 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="brix">Brix:</label>
                            <div class="input-quantity">
                                <button type="button" class="btn-minus quantity-decimal">-</button>
                                <input type="number" id="brix" name="brix" value="0.00" value="1" min="0" step="0.01" required>
                                <button type="button" class="btn-plus quantity-decimal">+</button>
                                </div>
                        </div>
                        <div class="form-group">
                            <label for="observacion">Observaciones:</label>
                            <textarea id="observacion" name="observacion" rows="4"></textarea>
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
                    <table id="tablaMateriaPrimas" class="table table-bordered table-hover table-compact">
    <thead>
        <tr>
            <th>Fecha</th>
            <th>Lote</th>
            <th>Proveedor</th>
            <th>Fruta</th>
            
            <th>Cant. Inicial</th>
            <th>Cant. Disp.</th>
            <th>Precio Unit.</th>
            <th>Precio Total</th>
            <th>Brix</th>
            <th>Observación</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>


                </div>
            </section>
        </div>


           <!-- Main Footer -->
           <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>Copyright &copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>.</strong> Derechos Reservados.
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="JS/invFrutas.js"></script>
    <script src="JS/DTesp.js"></script>
    
    <script src="JS/cerrarsesion.js"></script>

    
</body>
</html>