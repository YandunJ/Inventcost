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
        error_log("Datos recibidos en cargarKardex: " . print_r($_POST, true));
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
        $fechaInicio = $_POST['fechaInicio'] ?? null;
        $fechaFin = $_POST['fechaFin'] ?? null;

        if (!$articuloId || !$fechaInicio || !$fechaFin) {
            throw new Exception("Faltan parámetros obligatorios: artículo o fechas.");
        }

        $datos = $kardexModel->obtenerEntradas($articuloId, $fechaInicio, $fechaFin);
        
        if (empty($datos)) {
            echo json_encode(['status' => 'error', 'message' => 'No se encontraron registros.']);
        } else {
            echo json_encode(['status' => 'success', 'data' => $datos]);
        }
    } catch (Exception $e) {
        error_log("Error en cargarEntradas: " . $e->getMessage());
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}



?>