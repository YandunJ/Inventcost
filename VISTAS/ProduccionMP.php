<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producción</title>
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <style>
        .nav-tabs .nav-link.active {
            background-color: #007bff;
            color: white;
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
                <h1>Producción</h1>

                <!-- Datos Generales de Producción -->
                <div class="row">
                    <div class="col-md-4">
                        <label for="fecha_produccion">Fecha de Producción:</label>
                        <input type="datetime-local" id="fecha_produccion" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label for="produccion_id">Seleccionar Producción:</label>
                        <select id="produccion_id" class="form-control">
                            <!-- Opciones de producción dinámicas -->
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="cantidad_producida">Cantidad Producida:</label>
                        <input type="number" id="cantidad_producida" class="form-control">
                    </div>
                </div>

                <!-- Menú de Pestañas -->
                <ul class="nav nav-tabs mt-4" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="materiaPrima-tab" data-toggle="tab" href="#materiaPrima" role="tab">Materia Prima</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="insumos-tab" data-toggle="tab" href="#insumos" role="tab">Insumos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="manoObra-tab" data-toggle="tab" href="#manoObra" role="tab">Mano de Obra</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="costosAsociados-tab" data-toggle="tab" href="#costosAsociados" role="tab">Costos Asociados</a>
                    </li>
                </ul>

                <!-- Contenido de las Pestañas -->
                <div class="tab-content mt-3" id="myTabContent">
                    <!-- Materia Prima -->
                    <div class="tab-pane fade show active" id="materiaPrima" role="tabpanel">
                        <h3>Seleccionar Materia Prima</h3>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Fecha Entrada</th>
                                    <th>Materia Prima</th>
                                    <th>Proveedor</th>
                                    <th>Stock Disponible</th>
                                    <th>Precio Unitario</th>
                                    <th>Cantidad a Consumir</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody id="tablaMateriaPrima">
                                <!-- Filas dinámicas -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Insumos -->
                    <div class="tab-pane fade" id="insumos" role="tabpanel">
                        <h3>Seleccionar Insumos</h3>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Insumo</th>
                                    <th>Proveedor</th>
                                    <th>Stock Disponible</th>
                                    <th>Precio Unitario</th>
                                    <th>Cantidad a Consumir</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody id="tablaInsumos">
                                <!-- Filas dinámicas -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Mano de Obra -->
                    <div class="tab-pane fade" id="manoObra" role="tabpanel">
                        <h3>Mano de Obra</h3>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Empleado</th>
                                    <th>Horas Trabajadas</th>
                                    <th>Costo por Hora</th>
                                    <th>Total</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody id="tablaManoObra">
                                <!-- Filas dinámicas -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Costos Asociados -->
                    <div class="tab-pane fade" id="costosAsociados" role="tabpanel">
                        <h3>Costos Asociados</h3>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Descripción</th>
                                    <th>Costo</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody id="tablaCostosAsociados">
                                <!-- Filas dinámicas -->
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Resumen de Consumo -->
                <div class="mt-4 p-3 border rounded bg-light">
                    <h4>Resumen de Consumo</h4>
                    <p>Total Cantidad a Consumir: <span id="totalCantidad">0</span></p>
                    <p>Costo Total: $<span id="costoTotal">0.00</span></p>
                </div>

                <!-- Botón de Confirmación -->
                <button type="button" class="btn btn-primary mt-3" onclick="confirmarConsumo()">Registrar Producción</button>
            </div>
        </section>
    </div>
</div>

<!-- Scripts -->
<script src="../Public/plugins/jquery/jquery.min.js"></script>
<script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../Public/dist/js/adminlte.min.js"></script>

<script>
    // Función para confirmar consumo de producción
    function confirmarConsumo() {
        alert("Producción registrada.");
    }

    // Función para actualizar el resumen
    function actualizarResumen() {
        // Calcular la cantidad total y el costo total de manera dinámica
        let totalCantidad = 0;
        let costoTotal = 0.00;

        // Actualizar los valores en el DOM
        document.getElementById("totalCantidad").innerText = totalCantidad;
        document.getElementById("costoTotal").innerText = costoTotal.toFixed(2);
    }
</script>
</body>
</html>
