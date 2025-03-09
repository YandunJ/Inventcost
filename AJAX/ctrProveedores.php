<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProveedores.php";

$conn = (new Cls_DataConnection())->FN_getConnect();
$proveedores = new Proveedores($conn);

$action = $_POST['action'] ?? '';

switch ($action) {
    case 'addProveedor':
        addProveedor($proveedores);
        break;
    case 'updateProveedor':
        updateProveedor($proveedores);
        break;
    case 'getProveedores':
        getProveedores($proveedores);
        break;
    case 'getProveedorById':
        getProveedorById($proveedores);
        break;
    case 'toggleStatusProveedor':
        toggleStatusProveedor($proveedores);
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function addProveedor($proveedores) {
    $result = $proveedores->prov_CRUD(
        1,
        null,
        $_POST['nombre_empresa'],
        $_POST['representante'],
        $_POST['correo'],
        $_POST['telefono']
    );
    echo json_encode(['status' => $result ? 'success' : 'error']);
}

function updateProveedor($proveedores) {
    $result = $proveedores->prov_CRUD(
        2,
        $_POST['proveedor_id'],
        $_POST['nombre_empresa'],
        $_POST['representante'],
        $_POST['correo'],
        $_POST['telefono']
    );
    echo json_encode(['status' => $result ? 'success' : 'error']);
}

function getProveedores($proveedores) {
    $data = $proveedores->prov_datos();
    echo json_encode(['status' => 'success', 'data' => $data]);
}

function getProveedorById($proveedores) {
    $data = $proveedores->prov_datos_id($_POST['proveedor_id']);
    echo json_encode(['status' => $data ? 'success' : 'error', 'data' => $data]);
}

function toggleStatusProveedor($proveedores) {
    $result = $proveedores->prov_toggle_status($_POST['proveedor_id'], $_POST['estado']);
    echo json_encode(['status' => $result ? 'success' : 'error']);
}
?>