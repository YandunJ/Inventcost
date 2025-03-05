<?php
// AJAX/ctrInvFrutas.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvFrutas.php";

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'cargarFrutas':
        cargarFrutas();
        break;

    case 'generarNumeroLote':
        generarNumeroLote();
        break;

    case 'cargarProveedores':
        cargarProveedores();
        break;

        case 'cargarMateriaPrima':
            cargarMateriaPrima();
            break;
    case 'guardarMateriaPrima':
        guardarMateriaPrima();
        break;

    case 'actualizarMateriaPrima':
        actualizarMateriaPrima();
        break;

    case 'eliminarMateriaPrima':
        eliminarMateriaPrima();
        break;

    case 'obtenerMateriaPrima':
        obtenerMateriaPrima();
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}


function generarNumeroLote() {
    try {
        $materiaPrima = new MateriaPrima();
        $numeroLote = $materiaPrima->generarNumeroLote();

        echo json_encode(['status' => 'success', 'numero_lote' => $numeroLote]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}



function cargarFrutas() {
    global $conn;
    $materiaPrima = new MateriaPrima($conn);
    try {
        $frutas = $materiaPrima->obtenerFrutas(); // Obtiene todas las frutas sin filtros
        if (empty($frutas)) {
            echo json_encode(['status' => 'error', 'message' => 'No se encontraron frutas disponibles']);
        } else {
            echo json_encode(['status' => 'success', 'data' => $frutas]);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}



function cargarProveedores() {
    global $conn;
    $materiaPrima = new MateriaPrima($conn);
    // ID de la categoría de Materia Prima (en tu caso, 1)
    $id_categoria_materia_prima = 1;

    try {
        $proveedores = $materiaPrima->obtenerProveedores($id_categoria_materia_prima);
        if (empty($proveedores)) {
            echo json_encode(['status' => 'error', 'message' => 'No se encontraron proveedores relacionados a materia prima']);
        } else {
            echo json_encode(['status' => 'success', 'data' => $proveedores]);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function guardarMateriaPrima() {
    try {
        $materiaPrima = new MateriaPrima();

        // Captura los valores de los campos del formulario
        $cat_id = $_POST['id_articulo'] ?? null;
        $proveedor_id = $_POST['proveedor_id'] ?? null;
        $numero_lote = $_POST['numero_lote'] ?? null;
        $cantidad_ingresada = $_POST['cantidad_ingresada'] ?? null;
        $precio_unitario = $_POST['precio_unitario'] ?? null;
        $precio_total = $_POST['precio_total'] ?? null;
        $brix = $_POST['brix'] ?? null;
        $observacion = $_POST['observacion'] ?? null;

        // Verifica que todos los campos obligatorios estén presentes
        if (is_null($cat_id) || is_null($proveedor_id) || is_null($numero_lote) || is_null($cantidad_ingresada) 
        || is_null($precio_unitario) || is_null($precio_total) || is_null($brix)) {
            throw new Exception("Todos los campos son obligatorios.");
        }

        // Llamada al método para guardar los datos en la base de datos
        $result = $materiaPrima->guardarInventarioMateriaPrima(
            $cat_id, $proveedor_id, $numero_lote, $cantidad_ingresada,
            $precio_unitario, $precio_total, $brix, $observacion
        );

        if (!$result) {
            throw new Exception("Error al guardar los datos en la base de datos");
        }
        echo json_encode(['status' => 'success', 'message' => 'Registro guardado correctamente']);

    } catch (Exception $e) {
        error_log($e->getMessage());  // Log de error
        echo json_encode(['status' => 'error', 'message' => 'Ocurrió un error: ' . $e->getMessage()]);
    }
}
function actualizarMateriaPrima() {
    if (isset($_POST['id_inv'], $_POST['id_articulo'], $_POST['proveedor_id'], $_POST['cantidad_ingresada'], $_POST['precio_total'], $_POST['precio_unitario'], $_POST['brix'], $_POST['observacion'])) {
        try {
            $materiaPrima = new MateriaPrima();
            $result = $materiaPrima->actualizarMateriaPrima(
                $_POST['id_inv'],
                $_POST['id_articulo'],
                $_POST['proveedor_id'],
                $_POST['cantidad_ingresada'],
                $_POST['precio_total'],
                $_POST['precio_unitario'],
                $_POST['brix'],
                $_POST['observacion']
            );
            echo json_encode(['status' => $result ? 'success' : 'error', 'message' => $result ? 'Registro actualizado correctamente' : 'No se pudo actualizar el registro']);
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => 'Error: ' . $e->getMessage()]);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Datos incompletos.']);
    }
}
    function cargarMateriaPrima() {
        $materiaPrima = new MateriaPrima();  // La conexión se establece en el constructor
    
        try {
            $data = $materiaPrima->obtenerInventarioMP();
            echo json_encode(['status' => 'success', 'data' => $data]);
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }
    
   
function obtenerMateriaPrima() {
    if (isset($_POST['id_inv'])) {
        $id_inv = $_POST['id_inv']; // Obtenemos el id_inv desde el POST
        $materiaPrima = new MateriaPrima();

        try {
            // Llamamos a la función para obtener los datos del inventario
            $data = $materiaPrima->obtenerMateriaPrimaPorId($id_inv);

            if ($data) {
                // Si se obtuvo el registro, lo retornamos en formato JSON
                echo json_encode(['status' => 'success', 'data' => $data]);
            } else {
                // Si no se encuentra el registro, enviamos un mensaje de error
                echo json_encode(['status' => 'error', 'message' => 'No se pudo obtener la materia prima.']);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'El ID del inventario no fue proporcionado.']);
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

 
?>