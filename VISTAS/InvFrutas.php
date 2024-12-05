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
    <!-- <link rel="stylesheet" href="../FILES/InvMPform.css"> -->
    <link rel="stylesheet" href="../FILES/InvMPModal.css">
    
<!-- REVISAR LOS ESTILOS QUE SOLO QUEDE LOS NECESARIOS Y EN CASO DE SER UTIL CENTRALIZAR UN ESTILO PARA DEJAR SOLO UNO PARA TODOS -->
    <link rel="stylesheet" href="../FILES/Table-Compact.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <?php include 'MODULOS/ModuloNavbar.php'; ?>
        <?php include 'MODULOS/MDAdminSidebar.php'; ?>
        <!--  -->
        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Inventario de Materia Prima</h1>
                    <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#Form_MP" data-is-new="true">
    Agregar
</button>

                

<div class="modal fade" id="Form_MP" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Registro de Materia Prima</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span> <!-- Cambia el símbolo a "x" -->
                </button>
            </div>
            <div class="modal-body">
                <form id="materiaPrimaForm" class="modal-form-container">
                 <!-- Fila 1 -->
                 <div class="form-row">
                        <div class="form-group">
                            <label for="proveedor_id">Proveedor:</label>
                            <select id="proveedor_id" name="proveedor_id" required>
                                <option value="">Seleccione proveedor</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="id_articulo">Fruta:</label>
                            <select id="id_articulo" name="id_articulo" required>
                                <option value="">Seleccione fruta</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="fecha">Fecha:</label>
                            <input type="date" id="fecha" name="fecha" required>
                        </div>
                        <div class="form-group">
                            <label for="hora">Hora:</label>
                            <input type="time" id="hora" name="hora" required>
                        </div>
                    </div>

                    <!-- Fila 2 -->
                    <div class="form-row">
                    <div class="form-group">
                        <label for="numero_lote">N Lote:</label>
                        <input type="text" id="numero_lote" name="numero_lote" readonly>
                        </div>

                        <div class="form-group">
    <label for="cantidad_ingresada">Cantidad (Kg):</label>
    <div class="input-quantity">
        <button type="button" class="btn-minus quantity-int">-</button>
        <input type="number" id="cantidad_ingresada" name="cantidad_ingresada" value="1" min="0" step="0.01" required>
        <button type="button" class="btn-plus quantity-int">+</button>
    </div>
</div>




<div class="form-group">
    <label for="precio_unitario">Precio Unitario:</label>
    <div class="input-quantity">
        <button type="button" class="btn-minus quantity-decimal">-</button>
        <input type="number" id="precio_unitario" name="precio_unitario" value="0.00" min="0" step="0.01" required>
        <button type="button" class="btn-plus quantity-decimal">+</button>
    </div>
</div>
                        <div class="form-group">
                            <label for="precio_total">Precio Total:</label>
                            <input type="number" id="precio_total" name="precio_total" step="0.01" disabled>
                        </div>
                    </div>

                    <!-- Fila 3 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="presentacion">Presentación:</label>
                            <select id="presentacion" name="presentacion" required>
                                <option value="cajas">Cajas</option>
                                <option value="bultos">Bultos</option>
                            </select>
                        </div>
                        <div class="form-group">
    <label for="brix">Brix:</label>
    <div class="input-quantity">
        <button type="button" class="btn-minus quantity-int">-</button>
        <input type="number" id="brix" name="brix" value="0.00" min="0" step="0.01" required>
        <button type="button" class="btn-plus quantity-int">+</button>
    </div>
</div>
                        <div class="form-group">
                <label for="bultos_o_canastas">Bultos/Canastas:</label>
                <div class="input-quantity">
                    <button type="button" class="btn-minus quantity-int">-</button>
                    <input type="number" id="bultos_o_canastas" name="bultos_o_canastas" value="0" min="0" step="1" required>
                    <button type="button" class="btn-plus quantity-int">+</button>
                </div>
            </div>
            <div class="form-group">
    <label for="peso_unitario">Peso Unitario (Kg):</label>
    <div class="input-quantity">
        <button type="button" class="btn-minus quantity-int">-</button>
        <input type="number" id="peso_unitario" name="peso_unitario" value="0.00" min="0" step="0.01" required>
        <button type="button" class="btn-plus quantity-int">+</button>
    </div>
</div>
</div>

                    <!-- Fila 4 -->
                    <div class="form-group">
                        <label for="observacion">Observaciones:</label>
                        <textarea id="observacion" name="observacion" rows="4"></textarea>
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
                                <th>Lote</th>
                                    <th>Fecha</th>
                                    <th>Hora</th>
                                    
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
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalleModalLabel">Detalles del Lote</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <!-- Columna 1 -->
                        <div class="col-md-4">
                            <h6 class="section-title">Información General</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Fecha de Ingreso</strong></td>
                                        <td id="detalleFecha"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Hora de Ingreso</strong></td>
                                        <td id="detalleHora"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Número de Lote</strong></td>
                                        <td id="detalleLote"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Proveedor</strong></td>
                                        <td id="detalleProveedor"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- Columna 2 -->
                        <div class="col-md-4">
                            <h6 class="section-title">Detalles de Artículo</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Artículo</strong></td>
                                        <td id="detalleArticulo"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Cantidad Ingresada</strong></td>
                                        <td id="detalleCantidadIngresada"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Cantidad Disponible</strong></td>
                                        <td id="detalleCantidadRestante"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Unidad de Medida</strong></td>
                                        <td id="detalleUnidadMedida"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Presentación</strong></td>
                                        <td id="detallePresentacion"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- Columna 3 -->
                        <div class="col-md-4">
                            <h6 class="section-title">Precios</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Precio Unitario</strong></td>
                                        <td id="detallePrecioUnitario"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Precio Total</strong></td>
                                        <td id="detallePrecioTotal"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <h6 class="section-title">Información Adicional</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Estado</strong></td>
                                        <td id="detalleEstado"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Brix</strong></td>
                                        <td id="detalleBrix"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Peso Unitario</strong></td>
                                        <td id="detallePesoUnitario"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Bultos o Canastas</strong></td>
                                        <td id="detalleBultos"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <h6 class="section-title">Observaciones y Aprobación</h6>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Observación</strong></td>
                                        <td id="detalleObservacion"></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Aprobación del Lote</strong></td>
                                        <td id="detalleAprobacion"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
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