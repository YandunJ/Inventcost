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
            <div class="form-container"> <!-- Contenedor para centrar el formulario -->
            
                        <form id="InsumosForm">
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

                          <!-- Insumo y Proveedor -->
                                    <div class="form-section">
                                        <div class="form-group">
                                        <label for="id_articulo">Insumo:</label>
                                <select id="id_articulo" name="id_articulo" class="form-control" required>
                                    <option value="">Seleccione un insumo</option>
                                </select>
                                <p><a href="InventCatalogo.php">Revise o agregue nuevo insumos al catálogo</a></p>
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
                            </div>
                              <!-- Número de Lote -->
                              <div class="form-section">
                            
                                                            <!-- Cantidad Ingresada y Unidad de Medida -->

                                <div class="form-group">
                                    <label for="cantidad_ingresada">Cantidad Ingresada :</label>
                                    <input type="number" step="0.01" id="cantidad_ingresada" name="cantidad_ingresada" class="form-control" required>

                                </div>
                                <div class="form-group">
                                    <label for="unidad_medida">Unidad de Medida:</label>
                                    <input type="text" id="unidad_medida" name="unidad_medida" class="form-control" readonly>
                                </div>

                            </div>

                            
                         

                            <!-- Precio Unitario y Precio Total -->
                            <div class="form-section">
                                <div class="form-group">
                                    <label for="precio_unitario">Precio Unitario:</label>
                                    <input type="number" step="0.01" id="precio_unitario" name="precio_unitario" class="form-control" required>
                                </div>
                            <!-- CAMPO Precio total ELIMINADO -->
                            <div class="form-group">
                                    <label for="presentacion">Presentación:</label>
                                    <select id="presentacion" name="presentacion" class="form-control" required>
                                        <option value="cajas">Cajas</option>
                                        <option value="bultos">Bultos</option>
                                    </select>
                                </div>

                            </div>

                           
                            <!-- Brix, Presentación, Bultos o Canastas, Peso Unitario -->
                            <div class="form-section">
                       
                        
                               
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
