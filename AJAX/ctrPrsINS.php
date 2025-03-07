<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modPrsINS.php";

// Captura la acción enviada por el cliente
$action = $_POST['action'] ?? ($_GET['action'] ?? '');

switch ($action) {
    case 'obtenerPresentacionesInsumos':
        obtenerPresentacionesInsumos();
        break;
    case 'obtenerPresentacionPorId':
        obtenerPresentacionPorId();
        break;
    case 'addPresentacion':
        gestionarPresentacion(1);
        break;
    case 'updatePresentacion':
        gestionarPresentacion(2);
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

// Funciones relacionadas
function obtenerPresentacionesInsumos() {
    $presentacion = new PresentacionInsumos();
    $result = $presentacion->obtenerPresentacionesInsumos();
    $presentaciones = [];
    while ($row = $result->fetch_assoc()) {
        $presentaciones[] = $row;
    }
    echo json_encode($presentaciones);
}

function obtenerPresentacionPorId() {
    $prs_id = $_POST['prs_id'];
    $presentacion = new PresentacionInsumos();
    $data = $presentacion->obtenerPresentacionPorId($prs_id);
    if (isset($data['error'])) {
        echo json_encode(['status' => 'error', 'message' => $data['error']]);
    } else {
        echo json_encode(['status' => 'success', 'data' => $data]);
    }
}

function gestionarPresentacion($opcion) {
    $prs_id = $_POST['prs_id'];
    $prs_nombre = $_POST['prs_nombre'];
    $prs_abreviacion = $_POST['prs_abreviacion'];

    $presentacion = new PresentacionInsumos();
    $result = $presentacion->gestionarPresentacion($opcion, $prs_id, $prs_nombre, $prs_abreviacion);

    if (isset($result['error'])) {
        echo json_encode(['status' => 'error', 'message' => $result['error']]);
    } else {
        echo json_encode(['status' => 'success', 'message' => 'Operación realizada con éxito']);
    }
}
?>