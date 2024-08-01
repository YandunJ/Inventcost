<?php

//AJAX/ctrFrutas.php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
include_once "../MODELO/modFrutas.php";

header('Content-Type: application/json');

$response = ['status' => 'error', 'message' => 'An error occurred'];

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $action = $_POST['action'];

        $database = new Cls_DataConnection();
        $db = $database->FN_getConnect();

        $frutas = new Frutas($db);

        switch ($action) {
            case 'addFruta':
                $opcion = $_POST['opcion'];
                $nombre = $_POST['nombre'];
                $descripcion = $_POST['descripcion'];
                if (empty($nombre) || empty($descripcion)) {
                    throw new Exception('Los campos nombre y descripción son obligatorios');
                }
                $result = $frutas->addOrUpdateFruta($opcion, null, $nombre, $descripcion);
                if ($result) {
                    $response['status'] = 'success';
                    $response['message'] = 'Fruta registrada correctamente';
                } else {
                    $response['message'] = 'Error al registrar la fruta';
                }
                break;

            case 'updateFruta':
                $opcion = $_POST['opcion'];
                $fruta_id = $_POST['fruta_id'];
                $nombre = $_POST['nombre'];
                $descripcion = $_POST['descripcion'];
                if (empty($nombre) || empty($descripcion)) {
                    throw new Exception('Los campos nombre y descripción son obligatorios');
                }
                $result = $frutas->addOrUpdateFruta($opcion, $fruta_id, $nombre, $descripcion);
                if ($result) {
                    $response['status'] = 'success';
                    $response['message'] = 'Fruta actualizada correctamente';
                } else {
                    $response['message'] = 'Error al actualizar la fruta';
                }
                break;

            case 'obtenerFrutas':
                $result = $frutas->getFrutas();
                echo json_encode($result);
                exit;

            case 'deleteFruta':
                $fruta_id = $_POST['fruta_id'];
                if ($frutas->deleteFruta($fruta_id)) {
                    $response['status'] = 'success';
                    $response['message'] = 'Fruta eliminada correctamente';
                } else {
                    $response['message'] = 'Error al eliminar la fruta';
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
