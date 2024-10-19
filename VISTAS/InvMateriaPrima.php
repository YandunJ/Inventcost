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
    <link rel="stylesheet" href="../FILES/centrForm.css">
    <style>
.table td {
    text-align: center; /* Centra todo el contenido en las celdas */
}

.form-check-input {
    margin: 0; /* Elimina el margen para que no se desplace */
}
    </style>
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <?php include 'MODULOS/ModuloNavbar.php';?>
        <?php include 'MODULOS/MDAdminSidebar.php';?>
        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Gestión de Materia Prima</h1>
                    <div class="form-container">
                        <form id="materiaPrimaForm">
                            <input type="hidden" id="mp_id" name="mp_id">

                            <div class="form-group">
                                <label for="fruta_id">Fruta:</label>
                                <select id="fruta_id" name="fruta_id" class="form-control" required>
                                    <option value="">Seleccione una fruta</option>
                                </select>                                
                            </div>
                            <a href="frutas.php" class="btn btn-primary btn-sm">Agregar Fruta</a>
                            <div class="form-group">
                                <label for="fecha_cad">Fecha Limite de Producción:</label>
                                <input type="date" id="fecha_cad" name="fecha_cad" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="proveedor_id">Proveedor:</label>
                                <select id="proveedor_id" name="proveedor_id" class="form-control" required>
                                    <option value="">Seleccione un proveedor</option>
                                </select>
                            </div>
                            <a href="proveedores.php" class="btn btn-primary btn-sm">Agregar Proveedor</a>
                            <div class="form-group">
                                <label for="cantidad">Cantidad Kilogramos (kg):</label>
                                <input type="number" step="0.01" id="cantidad" name="cantidad" class="form-control" placeholder="Ej: 50.25" required>
                            </div>
                            <div class="form-group">
                                <label for="precio_unit">Precio por Kilogramo (p x kg):</label>
                                <input type="number" step="0.01" id="precio_unit" name="precio_unit" class="form-control" placeholder="Ej: 3.50" required>
                            </div>
                            <div class="form-group">
                                <label for="precio_total">Precio Total:</label>
                                <input type="number" step="0.01" id="precio_total" name="precio_total" class="form-control" readonly>
                            </div>
                            <div class="form-group">
                                <label for="birx">Brix:</label>
                                <input type="number" step="0.01" id="birx" name="birx" class="form-control" required placeholder="Ej: 12.5">
                            </div>
                            <div class="form-group">
                                <label for="presentacion">Presentación:</label>
                                <select id="presentacion" name="presentacion" class="form-control" required>
                                    <option value="cajas">Cajas</option>
                                    <option value="bultos">Bultos</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="observaciones">Observaciones:</label>
                                <textarea id="observaciones" name="observaciones" class="form-control" required placeholder="Escriba sus observaciones aquí..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary ">Agregar Materia Prima</button>
                            <button type="button" class="btn btn-secondary" id="cancelarBtn">Cancelar</button>

                        </form>
                    </div>
                    <hr>
                    <table id="tablaMateriaPrimas" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Fruta</th>
                            <th>Fecha y Hora de Ingreso</th>
                            <th>Fecha de Caducidad</th>
                            <th>Proveedor</th>
                            <th>Cantidad (kg)</th>
                            <th>Precio Unitario</th>
                            <th>Precio Total</th>
                            <th>Brix</th>
                            <th>Estado</th>
                            <th>Observaciones</th>
                            <th>Acciones</th>
                            <th>Aprobación</th> <!-- Nueva columna para aprobación -->
                        </tr>
                    </thead>

                        <tbody></tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="JS/InvenMateriaP.js"></script>
    <script src="JS/cerrarsesion.js"></script>
    
</body>
</html>
