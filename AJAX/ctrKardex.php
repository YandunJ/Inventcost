<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modKardex.php";

$kardex = new Kardex();

$action = $_POST['action'] ?? '';

switch ($action) {
    case 'getKardex':
        getKardex($kardex);
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function getKardex($kardex) {
    $categoria_id = $_POST['categoria_id'];
    $fecha_inicio = $_POST['fecha_inicio'];
    $fecha_fin = $_POST['fecha_fin'];

    $data = $kardex->obtenerKardex($categoria_id, $fecha_inicio, $fecha_fin);
    echo json_encode(['status' => 'success', 'data' => $data]);
}
?>