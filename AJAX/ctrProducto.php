<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProducto.php";

$accion = isset($_POST['accion']) ? $_POST['accion'] : (isset($_GET['accion']) ? $_GET['accion'] : '');

switch ($accion) {
    case 'obtenerLotesProductoTerminado':
        obtenerLotesProductoTerminado();
        break;
    case 'obtenerDetallesLote':
        obtenerDetallesLote();
        break;
    case 'actualizarObservacion':
        actualizarObservacion();
        break;
    default:
        echo json_encode(['estado' => 'error', 'mensaje' => 'Acción no válida']);
        break;
}

function obtenerLotesProductoTerminado() {
    $producto = new Producto();

    try {
        $lotes = $producto->obtenerLotesProductoTerminado();
        if (isset($lotes['error'])) {
            throw new Exception($lotes['error']);
        }
        echo json_encode(['estado' => 'exito', 'datos' => $lotes]);
    } catch (Exception $e) {
        echo json_encode(['estado' => 'error', 'mensaje' => $e->getMessage()]);
    }
}

function obtenerDetallesLote() {
    $producto = new Producto();
    $lote_PT = $_POST['lote_PT'];

    try {
        $detalles = $producto->obtenerDetallesLote($lote_PT);
        if (isset($detalles['error'])) {
            throw new Exception($detalles['error']);
        }
        echo json_encode(['estado' => 'exito', 'datos' => $detalles]);
        exit; // Asegúrate de que no se agregue nada más después del JSON
    } catch (Exception $e) {
        echo json_encode(['estado' => 'error', 'mensaje' => $e->getMessage()]);
    }
}

function actualizarObservacion() {
    $producto = new Producto();
    $id_pt = $_POST['id_pt'];
    $observacion = $_POST['observacion'];

    try {
        $resultado = $producto->actualizarObservacion($id_pt, $observacion);
        if (isset($resultado['error'])) {
            throw new Exception($resultado['error']);
        }
        echo json_encode(['estado' => 'exito']);
    } catch (Exception $e) {
        echo json_encode(['estado' => 'error', 'mensaje' => $e->getMessage()]);
    }
}
?>