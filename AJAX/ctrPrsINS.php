<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modPrsINS.php";

// Captura la acción enviada por el cliente
$action = $_POST['action'] ?? ($_GET['action'] ?? '');

switch ($action) {
    case 'obtenerPresentacionesInsumos':
        obtenerPresentacionesInsumos();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

// Funciones relacionadas
function obtenerPresentacionesInsumos() {
    $presentacion = new PresentacionInsumos();
    $result = $presentacion->obtenerPresentacionesInsumos();
    $presentaciones = [];
    while ($row = $result->fetch_assoc()) {
        $presentaciones[] = $row;
    }
    echo json_encode($presentaciones);
}
?>