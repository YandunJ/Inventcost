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
    case 'cargarDetalleKardex':
        cargarDetalleKardex();
        break;
    case 'obtenerCategorias':
        obtenerCategorias();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function cargarKardex() {
    global $conn;
    $kardexModel = new KardexModel($conn);
    try {
        $fecha = $_POST['fecha'] ?? null;
        $categoria = $_POST['categoria'] ?? null;

        if (!$fecha || !$categoria) {
            throw new Exception("Faltan parámetros obligatorios.");
        }

        list($mes, $anio) = explode('/', $fecha);

        $datos = $kardexModel->obtenerKardex((int)$mes, (int)$anio, (int)$categoria);
        echo json_encode(['status' => 'success', 'data' => $datos]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function cargarDetalleKardex() {
    global $conn;
    $kardexModel = new KardexModel($conn);

    try {
        $fechaInicio = $_POST['fechaInicio'] ?? null;
        $fechaFin = $_POST['fechaFin'] ?? null;
        $categoria = $_POST['categoria'] ?? null;
        $articulo = $_POST['articulo'] ?? null;

        if (!$fechaInicio || !$fechaFin || !$categoria || !$articulo) {
            throw new Exception("Faltan parámetros obligatorios.");
        }

        $datos = $kardexModel->obtenerDetalleKardex($fechaInicio, $fechaFin, (int)$categoria, (int)$articulo);
        echo json_encode(['status' => 'success', 'data' => $datos]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerCategorias() {
    global $conn;
    $kardexModel = new KardexModel($conn);

    try {
        $categorias = $kardexModel->obtenerCategorias();
        echo json_encode(['status' => 'success', 'data' => $categorias]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>