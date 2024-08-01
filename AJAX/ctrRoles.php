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
            $permiso_id = $_POST['rol_area_trabajo'];
            $roles = new Roles($db);
            $result = $roles->updateRole($rol_id, $rol_nombre, $rol_descripcion, $permiso_id);
            $response = ['status' => $result ? 'success' : 'error'];
            break;
            case 'deleteRole':
                $rol_id = $_POST['rol_id'];
                $roles = new Roles($db);
                
                try {
                    $result = $roles->deleteRole($rol_id);
                    $response = ['status' => $result ? 'success' : 'error'];
                } catch (PDOException $e) {
                    if ($e->getCode() == '23000') { // Verifica si es un error de restricción de clave foránea
                        $response = ['status' => 'error', 'message' => 'No se puede eliminar este rol porque un usuario tiene este rol.'];
                    } else {
                        $response = ['status' => 'error', 'message' => 'Error al eliminar rol: ' . $e->getMessage()];
                    }
                }
                break;
            

        case 'getPermisos':
            $permisos = new Permisos($db);
            $result = $permisos->getPermisos();
            $response = $result;
            break;
        case 'getRoles':
            $roles = new Roles($db);
            $result = $roles->getRoles(); // Llamar al procedimiento
            $response = [
                'status' => 'success',
                'data' => $result // Aquí incluimos los datos de los roles
            ];
            break;

            case 'getRoleById':
                $rol_id = $_POST['rol_id'];
                $roles = new Roles($db);
                $result = $roles->getRoleById($rol_id); // Asegúrate de que esta función esté definida
                if ($result) {
                    $response = ['status' => 'success', 'data' => $result];
                } else {
                    $response['message'] = 'Rol no encontrado';
                }
                break;
            
    }
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

header('Content-Type: application/json');
echo json_encode($response);

?>
