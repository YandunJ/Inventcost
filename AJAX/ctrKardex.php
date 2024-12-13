<?php
// AJAX/ctrKardex.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modKardex.php";

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : '';

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
        $fechaInicio = $_POST['fechaInicio'];
        $fechaFin = $_POST['fechaFin'];
        $categoria = $_POST['categoria'];

        // Mapear las categorías a valores numéricos
        $mapaCategorias = [
            'MP' => 1,  // Materia Prima
            'INS' => 2, // Insumos
            'PT' => 3   // Producto Terminado
        ];

        if (!isset($mapaCategorias[$categoria])) {
            throw new Exception("Categoría inválida: $categoria");
        }

        $categoriaNumerica = $mapaCategorias[$categoria];

        $kardexModel = new KardexModel($conn);
        $datos = $kardexModel->obtenerKardex($fechaInicio, $fechaFin, $categoriaNumerica);

        echo json_encode(['status' => 'success', 'data' => $datos]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

?>
