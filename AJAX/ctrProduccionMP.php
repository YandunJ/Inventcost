<?php
// AJAX/ctrProduccionMP.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProduccionMP.php";

$conn = (new Cls_DataConnection())->FN_getConnect(); 

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'registrarProduccion':
        registrarProduccion();
        break;

    case 'consultarIds':
        $ids = isset($_POST['ids']) ? json_decode($_POST['ids'], true) : [];
        if (empty($ids)) {
            echo json_encode(['status' => 'error', 'message' => 'No se recibieron IDs']);
            exit;
        }
    
        $sql = "SELECT cat_id, cat_nombre FROM catalogo WHERE cat_id IN (" . implode(',', array_map('intval', $ids)) . ")";
        $result = $conn->query($sql);
    
        if ($result->num_rows > 0) {
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            echo json_encode(['status' => 'success', 'data' => $data]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se encontraron datos']);
        }
        break;
    
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function registrarProduccion() {
    $produccion = new Produccion();
    
    $cant_producida = isset($_POST['cant_producida']) ? $_POST['cant_producida'] : 0;
    $lotes_mp = isset($_POST['lotes_mp']) ? $_POST['lotes_mp'] : '[]';
    $lotes_ins = isset($_POST['lotes_ins']) ? $_POST['lotes_ins'] : '[]';
    $mano_obra = isset($_POST['mano_obra']) ? $_POST['mano_obra'] : '[]';
    $costos_indirectos = isset($_POST['costos_indirectos']) ? $_POST['costos_indirectos'] : '[]';

    try {
        $result = $produccion->registrarProduccion($cant_producida, $lotes_mp, $lotes_ins, $mano_obra, $costos_indirectos);
        echo json_encode($result);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>