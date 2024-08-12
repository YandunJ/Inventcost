<?php
// AJAX/ctrProduccionMP.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProduccionMP.php";

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'obtenerMateriaPrima':
        cargarMateriaPrima();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function cargarMateriaPrima() {
    global $conn;
    $produccionMP = new ProduccionMateriaPrima();
    
    try {
        $data = $produccionMP->obtenerMateriaPrima();
        echo json_encode(['status' => 'success', 'data' => $data]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>
