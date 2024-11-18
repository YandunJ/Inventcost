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
                            <!-- Opciones llenadas dinámicamente -->
                        </select>
                    </div>
                    <hr>
                    <table id="insumosTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre del Insumo</th>
                                <th>Cantidad Disponible</th>
                                <th>Cantidad a Usar</th>
                                <th>Precio Unitario</th>
                                <th>Seleccionar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Filas llenadas dinámicamente -->
                        </tbody>
                    </table>
                    <button type="submit" class="btn btn-primary">Registrar Consumo de Insumos</button>
                </form>
            </div>
        </section>
    </div>
    <footer class="main-footer">
        <!-- Contenido del pie de página -->
    </footer>
</div>
<script src="../Public/plugins/jquery/jquery.min.js"></script>
<script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../Public/dist/js/adminlte.min.js"></script>
<script>
    $(document).ready(function() {
        // Datos de ejemplo para producciones
        const producciones = [
            { id: 1, nombre: 'Producción 1' },
            { id: 2, nombre: 'Producción 2' }
        ];
        
        producciones.forEach(produccion => {
            $('#produccion_id').append(new Option(produccion.nombre, produccion.id));
        });

        // Datos de ejemplo para insumos
        const insumos = [
            { id: 1, nombre: 'Saborizante', disponible: 50, precio: 5.00 },
            { id: 2, nombre: 'Acido Citrico', disponible: 30, precio: 7.50 },
            { id: 3, nombre: 'Cofia', disponible: 20, precio: 6.25 }
        ];

        insumos.forEach(insumo => {
            $('#insumosTable tbody').append(`
                <tr>
                    <td>${insumo.id}</td>
                    <td>${insumo.nombre}</td>
                    <td>${insumo.disponible} kg</td>
                    <td><input type="number" class="cantidad-usar" data-id="${insumo.id}" min="0" max="${insumo.disponible}" step="0.1"></td>
                    <td>${insumo.precio}</td>
                    <td><input type="checkbox" name="insumo" value="${insumo.id}" class="check-insumo"></td>
                </tr>
            `);
        });

        // Manejo del formulario
        $('#produccionInsumosForm').submit(function(e) {
            e.preventDefault();

            // Recoge la información seleccionada
            const seleccionados = [];
            $('.check-insumo:checked').each(function() {
                const id = $(this).val();
                const cantidad = $(`.cantidad-usar[data-id="${id}"]`).val();
                seleccionados.push({ id, cantidad });
            });

            alert('Insumos seleccionados:\n' + JSON.stringify(seleccionados, null, 2));
        });
    });
</script>
</body>
</html>
