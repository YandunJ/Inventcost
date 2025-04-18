<?php
//AJAX/ctrInvInsumos.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvInsumos.php"; // Asegúrate de que este archivo exista


$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {

    case 'generarNumeroLote':
        generarNumeroLote();
        break;
        case 'cargarInsumos':
            cargarInsumos();
            break;
        // case 'cargarInsumosPorProveedor':
        //     cargarInsumosPorProveedor();
        //     break;
        case 'cargarProveedores':
            cargarProveedores();
            break;
        case 'guardarInsumo':
            guardarInsumo();
            break;
         case 'cargarInsumoId':
            cargarInsumoId();
            break;
        case 'actualizarInsumo':
            actualizarInsumo();
            break;
        case 'cargarInsumosTabla':
            cargarInsumosTabla();
            break;
      
        case 'obtenerUnidadMedida':
            obtenerUnidadMedida();
                break;
                
      
        default:
            echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
            break;
    }


  
    
    function generarNumeroLote() {
        try {
            $insumos = new InventarioInsumos();
            $numeroLote = $insumos->generarNumeroLote();
            echo json_encode(['status' => 'success', 'numero_lote' => $numeroLote]);
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }
    
    
    function obtenerUnidadMedida() {
        global $conn;
        $id_articulo = isset($_POST['id_articulo']) ? $_POST['id_articulo'] : '';
    
        if ($id_articulo) {
            // Consulta para obtener la unidad de medida (presentación) uniendo las tablas
            $query = "
                SELECT p.prs_nombre 
                FROM catalogo c
                JOIN presentacion p ON c.prs_id = p.prs_id
                WHERE c.cat_id = ?
            ";
            $stmt = $conn->prepare($query);
            $stmt->bind_param("i", $id_articulo);
            $stmt->execute();
            $result = $stmt->get_result();
            $unidad = $result->fetch_assoc();
    
            if ($unidad) {
                echo json_encode(['status' => 'success', 'unidad_medida' => $unidad['prs_nombre']]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Unidad de medida no encontrada']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'ID de artículo no válido']);
        }
    }
    
    

    function cargarInsumos() {
        global $conn;
        $insumos = new InventarioInsumos($conn);
        try {
            $data = $insumos->obtenerInsumos(); // Obtiene todos los insumos
            if (empty($data)) {
                echo json_encode(['status' => 'error', 'message' => 'No se encontraron insumos disponibles.']);
            } else {
                echo json_encode(['status' => 'success', 'data' => $data]);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }

    function guardarInsumo() {
        global $conn;
        $insumosModel = new InventarioInsumos();
    
        // Capturar datos del formulario y ajustar nombres según el SP y la tabla
        $proveedor_id = $_POST['proveedor_id'];
        $cat_id = $_POST['id_articulo']; // Asegúrate de que el nombre del campo coincida con el formulario
        $fecha_elaboracion = $_POST['fecha_elaboracion'];
        $fecha_caducidad = $_POST['fecha_caducidad'];
        $numero_lote = $_POST['numero_lote'];
        $cantidad_ingresada = $_POST['cantidad_ingresada'];
        $precio_unitario = $_POST['precio_unitario'];
        $precio_total = $_POST['precio_total'];
    
        try {
            // Llamada al método de inserción con los parámetros necesarios
            $insumosModel->insertarInsumo($proveedor_id, $cat_id, $fecha_elaboracion, $fecha_caducidad, $numero_lote, $cantidad_ingresada, $precio_unitario, $precio_total);
            echo json_encode(['status' => 'success', 'message' => 'Insumo agregado exitosamente']);
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }
    function cargarInsumosTabla() {
        $insumosModel = new InventarioInsumos();  // La conexión se establece en el constructor
    
        try {
            $data = $insumosModel->obtenerInventarioINS();
            echo json_encode(['status' => 'success', 'data' => $data]);
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }
function cargarInsumoId() {
    global $conn;
    $inventins_id = $_POST['inventins_id'];
    
    $modelo = new InventarioInsumos();
    $insumo = $modelo->obtenerInsumoPorID($inventins_id);
    
    if ($insumo) {
        echo json_encode(['status' => 'success', 'data' => $insumo]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Insumo no encontrado']);
    }
}

function actualizarInsumo() {
    global $insumo;

    $id_inv = $_POST['id_inv'];
    $id_articulo = $_POST['id_articulo'];
    $proveedor_id = $_POST['proveedor_id'];
    $fecha = $_POST['fecha'];
    $hora = $_POST['hora'];
    $numero_lote = $_POST['numero_lote'];
    $cantidad_ingresada = $_POST['cantidad_ingresada'];
    $presentacion = $_POST['presentacion'];
    $precio_unitario = $_POST['precio_unitario'];

    try {
        $resultado = $insumo->actualizarInsumo($id_inv, $id_articulo, $proveedor_id, $fecha, $hora, $numero_lote, $cantidad_ingresada, $presentacion, $precio_unitario);
        
        if ($resultado) {
            echo json_encode(['status' => 'success', 'message' => 'Insumo actualizado correctamente.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al actualizar el insumo.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

?>