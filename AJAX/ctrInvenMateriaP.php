<?php
// AJAX/ctrInvenMateriaP.php

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvenMateriaP.php";

$database = new Cls_DataConnection();
$db = $database->FN_getConnect();


$materiaPrima = new MateriaPrima();

try {
    switch ($_GET["op"]) {
        case 'guardar':
            // (código existente)
            break;

        case 'listar':
            // (código existente)   
            break;

        case 'eliminar':
            // (código existente)
            break;

        case 'cargarFrutas':
            $rspta = $materiaPrima->cargarFrutas();
            echo json_encode($rspta);
            break;

        case 'cargarProveedores':
            $rspta = $materiaPrima->cargarProveedores();
            echo json_encode($rspta);
            break;

        default:
            throw new Exception("Operación no válida");
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}

?>
