<?php
// filepath: /c:/inetpub/wwwroot/adfrutas/AJAX/ctrVentaPT.php

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modVentaPT.php";

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'obtenerInventarioPT':
        obtenerInventarioPT();
        break;
    case 'registrarDespacho':
        registrarDespacho();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function obtenerInventarioPT() {
    $ventaPT = new VentaPT();
    
    try {
        $inventario = $ventaPT->obtenerInventarioPT();
        if (isset($inventario['error'])) {
            throw new Exception($inventario['error']);
        }
        echo json_encode(['status' => 'success', 'data' => $inventario]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function registrarDespacho() {
    $ventaPT = new VentaPT();
    
    $despacho = isset($_POST['despacho']) ? $_POST['despacho'] : null;
    $precio_total = isset($_POST['precio_total']) ? $_POST['precio_total'] : null;

    if ($despacho === null || $precio_total === null) {
        echo json_encode(['status' => 'error', 'message' => 'Faltan datos para el despacho']);
        return;
    }

    try {
        $result = $ventaPT->registrarDespacho($despacho, $precio_total);
        if (isset($result['error'])) {
            throw new Exception($result['error']);
        }
        echo json_encode(['status' => 'success', 'message' => $result['message']]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>
