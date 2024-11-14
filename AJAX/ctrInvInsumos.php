<?php
//AJAX/ctrInvInsumos.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvInsumos.php"; // Asegúrate de que este archivo exista
require_once "../MODELO/sbinsumos.php"; // El modelo de insumos

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
        case 'cargarInsumos':
        cargarInsumos();
            break;
        case 'cargarProveedores':
        cargarProveedores();
            break;
        case 'guardarInsumo':
            guardarInsumo();
            break;
        case 'cargarInsumosTabla':
            cargarInsumosTabla();
            break;
            
        case 'eliminarInsumo':
            eliminarInsumo();
            break;
        case 'cargarInsumoId':
            cargarInsumoId();
                break;
      
        default:
            echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
            break;
    }

function cargarInsumos() {
    global $conn;
    $insumosModel = new InsumosModel($conn); // Instanciar el modelo
    $insumos = $insumosModel->obtenerInsumos(); // Obtener insumos

    if (!$insumos) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los insumos']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $insumos]); // Enviar datos como respuesta JSON
    }
}


function cargarProveedores() {
    global $conn;
    $insumosModel = new InsumosModel($conn);
    $proveedores = $insumosModel->obtenerProveedores();

    if (!$proveedores) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los proveedores']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $proveedores]);
    }
}


function guardarInsumo() {
    global $conn;
    $insumosModel = new InventarioInsumos();

    $inventins_id = isset($_POST['inventins_id']) && $_POST['inventins_id'] !== '' ? $_POST['inventins_id'] : null;
    $insumo_id = $_POST['insumo_id'];
    $proveedor_id = $_POST['proveedor_id'];
    $fecha_cad = $_POST['fecha_cad'];
    $unidad_medida = $_POST['unidad_medida'];
    $cantidad = $_POST['cantidad'];
    $precio_unitario = $_POST['precio_unitario'];
    $precio_total = $_POST['precio_total'];

    try {
        $insumosModel->insertarActualizar($inventins_id, $insumo_id, $proveedor_id, $fecha_cad, $unidad_medida, $cantidad, $precio_unitario, $precio_total);
        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}


function cargarInsumosTabla() {
    global $conn;
    $insumosModel = new InventarioInsumos();
    $data = $insumosModel->obtenerInvenInsumos(); // Asegúrate de que este método esté definido en el modelo

    if ($data) {
        echo json_encode(['status' => 'success', 'data' => $data]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los insumos del inventario.']);
    }
}


function cargarInsumoId() {
    global $conn;
    $inventins_id = $_POST['inventins_id'];
    $insumosModel = new InventarioInsumos();
    $data = $insumosModel->obtenerInvenInsumoPorId($inventins_id);
    if ($data) {
        echo json_encode(['status' => 'success', 'data' => $data]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No se pudo obtener el insumo.']);
    }
}

function eliminarInsumo() {
    global $conn;
    $inventins_id = $_POST['inventins_id'];
    $insumosModel = new InventarioInsumos();
    try {
        $insumosModel->eliminar($inventins_id);
        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

?>