<?php
// AJAX/ctrInvCatalogo.php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
include_once "../MODELO/modInvCatalogo.php";
include_once "../MODELO/modCategorias.php"; // Modelo de categorías


header('Content-Type: application/json');

$action = $_POST['action'];
$response = ['status' => 'error', 'message' => 'An error occurred'];

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $action = $_POST['action'];

        $database = new Cls_DataConnection();
        $db = $database->FN_getConnect();

        // Cambié Inventario por InvCatalogo
        $inventario = new InvCatalogo($db);

        switch ($action) {
            case 'getCategorias':
                $categorias = new Categorias($db);
                $result = $categorias->getCategorias();
                $response = $result;
                break;
                
                case 'getUnidadesMedida':
                    
                    $unidadesMedida = new Categorias($db);
                    $result = $unidadesMedida->getUnidadesMedida();
                    $response = $result;
                    break;
                
            
                case 'addArticulo':
                    $opcion = $_POST['opcion'];
                    $id_articulo = isset($_POST['id_articulo']) ? $_POST['id_articulo'] : 0;
                    $nombre = $_POST['nombre'];
                    $descripcion = $_POST['descripcion'];
                    $id_categoria = $_POST['id_categoria'];
                    $unidad_medida = $_POST['unidad_medida'];
                    $estado = 'disponible'; // Puedes agregar lógica para definir el estado
                    $stock = 0; // Stock inicial, puedes modificar según tu lógica
                
                    if (empty($nombre) || empty($descripcion)) {
                        throw new Exception('Los campos nombre y descripción son obligatorios');
                    }
                
                    $result = $inventario->addOrUpdateArticulo($opcion, $id_articulo, $nombre, $descripcion, $id_categoria, $unidad_medida, $estado, $stock);
                    if ($result) {
                        $response['status'] = 'success';
                        $response['message'] = $opcion == 1 ? 'Artículo registrado correctamente' : 'Artículo actualizado correctamente';
                    } else {
                        $response['message'] = 'Error al realizar la operación';
                    }
                    break;

            case 'obtenerArticulos':
                $result = $inventario->getArticulos();
                echo json_encode($result);  // Esto devolverá los datos de 'data'
                exit;

            case 'deleteArticulo':
                $articulo_id = $_POST['articulo_id'];
                if ($inventario->deleteArticulo($articulo_id)) {
                    $response['status'] = 'success';
                    $response['message'] = 'Artículo eliminado correctamente';
                } else {
                    $response['message'] = 'Error al eliminar el artículo';
                }
                break;

            default:
                throw new Exception('Acción no válida');
        }
    } else {
        throw new Exception('Método de solicitud no permitido');
    }
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

echo json_encode($response);
?>
