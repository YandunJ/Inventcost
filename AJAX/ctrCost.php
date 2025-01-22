<?php
// AJAX/ctrCost.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modCost.php";

// Captura la acción enviada por el cliente
$action = $_POST['action'] ?? ($_GET['action'] ?? '');

// Controlador principal
switch ($action) {
    case 'getCategorias':
        getCategorias();
        break;
    case 'getCostoById':
        getCostoById();
        break;
    case 'addCosto':
        addCosto();
        break;
    case 'updateCosto':
        updateCosto();
        break;
    case 'obtenerCostos':
        obtenerCostos();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

// Funciones relacionadas
function getCategorias() {
    try {
        $model = new Costos();
        $categorias = $model->getCategorias();

        if (isset($categorias['error'])) {
            throw new Exception($categorias['error']);
        }

        echo json_encode(['status' => 'success', 'data' => $categorias]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
function getCostoById() {
    $id_costo = $_POST['id_costo'] ?? null;

    if (!$id_costo) {
        echo json_encode(['status' => 'error', 'message' => 'El ID del costo es obligatorio.']);
        return;
    }

    try {
        $costosModel = new Costos();
        $costo = $costosModel->getCostoById($id_costo);
        if ($costo) {
            echo json_encode(['status' => 'success', 'data' => $costo]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Costo no encontrado.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function addCosto() {
    // Validar campos obligatorios
    $requiredFields = ['nombre', 'categoria', 'estado'];
    foreach ($requiredFields as $field) {
        if (empty($_POST[$field])) {
            echo json_encode(['status' => 'error', 'message' => "El campo $field es obligatorio."]);
            return;
        }
    }

    $prs_id = $_POST['categoria'] == 5 ? $_POST['unidad_medida'] : null; // Obtener prs_id solo si es categoría de costos indirectos

    try {
        $costosModel = new Costos();
        $result = $costosModel->addOrUpdateCosto(
            1, // Operación: Agregar
            0, // ID (se ignora en inserción)
            $_POST['nombre'],
            $_POST['categoria'],
            $prs_id,
            $_POST['estado']
        );

        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Costo registrado correctamente.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al registrar el costo.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function updateCosto() {
    // Validar campos obligatorios
    $requiredFields = ['id_costo', 'nombre', 'categoria', 'estado'];
    foreach ($requiredFields as $field) {
        if (empty($_POST[$field])) {
            echo json_encode(['status' => 'error', 'message' => "El campo $field es obligatorio."]);
            return;
        }
    }

    $prs_id = $_POST['categoria'] == 5 ? $_POST['unidad_medida'] : null; // Obtener prs_id solo si es categoría de costos indirectos

    try {
        $costosModel = new Costos();
        $result = $costosModel->addOrUpdateCosto(
            2, // Operación: Actualizar
            $_POST['id_costo'],
            $_POST['nombre'],
            $_POST['categoria'],
            $prs_id,
            $_POST['estado']
        );

        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Costo actualizado correctamente.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se pudo actualizar el costo.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}


function obtenerCostos() {
    try {
        $costosModel = new Costos();
        $costos = $costosModel->getCostos();

        if (isset($costos['error'])) {
            throw new Exception($costos['error']);
        }   

        echo json_encode(['status' => 'success', 'data' => $costos]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>