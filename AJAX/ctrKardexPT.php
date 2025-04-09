<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modKardexPT.php";

$kardexPT = new KardexPT();

$action = $_POST['action'] ?? '';

if ($action === 'getKardexPT') {
    getKardexPT($kardexPT);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
}

function getKardexPT($kardexPT) {
    $fecha_inicio = $_POST['fecha_inicio'];
    $fecha_fin = $_POST['fecha_fin'];

    $data = $kardexPT->obtenerKardexPT($fecha_inicio, $fecha_fin);
    echo json_encode(['status' => 'success', 'data' => $data]);
}

function getDetalleKardexPT($kardexPT) {
    $presentacion = $_POST['presentacion'];
    $fecha_inicio = $_POST['fecha_inicio'];
    $fecha_fin = $_POST['fecha_fin'];

    $data = $kardexPT->obtenerDetalleKardexPT($presentacion, $fecha_inicio, $fecha_fin);
    echo json_encode(['status' => 'success', 'data' => $data]);
}
?>