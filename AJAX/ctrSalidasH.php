<?php
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modSalidasH.php";

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'obtenerHistorialSalidas':
        obtenerHistorialSalidas();
        break;
    case 'obtenerDetallesSalida':
        obtenerDetallesSalida();
        break;
    case 'cancelarDespacho':
        cancelarDespacho();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function obtenerHistorialSalidas() {
    $historialSalidas = new HistorialSalidas();
    
    try {
        $data = $historialSalidas->obtenerHistorialSalidas();
        echo json_encode(['status' => 'success', 'data' => $data]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerDetallesSalida() {
    $idDespacho = isset($_POST['idDespacho']) ? $_POST['idDespacho'] : null;

    if (!$idDespacho) {
        echo json_encode(['status' => 'error', 'message' => 'ID de despacho no proporcionado']);
        return;
    }

    $historialSalidas = new HistorialSalidas();
    
    try {
        $data = $historialSalidas->obtenerDetallesSalida($idDespacho);
        echo json_encode(['status' => 'success', 'data' => $data]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
function cancelarDespacho() {
    $idDespacho = isset($_POST['idDespacho']) ? $_POST['idDespacho'] : null;

    if (!$idDespacho) {
        echo json_encode(['status' => 'error', 'message' => 'ID de despacho no proporcionado']);
        return;
    }

    $historialSalidas = new HistorialSalidas();
    
    try {
        $response = $historialSalidas->cancelarDespacho($idDespacho);
        echo json_encode($response); // Devolver la respuesta del SP
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>