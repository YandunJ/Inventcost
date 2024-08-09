<?php
//AJAX/ctrInvenInsumos.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvenInsumos.php"; // Asegúrate de que este archivo exista
require_once "../MODELO/sbinsumos.php"; // El modelo de insumos

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'cargarInsumos':
        cargarInsumos();
        break;
    case 'cargarProveedores':
        cargarProveedores();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function cargarInsumos() {
    global $conn;
    $insumosModel = new InsumosModel($conn);
    $insumos = $insumosModel->obtenerInsumos();

    if (!$insumos) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los insumos']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $insumos]);
    }
}

function cargarProveedores() {
    global $conn;
    $insumosModel = new InsumosModel($conn);
    $proveedores = $insumosModel->obtenerProveedores();

    if (!$proveedores) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los proveedores']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $proveedores]);
    }
}
?>
