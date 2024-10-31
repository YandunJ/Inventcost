<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Materia Prima</title>
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="../FILES/InvMPform.css">

</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <?php include 'MODULOS/ModuloNavbar.php'; ?>
        <?php include 'MODULOS/MDAdminSidebar.php'; ?>
        
        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Gestión de Materia Prima</h1>

                    <div class="form-container">
                        <form id="materiaPrimaForm">
                            <input type="hidden" id="mp_id" name="mp_id">

                            <!-- Fecha y Hora -->
                            <div class="form-section">
                                <div class="form-group">
                                    <label for="fecha">Fecha de Ingreso:</label>
                                    <input type="date" id="fecha" name="fecha" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="hora">Hora de Ingreso:</label>
                                    <input type="time" id="hora" name="hora" class="form-control" required>
                                </div>
                            </div>

                          <!-- Fruta y Proveedor -->
                                    <div class="form-section">
                                        <div class="form-group">
                                            <label for="id_articulo">Fruta:</label>
                                            <select id="fruta_id" name="fruta_id" class="form-control" required>
                                                <option value="">Seleccione una fruta</option>
                                            </select>
                                            <p><a href="InventCatalogo.php">Revise o agregue nuevas frutas al catalogo</a></p>
                                        </div>
                                        <div class="form-group">
                                            <label for="proveedor_id">Proveedor:</label>
                                            <select id="proveedor_id" name="proveedor_id" class="form-control" required>
                                                <option value="">Seleccione un proveedor</option>
                                            </select>
                                            <p><a href="proveedores.php">Revise o agregue un nuevo porveedor</a></p>
                                        </div>
                                    </div>

                            <!-- Número de Lote -->
                            <div class="form-section">
                                <div class="form-group">
                                    <label for="numero_lote">N Lote:</label>
                                    <input type="text" id="numero_lote" name="numero_lote" class="form-control" required>
                                </div>
                                                            <!-- Cantidad Ingresada y Unidad de Medida -->

                                <div class="form-group">
                                    <label for="cantidad_ingresada">Cantidad Ingresada (Kg ):</label>
                                    <input type="number" step="0.01" id="cantidad_ingresada" name="cantidad_ingresada" class="form-control" required>

                                </div>
                            </div>

                         

                            <!-- Precio Unitario y Precio Total -->
                            <div class="form-section">
                                <div class="form-group">
                                    <label for="precio_unitario">Precio Unitario:</label>
                                    <input type="number" step="0.01" id="precio_unitario" name="precio_unitario" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="precio_total">Precio Total:</label>
                                    <input type="number" step="0.01" id="precio_total" name="precio_total" class="form-control" readonly>
                                </div>
                            </div>

                            <!-- Brix y Presentación -->
                            <div class="form-section">
                                <div class="form-group">
                                    <label for="brix">Brix:</label>
                                    <input type="number" step="0.01" id="brix" name="brix" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="presentacion">Presentación:</label>
                                    <select id="presentacion" name="presentacion" class="form-control" required>
                                        <option value="cajas">Cajas</option>
                                        <option value="bultos">Bultos</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Observaciones -->
                            <div class="form-section">
                                <div class="form-group full">
                                    <label for="observacion">Observaciones:</label>
                                    <textarea id="observacion" name="observacion" class="form-control"></textarea>
                                </div>
                            </div>

                            <!-- Botones -->
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Agregar Materia Prima</button>
                                <button type="button" class="btn btn-secondary" id="cancelarBtn">Cancelar</button>
                            </div>
                        </form>
                    </div>

                    <hr>
                        <table id="tablaMateriaPrimas" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Hora</th>
                                    <th>Lote</th>
                                    <th>Proveedor</th>
                                    <th>Artículo</th>
                                    <th>Stock</th>
                                    <th>Estado</th>
                                    <th>Precio Total</th>
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
                Custom footer text
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
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>