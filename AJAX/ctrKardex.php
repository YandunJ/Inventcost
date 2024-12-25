<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modKardex.php";

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'cargarKardex':
        cargarKardex();
        break;
    case 'cargarEntradas':
        cargarEntradas();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function cargarKardex() {
    global $conn;
    $kardexModel = new KardexModel($conn);
    try {
        $fechaInicio = $_POST['fechaInicio'] ?? null;
        $fechaFin = $_POST['fechaFin'] ?? null;
        $categoria = $_POST['categoria'] ?? null;

        if (!$fechaInicio || !$fechaFin || !$categoria) {
            throw new Exception("Faltan parámetros obligatorios.");
        }

        $mapaCategorias = [
            'MP' => 1,
            'INS' => 2,
            'PT' => 3
        ];

        if (!isset($mapaCategorias[$categoria])) {
            throw new Exception("Categoría inválida: $categoria");
        }

        $datos = $kardexModel->obtenerKardex($fechaInicio, $fechaFin, $mapaCategorias[$categoria]);
        echo json_encode(['status' => 'success', 'data' => $datos]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function cargarEntradas() {
    global $conn;
    $kardexModel = new KardexModel($conn);
    try {
        $articuloId = $_POST['articuloId'] ?? null;

        if (!$articuloId) {
            throw new Exception("Falta el ID del artículo.");
        }

        $datos = $kardexModel->obtenerEntradas($articuloId);
        error_log(print_r($datos, true)); // Usar error_log para depurar
        echo json_encode(['status' => 'success', 'data' => $datos]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>