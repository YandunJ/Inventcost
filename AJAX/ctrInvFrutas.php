<?php
// AJAX/ctrInvFrutas.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvFrutas.php";
// aqui cambiar el nombre y uso para cargar los articulos de cateaogo inventario
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
    case 'obtenerDetalleLote':
        obtenerDetalleLote();
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
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los arti colas']);
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

    $id_inv = isset($_POST['id_inv']) && $_POST['id_inv'] !== '' ? $_POST['id_inv'] : null;
    $fecha = $_POST['fecha'];
    $hora = $_POST['hora'];
    $id_articulo = $_POST['id_articulo'];
    $proveedor_id = $_POST['proveedor_id'];
    $numero_lote = $_POST['numero_lote'];
    $unidad_medida = isset($_POST['unidad_medida']) && $_POST['unidad_medida'] !== '' ? $_POST['unidad_medida'] : 'kg';
    $cantidad_ingresada = $_POST['cantidad_ingresada'];
    $cantidad_restante = $_POST['cantidad_restante'];
    $precio_unitario = $_POST['precio_unitario'];
    $presentacion = $_POST['presentacion'];
    $estado = isset($_POST['estado']) && $_POST['estado'] !== '' ? $_POST['estado'] : 'disponible';
    $bultos_o_canastas = $_POST['bultos_o_canastas'];
    $peso_unitario = $_POST['peso_unitario'];
    $brix = $_POST['brix'];
    $observacion = $_POST['observacion'];
    $decision = isset($_POST['decision']) && $_POST['decision'] !== '' ? $_POST['decision'] : 'no aprobado';

    try {
        // Cambiar el nombre de la función en el modelo para reflejar que maneja tanto inserción como actualización
        $result = $materiaPrima->guardarOActualizarInventarioMateriaPrima(
            $id_inv, $fecha, $hora, $id_articulo, $proveedor_id, $numero_lote, 
            $unidad_medida, $cantidad_ingresada, $cantidad_restante, $precio_unitario, 
            $presentacion, $estado, $bultos_o_canastas, $peso_unitario, $brix, 
            $observacion, $decision
        );

        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Registro guardado correctamente']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se pudo guardar el registro']);
        }
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
    $materiaPrima = new MateriaPrima($conn);

    try {
        // Llamada al método del modelo para obtener datos para el DataTable
        $data = $materiaPrima->obtenerInventarioMP(); 
        echo json_encode(['status' => 'success', 'data' => $data]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
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
    $id_inv = $_POST['id_inv'];  // Recibe el ID de inventario desde la solicitud
    $materiaPrima = new MateriaPrima();

    try {
        $materiaPrima->eliminar($id_inv);  // Llama al método de eliminación en el modelo
        echo json_encode(['status' => 'success']);  // Responde con éxito si la eliminación se realiza correctamente
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);  // Muestra el mensaje de error en caso de falla
    }
}

function obtenerDetalleLote() {
    global $conn;
    $lote_id = $_POST['lote_id'];
    $materiaPrima = new MateriaPrima();

    try {
        $data = $materiaPrima->obtenerDetalleLote($lote_id);
        if ($data) {
            echo json_encode(['status' => 'success', 'data' => $data]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se encontraron detalles para el lote especificado.']);
        }
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