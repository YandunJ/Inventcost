<?php
//AJAX/ctrProveedores.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
include_once "../MODELO/modProveedores.php";

$database = new Cls_DataConnection();
$db = $database->FN_getConnect();

$action = $_POST['action'];
$response = ['status' => 'error', 'message' => 'An error occurred'];

try {
    switch ($action) {
        case 'addOrUpdateProveedor':
            $proveedor_id = $_POST['proveedor_id'];
            $nombre_empresa = $_POST['nombre_empresa'];
            $representante = $_POST['representante'];
            $direccion = $_POST['direccion'];
            $correo = $_POST['correo'];
            $telefono = $_POST['telefono'];
            $proveedores = new Proveedores($db);
            $result = $proveedores->acciones_proveedor($proveedor_id, $nombre_empresa, $representante, $direccion, $correo, $telefono);
            $response = ['status' => $result ? 'success' : 'error'];
            break;

        case 'getProveedores':
            $proveedores = new Proveedores($db);
            $result = $proveedores->pa_obtener_proveedores();
                
            // Log para verificar los resultados
            error_log(print_r($result, true));  // Agregar esta línea para depuración
                
            $response = ['status' => 'success', 'data' => $result];
            break;
            
        case 'deleteProveedor':
            $proveedor_id = $_POST['proveedor_id'];
            $proveedores = new Proveedores($db);
            $result = $proveedores->pa_eliminar_proveedor($proveedor_id);
            $response = ['status' => $result ? 'success' : 'error'];
            break;

        case 'getProveedorById':
            $proveedor_id = $_POST['proveedor_id'];
            $proveedores = new Proveedores($db);
            $result = $proveedores->pa_obt_prov_id($proveedor_id);
            if ($result) {
                $response = ['status' => 'success', 'data' => $result];
            } else {
                $response['message'] = 'Proveedor no encontrado';
            }
            break;
    }
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

header('Content-Type: application/json');
echo json_encode($response);
?>
