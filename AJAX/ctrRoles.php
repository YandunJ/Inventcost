<?php
// AJAX/ctrRoles.php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
include_once "../MODELO/modRoles.php";
include_once "../MODELO/modPermisos.php";

$database = new Cls_DataConnection();
$db = $database->FN_getConnect();

$action = $_POST['action'];

$response = ['status' => 'error', 'message' => 'An error occurred'];

try {
    switch ($action) {
        case 'addRole':
            $rol_nombre = $_POST['rol_nombre'];
            $rol_descripcion = $_POST['rol_descripcion'];
            $permiso_id = $_POST['rol_area_trabajo'];
            $roles = new Roles($db);
            $result = $roles->addRole($rol_nombre, $rol_descripcion, $permiso_id);
            $response = ['status' => $result ? 'success' : 'error'];
            break;
        case 'updateRole':
            $rol_id = $_POST['rol_id'];
            $rol_nombre = $_POST['rol_nombre'];
            $rol_descripcion = $_POST['rol_descripcion'];
            $rol_area_trabajo = $_POST['rol_area_trabajo'];
            $roles = new Roles($db);
            $result = $roles->updateRole($rol_id, $rol_nombre, $rol_descripcion, $rol_area_trabajo);
            $response = ['status' => $result ? 'success' : 'error'];
            break;
        case 'getPermisos':
            $permisos = new Permisos($db);
            $result = $permisos->getPermisos();
            $response = $result;
            break;
    }
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

header('Content-Type: application/json');
echo json_encode($response);

?>
