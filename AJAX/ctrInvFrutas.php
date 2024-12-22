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
    // case 'cargarFrutasPorProveedor':
    //     cargarFrutasPorProveedor();
    //     break;
    
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
    case 'actualizarMateriaPrima':
        actualizarMateriaPrima();
        break;
  
    case 'obtenerDetalleLote':
        obtenerDetalleLote();
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


// function cargarFrutasPorProveedor() {
//     global $conn;
//     $proveedor_id = isset($_POST['proveedor_id']) ? intval($_POST['proveedor_id']) : 0;

//     if ($proveedor_id === 0) {
//         echo json_encode(['status' => 'error', 'message' => 'Proveedor no válido']);
//         return;
//     }

//     $materiaPrima = new MateriaPrima($conn);
//     try {
//         $frutas = $materiaPrima->obtenerFrutasPorProveedor($proveedor_id);

//         if (empty($frutas)) {
//             echo json_encode([
//                 'status' => 'error', 
//                 'message' => "No se encontraron frutas para este proveedor: $proveedor_id"
//             ]);
//         } else {
//             echo json_encode(['status' => 'success', 'data' => $frutas]);
//         }
//     } catch (Exception $e) {
//         echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
//     }
// }

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
            $fecha = $_POST['fecha'];
            $hora = $_POST['hora'];
            $id_articulo = $_POST['id_articulo'];
            $proveedor_id = $_POST['proveedor_id'];
            $numero_lote = $_POST['numero_lote'];
            $cantidad_ingresada = $_POST['cantidad_ingresada'];
            $precio_unitario = $_POST['precio_unitario'];
            $presentacion = $_POST['presentacion'];  // Asegúrate de incluir este campo en el formulario
            $bultos_o_canastas = $_POST['bultos_o_canastas'];
            $peso_unitario = $_POST['peso_unitario'];
            $brix = $_POST['brix'];
            $observacion = $_POST['observacion'];

            // Llamada al método para guardar los datos en la base de datos
            $result = $materiaPrima->guardarInventarioMateriaPrima(
                $fecha, $hora, $id_articulo, $proveedor_id, $numero_lote,
                $cantidad_ingresada, $precio_unitario, $presentacion,
                $bultos_o_canastas, $peso_unitario, $brix, $observacion
            );

            echo json_encode([
                'status' => $result ? 'success' : 'error',
                'message' => $result ? 'Registro guardado correctamente' : 'No se pudo guardar el registro'
            ]);
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }

    function actualizarMateriaPrima() {
        if (isset($_POST['id_inv'], $_POST['fecha'], $_POST['hora'], $_POST['id_articulo'], $_POST['proveedor_id'], $_POST['numero_lote'], $_POST['cantidad_ingresada'], $_POST['precio_unitario'], $_POST['presentacion'], $_POST['brix'], $_POST['bultos_o_canastas'], $_POST['peso_unitario'], $_POST['observacion'])) {
            try {
                $materiaPrima = new MateriaPrima();
                $result = $materiaPrima->actualizarMateriaPrima(
                    $_POST['id_inv'],
                    $_POST['fecha'],
                    $_POST['hora'],
                    $_POST['id_articulo'],
                    $_POST['proveedor_id'],
                    $_POST['numero_lote'],
                    $_POST['cantidad_ingresada'],
                    $_POST['precio_unitario'],
                    $_POST['presentacion'],
                    $_POST['brix'],
                    $_POST['bultos_o_canastas'],
                    $_POST['peso_unitario'],
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
            // Validamos que se esté pasando el id_inv
            if (isset($_POST['id_inv'])) {
                $id_inv = $_POST['id_inv']; // Obtenemos el id_inv desde el POST
                $materiaPrima = new MateriaPrima();
        
                // Llamamos a la función para obtener los datos del inventario
                $data = $materiaPrima->obtenerMateriaPrimaPorId($id_inv);
        
                if ($data) {
                    // Si se obtuvo el registro, lo retornamos en formato JSON
                    echo json_encode(['status' => 'success', 'data' => $data]);
                } else {
                    // Si no se encuentra el registro, enviamos un mensaje de error
                    echo json_encode(['status' => 'error', 'message' => 'No se pudo obtener la materia prima.']);
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



 
?>