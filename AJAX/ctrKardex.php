<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modKardex.php";

$conn = (new Cls_DataConnection())->FN_getConnect();

if (!isset($_POST['action']) || empty($_POST['action'])) {
    // Retornar un error más manejable en lugar de continuar
    http_response_code(400); // Bad Request
    echo json_encode(['status' => 'error', 'message' => 'Parámetro de acción faltante o inválido.']);
    exit;
}

$action = $_POST['action'];

switch ($action) {
    case 'cargarKardex':
        cargarKardex($conn);
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function cargarKardex($conn) {
    header('Content-Type: application/json');
    try {
        $fechaInicio = $_POST['fechaInicio'] ?? null;
        $fechaFin = $_POST['fechaFin'] ?? null;
        $categoria = $_POST['categoria'] ?? null;

        if (!$fechaInicio || !$fechaFin || !$categoria) {
            throw new Exception("Faltan parámetros obligatorios.");
        }

        $mapaCategorias = [
            'MP' => 1,
            'INS' => 2,
            'PT' => 3
        ];

        if (!isset($mapaCategorias[$categoria])) {
            throw new Exception("Categoría inválida: $categoria");
        }

        $kardexModel = new KardexModel();
        $datos = $kardexModel->obtenerKardex($fechaInicio, $fechaFin, $mapaCategorias[$categoria]);

        echo json_encode(['status' => 'success', 'data' => $datos]);
    } catch (Exception $e) {
        http_response_code(500); // Error interno del servidor
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

?>
