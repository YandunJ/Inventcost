<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Insumos</title>
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <?php include 'MODULOS/ModuloAdminNavbar.php';?>
        <?php include 'MODULOS/ModuloAdminSidebar.php';?>

        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <h1 class="text-center">Gestión de Insumos</h1>
                    <div class="form-container">
                        <form id="insumoForm">
                            <div class="form-group">
                                <label for="nombre">Nombre del Insumo:</label>
                                <input type="text" id="nombre" name="nombre" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="descripcion">Descripción:</label>
                                <input type="text" id="descripcion" name="descripcion" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="destinado_a">Destinado a:</label>
                                <select id="destinado_a" name="destinado_a" class="form-control" required>
                                    <option value="">Seleccione...</option>
                                    <option value="Producción">Producción</option>
                                    <option value="Producto Terminado">Producto Terminado</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="unidad_medida">Unidad de Medida:</label>
                                <select id="unidad_medida" name="unidad_medida" class="form-control" required>
                                    <option value="">Seleccione...</option>
                                    <option value="unidad">Unidad</option>
                                    <option value="litros">Litros</option>
                                    <option value="gramos">Gramos</option>
                                    <option value="kilogramos">Kilogramos</option>
                                    <option value="mililitros">Mililitros</option>
                                    <option value="metros">Metros</option>
                                    <option value="piezas">Piezas</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Agregar Insumo</button>
                        </form>
                    </div>
                    <hr>
                    <table id="insumosTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Unidad de Medida</th>
                                <th>Destino</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Rows will be populated dynamically from the backend -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="dist/js/adminlte.min.js"></script>
        <script src="JS/insumos.js"></script>
        <script src="JS/cerrarsesion.js"></script>
    </div>
</body>
</html>
