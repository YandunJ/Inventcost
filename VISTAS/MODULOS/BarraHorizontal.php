<?php
session_start();
$nombreCompleto = isset($_SESSION['nombre']) ? $_SESSION['nombre'] . ' ' . $_SESSION['apellido'] : 'User Name';
$rolNombre = '';
$rolDescripcion = '';
$estado = isset($_SESSION['estado']) ? $_SESSION['estado'] : 'desconocido';

if (isset($_SESSION['rol_id'])) {
    $rolId = $_SESSION['rol_id'];
    $roles = [
        1 => ['nombre' => 'Administrador', 'descripcion' => 'Tiene acceso completo al sistema'],
        2 => ['nombre' => 'Bodeguero Materia Prima', 'descripcion' => 'Gestiona la materia prima en el inventario'],
        3 => ['nombre' => 'Encargado De Producción', 'descripcion' => 'Encargado de la producción de productos']
    ];
    $rolNombre = isset($roles[$rolId]) ? $roles[$rolId]['nombre'] : 'Desconocido';
    $rolDescripcion = isset($roles[$rolId]) ? $roles[$rolId]['descripcion'] : 'Sin descripción';
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" href="../FILES/STBarraH.css">
<!--     
    <style>
        .modal-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }

        .modal-body {
            font-size: 16px;
            line-height: 1.5;
        }

        .modal-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }

        .modal-footer .btn {
            margin-right: 10px;
        }

        /* Ajustar la posición del modal */
        .modal-dialog {
            position: absolute;
            right: 10px;
            top: 50px;
        }
    </style> -->
</head>
<body>
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="index.php" class="nav-link">Inicio</a>
        </li>
    </ul>
    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
        <!-- User dropdown menu -->
        <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#" data-toggle="modal" data-target="#userModal">
                <i class="far fa-user"></i> <span id="userName"><?php echo $nombreCompleto; ?></span>
            </a>
        </li>
    </ul>
</nav>

<!-- Modal de información del usuario -->
<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userModalLabel">Información del Usuario</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>Nombre:</strong> <?php echo $nombreCompleto; ?></p>
                <p><strong>Rol:</strong> <?php echo $rolNombre; ?></p>
                <p><strong>Descripción del Rol:</strong> <?php echo $rolDescripcion; ?></p>
                <p><strong>Estado:</strong> <?php echo $estado; ?></p>
            </div>
            <div class="modal-footer">
                <a href="logout.php" class="btn btn-danger logout-link">
                    <i class="fas fa-sign-out-alt"></i> Cerrar sesión
                </a>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="../Public/plugins/jquery/jquery.min.js"></script>


<script>
$(document).ready(function() {
    // Manejar el evento de clic en el nombre del usuario
    $('#userName').on('click', function() {
        $('#userModal').modal('toggle');
    });

    // Manejar el evento de clic en el botón de cerrar sesión
    $('.logout-link').on('click', function(e) {
        e.preventDefault();
        window.location.href = 'frlogin.php';
    });
});
</script>
</body>
</html>