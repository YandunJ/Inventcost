<?php
//AJAX/ctrProveedores.php
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProveedores.php";

$conexion = new Cls_DataConnection();
$db = $conexion->FN_getConnect();

$proveedor = new Proveedores($db);

$action = isset($_POST['action']) ? $_POST['action'] : '';

try {
    if ($action === "guardarDatosProveedor") {
        $nombre_empresa = $_POST['nombre_empresa'];
        $representante = $_POST['representante'];
        $direccion = $_POST['direccion'];
        $correo = $_POST['correo'];
        $telefono = $_POST['telefono'];
        $res = $proveedor->guardarDatos($nombre_empresa, $representante, $direccion, $correo, $telefono);
    } elseif ($action === "actualizarDatosProveedor") {
        $proveedor_id = $_POST['proveedor_id'];
        $nombre_empresa = $_POST['nombre_empresa'];
        $representante = $_POST['representante'];
        $direccion = $_POST['direccion'];
        $correo = $_POST['correo'];
        $telefono = $_POST['telefono'];
        $res = $proveedor->actualizarDatos($proveedor_id, $nombre_empresa, $representante, $direccion, $correo, $telefono);
    } elseif ($action === "eliminarDatosProveedor") {
        $proveedor_id = $_POST['proveedor_id'];
        $res = $proveedor->eliminarDatos($proveedor_id);
    } elseif ($action === "obtenerProveedores") {
        $res = $proveedor->obtenerProveedores();
    } elseif ($action === "obtenerProveedor") {
        $proveedor_id = $_POST['proveedor_id'];
        $res = $proveedor->obtenerProveedor($proveedor_id);
    } else {
        throw new Exception("Acción desconocida: " . $action);
    }
    echo json_encode($res);
} catch (Exception $e) {
    $respuesta = array("status" => "error", "message" => $e->getMessage());
    echo json_encode($respuesta);
}
?>
