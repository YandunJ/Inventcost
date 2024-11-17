<?php
//AJAX/ctrInvInsumos.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvInsumos.php"; // Asegúrate de que este archivo exista
require_once "../MODELO/sbinsumos.php"; // El modelo de insumos

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
        case 'cargarInsumos':
        cargarInsumos();
            break;
        case 'cargarProveedores':
        cargarProveedores();
            break;
        case 'guardarInsumo':
            guardarInsumo();
            break;
        case 'cargarInsumosTabla':
            cargarInsumosTabla();
            break;
            
        case 'eliminarInsumo':
            eliminarInsumo();
            break;
        case 'cargarInsumoId':
            cargarInsumoId();
                break;
        case 'obtenerUnidadMedida':
            obtenerUnidadMedida();
                break;
                
      
        default:
            echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
            break;
    }

function cargarInsumos() {
    global $conn;
    $insumosModel = new InsumosModel($conn); // Instanciar el modelo
    $insumos = $insumosModel->obtenerInsumos(); // Obtener insumos

    if (!$insumos) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los insumos']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $insumos]); // Enviar datos como respuesta JSON
    }
}


function cargarProveedores() {
    global $conn;
    $insumosModel = new InsumosModel($conn);
    $proveedores = $insumosModel->obtenerProveedores();

    if (!$proveedores) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los proveedores']);
    } else {
        echo json_encode(['status' => 'success', 'data' => $proveedores]);
    }
}

function guardarInsumo() {
    global $conn;
    $insumosModel = new InventarioInsumos();

    // Capturar datos del formulario y ajustar nombres según el SP y la tabla
    $id_articulo = $_POST['id_articulo'];       // Correspondiente a p_id_articulo
    $proveedor_id = $_POST['proveedor_id'];     // Correspondiente a p_proveedor_id
    $fecha = $_POST['fecha'];                   // Correspondiente a p_fecha
    $hora = $_POST['hora'];                     // Correspondiente a p_hora
    $numero_lote = $_POST['numero_lote'];       // Correspondiente a p_numero_lote
    $cantidad_ingresada = $_POST['cantidad_ingresada']; // Correspondiente a p_cantidad_ingresada
    $presentacion = $_POST['presentacion'];     // Correspondiente a p_presentacion
    $precio_unitario = $_POST['precio_unitario']; // Correspondiente a p_precio_unitario

    try {
        // Llamada al método de inserción con los parámetros necesarios
        $insumosModel->insertarInsumo($id_articulo, $proveedor_id, $fecha, $hora, $numero_lote, $cantidad_ingresada, $presentacion, $precio_unitario);
        echo json_encode(['status' => 'success', 'message' => 'Insumo agregado exitosamente']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
function cargarInsumosTabla() {
    global $conn;
    header('Content-Type: application/json');
    $insumosModel = new InventarioInsumos($conn);
    try {
        $data = $insumosModel->obtenerInvenInsumos();
        echo json_encode(['status' => 'success', 'data' => $data]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}


function cargarInsumoId() {
    global $conn;
    $inventins_id = $_POST['inventins_id'];
    $insumosModel = new InventarioInsumos();
    $data = $insumosModel->obtenerInvenInsumoPorId($inventins_id);
    if ($data) {
        echo json_encode(['status' => 'success', 'data' => $data]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No se pudo obtener el insumo.']);
    }
}

function eliminarInsumo() {
    $id_inv = $_POST['id_inv'];  // Recibe el ID de inventario desde la solicitud
    $insumosModel = new  InventarioInsumos();
    try {
        $insumosModel->eliminar($id_inv);
        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerUnidadMedida() {
    global $conn;
    $id_articulo = isset($_POST['id_articulo']) ? $_POST['id_articulo'] : '';

    if ($id_articulo) {
        $query = "SELECT unidad_medida FROM invent_catalogo WHERE id_articulo = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $id_articulo);
        $stmt->execute();
        $result = $stmt->get_result();
        $unidad = $result->fetch_assoc();

        if ($unidad) {
            echo json_encode(['status' => 'success', 'unidad_medida' => $unidad['unidad_medida']]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Unidad de medida no encontrada']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'ID de artículo no válido']);
    }
}

?>