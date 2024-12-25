<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kardex de Inventario</title>
    <link rel="stylesheet" href="../FILES/global.css">
    <style>
        /* Estilo específico para el datepicker */
        #monthPicker {
            cursor: pointer; /* Cambiar el cursor al pasar sobre el campo */
            background-color: #f8f9fa; /* Fondo claro */
            border: 1px solid #ced4da; /* Borde gris claro */
            border-radius: 0.25rem; /* Bordes redondeados */
            padding: 0.375rem 0.75rem; /* Espaciado interno */
            font-size: 1rem; /* Tamaño de fuente */
        }

        #monthPicker:focus {
            border-color: #80bdff; /* Borde azul claro al enfocar */
            outline: 0; /* Quitar el borde de enfoque predeterminado */
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* Sombra azul clara al enfocar */
        }

        .datepicker-dropdown {
            z-index: 1050 !important; /* Asegurar que el datepicker se muestre sobre otros elementos */
        }

        .datepicker table tr td,
        .datepicker table tr th {
            padding: 0.5rem; /* Espaciado interno en las celdas */
            text-align: center; /* Centrar el texto */
            vertical-align: middle; /* Centrar verticalmente */
        }

        .datepicker table tr td.day:hover,
        .datepicker table tr td.day.focused {
            background: #007bff; /* Fondo azul al pasar el cursor */
            color: #fff; /* Texto blanco al pasar el cursor */
        }
    </style>
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <?php include 'MODULOS/ModuloNavbar.php'; ?>
        <?php include 'MODULOS/MDAdminSidebar.php'; ?>

        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Kardex de Inventario</h1>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="monthPicker">Mes Inventario:</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="far fa-calendar-alt"></i>
                                </span>
                                <input type="text" id="monthPicker" class="form-control" placeholder="MM/AAAA" readonly>
                                <div class="input-group-append"></div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="selectCategoria">Categoría:</label>
                            <select id="selectCategoria" class="form-control">
                                <option value="MP">Materia Prima</option>
                                <option value="INS">Insumos</option>
                                <option value="PT">Producto Terminado</option>
                            </select>
                        </div>

                        <div class="col-md-4 text-right">
                            <button class="btn btn-primary mt-4" id="btnFiltrar">
                                <i class="fas fa-search"></i> Consultar
                            </button>
                            <button id="btnReporteEntradas" class="btn btn-primary">Imp. Reporte</button>
                        </div>
                    </div>

                    <table id="tablaKardex" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>Artículo</th>
                                <th>Categoría</th>
                                <th>Presentación</th>
                                <th>Unidad</th>
                                <th>Entradas</th>
                                <th>Salidas</th>
                                <th>Saldo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>

    <!-- Modal para mostrar los registros de entradas -->
    <div class="modal fade" id="modalEntradas" tabindex="-1" role="dialog" aria-labelledby="modalEntradasLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-entradas" role="document"> <!-- Aplicar la clase CSS específica -->
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalEntradasLabel">Registros de Entradas</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tablaEntradas" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>Fecha y Hora</th>
                                <th>Lote</th>
                                <th>Proveedor</th>
                                <th>Artículo</th>
                                <th>Presentación</th>
                                <th>Cant. Inicial</th>
                                <th>Cant. Disp.</th>
                                <th>Precio Unit.</th>
                                <th>Precio Total</th>
                                <th>Estado</th>
                                <th>Brix</th>
                                <th>Observación</th>
                                <th>Tipo Movimiento</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.5/js/dataTables.responsive.min.js"></script>
    <script src="JS/kardex.js"></script>
    <script src="JS/validaciones.js"></script>
    <script src="JS/cerrarsesion.js"></script>
</body>
</html>