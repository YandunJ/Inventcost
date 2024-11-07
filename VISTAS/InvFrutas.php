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
    <link rel="stylesheet" href="../FILES/InvMPModal.css">
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
                            <input type="hidden" id="id_inv" name="id_inv">

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
                                            <select id="id_articulo" name="id_articulo" class="form-control" required>
                                                <option value="">Seleccione una fruta</option>
                                            </select>
                                            <p><a href="InventCatalogo.php">Revise o agregue nuevas frutas al catálogo</a></p>
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
                            <!-- CAMPO Precio total ELIMINADO -->


                            </div>

                           
                            <!-- Brix, Presentación, Bultos o Canastas, Peso Unitario -->
                            <div class="form-section">
                            <div class="form-group">
                                    <label for="presentacion">Presentación:</label>
                                    <select id="presentacion" name="presentacion" class="form-control" required>
                                        <option value="cajas">Cajas</option>
                                        <option value="bultos">Bultos</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="brix">Brix:</label>
                                    <input type="number" step="0.01" id="brix" name="brix" class="form-control" required>
                                </div>
                               
                            </div>

                            <div class="form-section">
                                <div class="form-group">
                                    <label for="bultos_o_canastas">Bultos o Canastas:</label>
                                    <input type="number" id="bultos_o_canastas" name="bultos_o_canastas" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="peso_unitario">Peso Unitario (Kg):</label>
                                    <input type="number" step="0.01" id="peso_unitario" name="peso_unitario" class="form-control" required>
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
                                <button type="submit" class="btn btn-primary">Agregar</button>
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

        <!-- Modal de Detalles -->
<div class="modal fade" id="detalleModal" tabindex="-1" role="dialog" aria-labelledby="detalleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalleModalLabel">Detalles del Lote</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
    <!-- Sección de Información General -->
    <div class="modal-section">
        <div class="modal-section-title">Información General</div>
        <p><strong>Fecha de Ingreso:</strong> <span id="detalleFecha"></span></p>
        <p><strong>Hora de Ingreso:</strong> <span id="detalleHora"></span></p>
        <p><strong>Número de Lote:</strong> <span id="detalleLote"></span></p>
        <p><strong>Proveedor:</strong> <span id="detalleProveedor"></span></p>
    </div>

    <!-- Sección de Detalles de Artículo -->
    <div class="modal-section">
        <div class="modal-section-title">Detalles de Artículo</div>
        <p><strong>Artículo:</strong> <span id="detalleArticulo"></span></p>
        <p><strong>Cantidad Ingresada:</strong> <span id="detalleCantidadIngresada"></span></p>
        <p><strong>Cantidad Disponible:</strong> <span id="detalleCantidadRestante"></span></p>
        <p><strong>Unidad de Medida:</strong> <span id="detalleUnidadMedida"></span></p>
        <p><strong>Presentación:</strong> <span id="detallePresentacion"></span></p>
    </div>

    <!-- Sección de Precios -->
    <div class="modal-section">
        <div class="modal-section-title">Precios</div>
        <p><strong>Precio Unitario:</strong> <span id="detallePrecioUnitario"></span></p>
        <p><strong>Precio Total:</strong> <span id="detallePrecioTotal"></span></p>
    </div>

    <!-- Sección de Información Adicional -->
    <div class="modal-section">
        <div class="modal-section-title">Información Adicional</div>
        <p><strong>Estado:</strong> <span id="detalleEstado"></span></p>
        <p><strong>Brix:</strong> <span id="detalleBrix"></span></p>
        <p><strong>Peso Unitario:</strong> <span id="detallePesoUnitario"></span></p>
        <p><strong>Bultos o Canastas:</strong> <span id="detalleBultos"></span></p>
    </div>

    <!-- Sección de Observaciones y Aprobación -->
    <div class="modal-section">
        <div class="modal-section-title">Observaciones y Aprobación</div>
        <p><strong>Observación:</strong> <span id="detalleObservacion"></span></p>
        <p><strong>Aprobación del Lote:</strong> <span id="detalleAprobacion"></span></p>
    </div>
</div>
 

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
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