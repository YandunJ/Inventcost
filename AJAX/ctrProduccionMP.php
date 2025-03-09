<?php
//AJAX/ctrProduccionMP.php

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProduccionMP.php";

// Captura la acción enviada por el cliente
$action = $_POST['action'] ?? ($_GET['action'] ?? '');

// Controlador principal
switch ($action) {
    case 'registrarProduccion':
        registrarProduccion();
        break;

    case 'obtenerPresentacionesPT':
        obtenerPresentacionesPT();
        break;

    case 'obtenerProducciones':
        obtenerProducciones();
        break;

    case 'obtenerDetallesProduccion':
        obtenerDetallesProduccion();
        break;

    case 'generarNumeroLotePT':
        generarNumeroLotePT();
        break;

    case 'cancelarProduccion':
        cancelarProduccion();
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function registrarProduccion() {
    $produccion = new Produccion();
    
    $cant_producida = isset($_POST['cant_producida']) ? $_POST['cant_producida'] : 0;
    $lotes_mp = isset($_POST['lotes_mp']) ? $_POST['lotes_mp'] : '[]';
    $lotes_ins = isset($_POST['lotes_ins']) ? $_POST['lotes_ins'] : '[]';
    $mano_obra = isset($_POST['mano_obra']) ? $_POST['mano_obra'] : '[]';
    $costos_indirectos = isset($_POST['costos_indirectos']) ? $_POST['costos_indirectos'] : '[]';
    $presentaciones_pt = isset($_POST['presentaciones_pt']) ? $_POST['presentaciones_pt'] : '[]';
    $lote_pt = isset($_POST['lote_pt']) ? $_POST['lote_pt'] : '';
    $fecha_elaboracion = isset($_POST['fecha_elaboracion']) ? $_POST['fecha_elaboracion'] : date('Y-m-d');

    // Nuevos parámetros para los subtotales y el total de producción
    $subtotal_mtpm = isset($_POST['subtotal_mtpm']) ? $_POST['subtotal_mtpm'] : 0;
    $subtotal_ins = isset($_POST['subtotal_ins']) ? $_POST['subtotal_ins'] : 0;
    $subtotal_mo = isset($_POST['subtotal_mo']) ? $_POST['subtotal_mo'] : 0;
    $subtotal_ci = isset($_POST['subtotal_ci']) ? $_POST['subtotal_ci'] : 0;
    $total_produccion = isset($_POST['total_produccion']) ? $_POST['total_produccion'] : 0;

    try {
        $result = $produccion->registrarProduccion(
            $cant_producida, 
            $lotes_mp, 
            $lotes_ins, 
            $mano_obra, 
            $costos_indirectos, 
            $presentaciones_pt, 
            $lote_pt, 
            $fecha_elaboracion,
            $subtotal_mtpm,
            $subtotal_ins,
            $subtotal_mo,
            $subtotal_ci,
            $total_produccion
        );
        echo json_encode($result);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function cancelarProduccion() {
    $produccion = new Produccion();
    $pro_id = isset($_POST['pro_id']) ? $_POST['pro_id'] : null;

    if (!$pro_id) {
        echo json_encode(['status' => 'error', 'message' => 'ID de producción no proporcionado']);
        return;
    }

    try {
        $result = $produccion->cancelarProduccion($pro_id);
        echo json_encode($result);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function generarNumeroLotePT() {
    try {
        $produccion = new Produccion();
        $numeroLote = $produccion->generarNumeroLotePT();

        echo json_encode(['status' => 'success', 'numero_lote' => $numeroLote]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerPresentacionesPT() {
    $produccion = new Produccion();
    try {
        $data = $produccion->obtenerPresentacionesPT();
        echo json_encode(['status' => 'success', 'data' => $data]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerProducciones() {
    $produccion = new Produccion();
    try {
        $data = $produccion->obtenerProducciones();
        echo json_encode(['status' => 'success', 'data' => $data]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerDetallesProduccion() {
    $produccion = new Produccion();
    $pro_id = isset($_POST['pro_id']) ? $_POST['pro_id'] : null;

    if (!$pro_id) {
        echo json_encode(['status' => 'error', 'message' => 'ID de producción no proporcionado']);
        return;
    }

    try {
        $result = $produccion->obtenerDetallesProduccion($pro_id);
        if ($result) {
            echo json_encode(['status' => 'success', 'data' => $result]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se encontraron datos para la producción especificada']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>