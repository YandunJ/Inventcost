<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modPresent.php";

// Captura la acción enviada por el cliente
$action = $_POST['action'] ?? ($_GET['action'] ?? '');

switch ($action) {
    case 'registrarPresentacion':
        registrarPresentacion();
        break;
    case 'actualizarPresentacion':
        actualizarPresentacion();
        break;
    case 'obtenerPresentacionPorId':
        obtenerPresentacionPorId();
        break;
    case 'obtenerTodasPresentaciones':
        obtenerTodasPresentaciones();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

// Funciones relacionadas
function registrarPresentacion() {
    $prs_nombre = $_POST['prs_nombre'];
    $prs_abreviacion = $_POST['prs_abreviacion'] ?? null;
    $prs_estado = $_POST['prs_estado'];
    $ctg_id = $_POST['ctg_id'];
    $equivalencia = $_POST['equivalencia'];

    $presentacion = new Presentacion();
    $result = $presentacion->gestionarPresentacion(1, 0, $prs_nombre, $prs_abreviacion, $prs_estado, $ctg_id, $equivalencia);

    // Verifica si el SP devolvió un resultado
    if ($result === true || ($result && $result->fetch_assoc()['message'] === 'Success')) {
        echo json_encode(['status' => 'success', 'message' => 'Presentación registrada correctamente']);
    } else {
        http_response_code(500);
        echo json_encode(['status' => 'error', 'message' => 'Error al registrar la presentación']);
    }
}


function actualizarPresentacion() {
    $prs_id = $_POST['prs_id'];
    $prs_nombre = $_POST['prs_nombre'];
    $prs_abreviacion = $_POST['prs_abreviacion'] ?? null;
    $prs_estado = $_POST['prs_estado'];
    $ctg_id = $_POST['ctg_id'];
    $equivalencia = $_POST['equivalencia'];

    $presentacion = new Presentacion();
    $result = $presentacion->gestionarPresentacion(2, $prs_id, $prs_nombre, $prs_abreviacion, $prs_estado, $ctg_id, $equivalencia);
    if ($result) {
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Error al actualizar la presentación']);
    }
}

function obtenerPresentacionPorId() {
    $prs_id = $_POST['prs_id'];
    $presentacion = new Presentacion();
    $result = $presentacion->obtenerPresentacionPorId($prs_id);
    echo json_encode($result);
}

function obtenerTodasPresentaciones() {
    $presentacion = new Presentacion();
    $result = $presentacion->obtenerTodasPresentaciones();
    $presentaciones = [];
    while ($row = $result->fetch_assoc()) {
        $presentaciones[] = $row;
    }
    echo json_encode($presentaciones);
}
?>