<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../MODELO/modEstadisticas.php";

$action = $_POST['action'];
$estadisticas = new Estadisticas();

switch ($action) {
    case 'obtenerCantidadFrutas':
        obtenerCantidadFrutas($estadisticas);
        break;

    case 'obtenerCantidadProveedores':
        obtenerCantidadProveedores($estadisticas);
        break;

    case 'obtenerCantidadPresentaciones':
        obtenerCantidadPresentaciones($estadisticas);
        break;

    case 'obtenerCantidadManoObra':
        obtenerCantidadManoObra($estadisticas);
        break;

    case 'obtenerCantidadCostosInd':
        obtenerCantidadCostosInd($estadisticas);
        break;

    case 'obtenerEntradasPorCategoria':
        obtenerEntradasPorCategoria($estadisticas);
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function obtenerCantidadFrutas($estadisticas) {
    $data = $estadisticas->obtenerCantidadFrutas();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerCantidadProveedores($estadisticas) {
    $data = $estadisticas->obtenerCantidadProveedores();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerCantidadPresentaciones($estadisticas) {
    $data = $estadisticas->obtenerCantidadPresentaciones();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerCantidadManoObra($estadisticas) {
    $data = $estadisticas->obtenerCantidadManoObra();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerCantidadCostosInd($estadisticas) {
    $data = $estadisticas->obtenerCantidadCostosInd();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerEntradasPorCategoria($estadisticas) {
    $mes = $_POST['mes'];
    $anio = $_POST['anio'];
    $data = $estadisticas->obtenerEntradasPorCategoria($mes, $anio);
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}
?>