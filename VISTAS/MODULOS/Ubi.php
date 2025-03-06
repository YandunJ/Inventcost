<?php
function generateBreadcrumb($currentPage) {
    $breadcrumb = '<nav aria-label="breadcrumb"><ol class="breadcrumb">';
    $breadcrumb .= '<li class="breadcrumb-item"><a href="index.php">Inicio</a></li>';

    switch ($currentPage) {
        case 'proveedores.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Proveedores</li>';
            break;
        case 'Presentacion.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Presentaciones</li>';
            break;
        case 'Catalogo.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Catálogo</li>';
            break;
        case 'InvFrutas.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Lotes Frutas</li>';
            break;
        case 'InvInsumos.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Lotes Insumos</li>';
            break;
        case 'PRODUCCION.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Realizar Producción</li>';
            break;
        case 'producto.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Lotes Producto Terminado</li>';
            break;
        case 'Costos.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Costos</li>';
            break;
        case 'VentaPT.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Registrar Venta</li>';
            break;
        case 'Kardex.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Kardex</li>';
            break;
        case 'usuarios.php':
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Mis Usuarios</li>';
            break;
        default:
            $breadcrumb .= '<li class="breadcrumb-item active" aria-current="page">Inicio</li>';
            break;
    }

    $breadcrumb .= '</ol></nav>';
    return $breadcrumb;
}
?>