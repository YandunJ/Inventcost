<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../MODELO/modEstadisticas.php";

$action = $_POST['action'];
$estadisticas = new Estadisticas();

switch ($action) {
    case 'obtenerLotesMP':
        obtenerLotesMP($estadisticas);
        break;
        
    case 'obtenerLotesINS':
        obtenerLotesINS($estadisticas);
        break;
        
    case 'obtenerLotesPT':
        obtenerLotesPT($estadisticas);
        break;
        
    case 'obtenerLotesProximosVencer':
        obtenerLotesProximosVencer($estadisticas);
        break;

    case 'obtenerEntradasPorCategoria':
        obtenerEntradasPorCategoria($estadisticas);
        break;
        
        case 'obtenerStockPT':
            obtenerStockPT($estadisticas);
            break;
      

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function obtenerLotesMP($estadisticas) {
    $data = $estadisticas->obtenerLotesMP();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}


function obtenerLotesINS($estadisticas) {
    $data = $estadisticas->obtenerLotesINS();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerLotesPT($estadisticas) {
    $data = $estadisticas->obtenerLotesINS();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerLotesProximosVencer($estadisticas) {
    $data = $estadisticas->obtenerLotesProximosVencer();
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}

function obtenerEntradasPorCategoria($estadisticas) {
    $mes = $_POST['mes'];
    $anio = $_POST['anio'];
    $data = $estadisticas->obtenerEntradasPorCategoria($mes, $anio);
    echo json_encode(['status' => 'success', 'data' => $data]);
    exit;
}
  
        // Función correspondiente
        function obtenerStockPT($estadisticas) {
            $data = $estadisticas->obtenerStockPT();
            echo json_encode(['status' => 'success', 'data' => $data]);
            exit;
        }
?>