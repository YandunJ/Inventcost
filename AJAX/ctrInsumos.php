<?php
//AJAX/ctrInsumos.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
include_once "../MODELO/modInsumos.php";

header('Content-Type: application/json');

$response = ['status' => 'error', 'message' => 'An error occurred'];

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $action = $_POST['action'];
    
        $database = new Cls_DataConnection();
        $db = $database->FN_getConnect();
    
        $insumos = new Insumos($db);
    
        switch ($action) {
            case 'addInsumo':
                $opcion = 1; // 1 para agregar
                $nombre = $_POST['nombre'];
                $descripcion = $_POST['descripcion'];
                $unidad_medida = $_POST['unidad_medida'];
                $destino = $_POST['destino'];
    
                if (empty($nombre) || empty($descripcion) || empty($unidad_medida) || empty($destino)) {
                    throw new Exception('Los campos nombre, descripción, unidad de medida y destino son obligatorios.');
                }
    
                $result = $insumos->addOrUpdateInsumo($opcion, null, $nombre, $descripcion, $unidad_medida, $destino);
    
                if ($result) {
                    $response = ['status' => 'success', 'message' => 'Insumo agregado exitosamente.'];
                } else {
                    throw new Exception('Error al agregar insumo.');
                }
                break;
    
            case 'updateInsumo':
                $insumo_id = $_POST['insumo_id'];
                $opcion = 2; // 2 para actualizar
                $nombre = $_POST['nombre'];
                $descripcion = $_POST['descripcion'];
                $unidad_medida = $_POST['unidad_medida'];
                $destino = $_POST['destino'];
    
                if (empty($nombre) || empty($descripcion) || empty($unidad_medida) || empty($destino)) {
                    throw new Exception('Los campos nombre, descripción, unidad de medida y destino son obligatorios.');
                }
    
                $result = $insumos->addOrUpdateInsumo($opcion, $insumo_id, $nombre, $descripcion, $unidad_medida, $destino);
    
                if ($result) {
                    $response = ['status' => 'success', 'message' => 'Insumo actualizado exitosamente.'];
                } else {
                    throw new Exception('Error al actualizar insumo.');
                }
                break;
    
            case 'deleteInsumo':
                $insumo_id = $_POST['insumo_id'];
                $result = $insumos->deleteInsumo($insumo_id);
    
                if ($result) {
                    $response = ['status' => 'success', 'message' => 'Insumo eliminado exitosamente.'];
                } else {
                    throw new Exception('Error al eliminar insumo.');
                }
                break;
    
            case 'obtenerInsumos':
                $data = $insumos->getInsumos();
                $response = ['status' => 'success', 'data' => $data];
                break;
    
            default:
                throw new Exception('Acción no válida.');
        }
    }
    
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

echo json_encode($response);
?>

