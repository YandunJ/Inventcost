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
        case 'cargarInsumosPorProveedor':
            cargarInsumosPorProveedor();
            break;
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
            
        case 'eliminarInsumo':
            eliminarInsumo();
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
            // Consulta para obtener la unidad de medida uniendo las tablas
            $query = "
                SELECT um.uni_nombre 
                FROM invent_catalogo ic
                JOIN unidades_medida um ON ic.uni_id = um.uni_id
                WHERE ic.id_articulo = ?
            ";
            $stmt = $conn->prepare($query);
            $stmt->bind_param("i", $id_articulo);
            $stmt->execute();
            $result = $stmt->get_result();
            $unidad = $result->fetch_assoc();
    
            if ($unidad) {
                echo json_encode(['status' => 'success', 'unidad_medida' => $unidad['uni_nombre']]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Unidad de medida no encontrada']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'ID de artículo no válido']);
        }
    }
    
    function cargarInsumosPorProveedor() {
        global $conn;
        $proveedor_id = isset($_POST['proveedor_id']) ? intval($_POST['proveedor_id']) : 0;
    
        if ($proveedor_id === 0) {
            echo json_encode(['status' => 'error', 'message' => 'Proveedor no válido']);
            return;
        }
    
        $insumos = new InventarioInsumos($conn);
        try {
            $data = $insumos->obtenerInsumosPorProveedor($proveedor_id);
    
            if (empty($data)) {
                echo json_encode([
                    'status' => 'error',
                    'message' => "No se encontraron insumos para este proveedor: $proveedor_id"
                ]);
            } else {
                echo json_encode(['status' => 'success', 'data' => $data]);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }

    
    function cargarProveedores() {
        global $conn;
        $insumos = new InventarioInsumos($conn);
    
        $id_categoria_insumos = 2; // ID de categoría para insumos
    
        try {
            $proveedores = $insumos->obtenerProveedoresPorCategoria($id_categoria_insumos);
            if (empty($proveedores)) {
                echo json_encode(['status' => 'error', 'message' => 'No se encontraron proveedores para insumos']);
            } else {
                echo json_encode(['status' => 'success', 'data' => $proveedores]);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
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


?>