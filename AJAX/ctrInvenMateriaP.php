<?php
// AJAX/ctrInvenMateriaP.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvenMateriaP.php";
require_once "../MODELO/sbmateria.php";

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'cargarFrutas':
        cargarFrutas();
        break;
    case 'cargarProveedores':
        cargarProveedores();
        break;
    case 'guardarMateriaPrima':
        guardarMateriaPrima();
        break;
    case 'cargarMateriaPrima':
        cargarMateriaPrima();
        break;
    case 'eliminarMateriaPrima':
        eliminarMateriaPrima();
        break;
    case 'obtenerMateriaPrima':
        obtenerMateriaPrima();
        break;
    case 'cambiarEstadoMateriaPrima':
        cambiarEstadoMateriaPrima();
            break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}
function cargarFrutas() {
    global $conn;
    $materiaPrima = new MateriaPrimaModel($conn);
    $frutas = $materiaPrima->obtenerFrutas();

    if (!$frutas) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener las frutas']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $frutas]);
    }
}

function cargarProveedores() {
    global $conn;
    $materiaPrima = new MateriaPrimaModel($conn);
    $proveedores = $materiaPrima->obtenerProveedores();

    if (!$proveedores) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los proveedores']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $proveedores]);
    }
}

function guardarMateriaPrima() {
    global $conn;
    $materiaPrima = new MateriaPrima($conn);

    $mp_id = isset($_POST['mp_id']) && $_POST['mp_id'] !== '' ? $_POST['mp_id'] : null; // Asegúrate de obtener correctamente el ID
    $fruta_id = $_POST['fruta_id'];
    $fecha_cad = $_POST['fecha_cad'];
    $proveedor_id = $_POST['proveedor_id'];
    $cantidad = $_POST['cantidad'];
    $precio_unit = $_POST['precio_unit'];
    $precio_total = $_POST['precio_total'];
    $birx = $_POST['birx'];
    $presentacion = $_POST['presentacion'];
    $observaciones = $_POST['observaciones'];

    try {
        if ($mp_id) { // Si hay mp_id, se está actualizando
            $materiaPrima->insertar($mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $observaciones);
        } else { // Si no hay mp_id, se está insertando
            $materiaPrima->insertar(null, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $observaciones);
        }
        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}


function actualizarMateriaPrima() {
    global $conn;
    $materiaPrima = new MateriaPrima($conn);

    $mp_id = $_POST['mp_id'];
    $fruta_id = $_POST['fruta_id'];
    $fecha_cad = $_POST['fecha_cad'];
    $proveedor_id = $_POST['proveedor_id'];
    $cantidad = $_POST['cantidad'];
    $precio_unit = $_POST['precio_unit'];
    $precio_total = $_POST['precio_total'];
    $birx = $_POST['birx'];
    $presentacion = $_POST['presentacion'];
    $observaciones = $_POST['observaciones'];

    try {
        $materiaPrima->insertar($mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $observaciones);
        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}




function cargarMateriaPrima() {
    global $conn;
    $sql = "CALL fpulpas.pa_obt_materia_prima()";
    $result = $conn->query($sql);

    if (!$result) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los registros de materia prima']);
        return;
    }

    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode(['status' => 'success', 'data' => $data]);
}


function obtenerMateriaPrima() {
    global $conn;
    $mp_id = $_POST['mp_id'];
    $materiaPrima = new MateriaPrima();
    $data = $materiaPrima->obtenerMateriaPrimaPorId($mp_id);
    if ($data) {
        echo json_encode(['status' => 'success', 'data' => $data]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No se pudo obtener la materia prima.']);
    }
}


function eliminarMateriaPrima() {
    global $conn;
    $mp_id = $_POST['mp_id'];
    $materiaPrima = new MateriaPrima();
    try {
        $materiaPrima->eliminar($mp_id);
        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function cambiarEstadoMateriaPrima() {
    global $conn;
    $mp_id = $_POST['mp_id'];
    $estado = $_POST['estado']; // 1 para aprobado, 2 para en revisión, 3 para no aprobado
    $stmt = $conn->prepare("CALL estado_materia_prima(?, ?)");
    $stmt->bind_param("ii", $mp_id, $estado);
    if ($stmt->execute()) {
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error', 'message' => $stmt->error]);
    }
    $stmt->close();
}



?>