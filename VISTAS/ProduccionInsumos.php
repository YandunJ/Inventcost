<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producción de Insumos</title>
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <?php include 'MODULOS/ModuloNavbar.php';?>
    <?php include 'MODULOS/MDAdminSidebar.php';?>

    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <h1>Producción de Insumos</h1>
                <form id="produccionInsumosForm">
                    <div class="form-group">
                        <label for="produccion_id">Producción:</label>
                        <select id="produccion_id" name="produccion_id" class="form-control" required>
                            <!-- Options will be populated dynamically from the backend -->
                        </select>
                    </div>
                    <hr>
                    <table id="insumosTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre del Insumo</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Seleccionar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Rows will be populated dynamically from the backend -->
                        </tbody>
                    </table>
                    <button type="submit" class="btn btn-primary">Registrar Consumo de Insumos</button>
                </form>
            </div>
        </section>
    </div>
    <footer class="main-footer">
        <!-- Footer content here -->
    </footer>
</div>
<script src="../Public/plugins/jquery/jquery.min.js"></script>
<script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../Public/dist/js/adminlte.min.js"></script>
<script>
    $(document).ready(function() {
        // Populate the select box with dummy data
        const producciones = [
            { id: 1, nombre: 'Producción 1' },
            { id: 2, nombre: 'Producción 2' },
            { id: 3, nombre: 'Producción 3' }
        ];
        
        producciones.forEach(produccion => {
            $('#produccion_id').append(new Option(produccion.nombre, produccion.id));
        });

        // Populate the table with dummy data
        const insumos = [
            { id: 1, nombre: 'Saborizante', cantidad: 10, precio: 5.00 },
            { id: 2, nombre: 'Acido Citrico', cantidad: 20, precio: 7.50 },
            { id: 3, nombre: 'Cofia', cantidad: 15, precio: 6.25 }
        ];

        insumos.forEach(insumo => {
            $('#insumosTable tbody').append(`
                <tr>
                    <td>${insumo.id}</td>
                    <td>${insumo.nombre}</td>
                    <td>${insumo.cantidad}</td>
                    <td>${insumo.precio}</td>
                    <td><input type="checkbox" name="insumo" value="${insumo.id}"></td>
                </tr>
            `);
        });

        // Handle form submission
        $('#produccionInsumosForm').submit(function(e) {
            e.preventDefault();
            // Here you would handle the form submission to the backend
            alert('Consumo de insumos registrado');
        });
    });
</script>
</body>
</html>
