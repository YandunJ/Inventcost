<?php
// filepath: /c:/inetpub/wwwroot/adfrutas/AJAX/ctrProduccionMP.php

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProduccionMP.php";

$conn = (new Cls_DataConnection())->FN_getConnect(); 

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

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
    global $conn;
    $sql = "SELECT prs_id, prs_nombre, equivalencia FROM presentacion WHERE ctg_id = 3 AND prs_estado = 'vigente'";
    $result = $conn->query($sql);

    if (!$result) {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
        return;
    }

    $data = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
    }

    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
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

    try {
        $result = $produccion->registrarProduccion($cant_producida, $lotes_mp, $lotes_ins, $mano_obra, $costos_indirectos, $presentaciones_pt, $lote_pt, $fecha_elaboracion);
        echo json_encode($result);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerProducciones() {
    global $conn;
    $sql = "CALL PROD_data_G()";
    $result = $conn->query($sql);

    if (!$result) {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
        return;
    }

    $data = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
    }

    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
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