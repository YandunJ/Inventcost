<?php
// AJAX/ctrInvCatalogo.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modInvCatalogo.php";

// Captura la acción enviada por el cliente
$action = $_POST['action'] ?? ($_GET['action'] ?? '');

// Controlador principal
switch ($action) {
    case 'getCategorias':
        getCategorias();
        break;
    case 'getUnidadesMedida':
        getUnidadesMedida();
        break;
    case 'getArticuloById':
        getArticuloById();
        break;
    case 'addArticulo':
        addArticulo();
        break;
    case 'updateArticulo':
        updateArticulo();
        break;
    case 'obtenerArticulos':
        obtenerArticulos();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

// Funciones relacionadas
function getCategorias() {
    try {
        $model = new InvCatalogo();
        $categorias = $model->getCategorias();

        if (isset($categorias['error'])) {
            throw new Exception($categorias['error']);
        }

        // Solo devolver las primeras tres categorías
        $categorias = array_slice($categorias, 0, 3);

        echo json_encode(['status' => 'success', 'data' => $categorias]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function getUnidadesMedida() {
    try {
        $model = new InvCatalogo();
        $unidades = $model->getUnidadesMedida();

        if (isset($unidades['error'])) {
            throw new Exception($unidades['error']);
        }

        echo json_encode(['status' => 'success', 'data' => $unidades]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function getArticuloById() {
    $id_articulo = $_POST['id_articulo'] ?? null;

    if (!$id_articulo) {
        echo json_encode(['status' => 'error', 'message' => 'El ID del artículo es obligatorio.']);
        return;
    }

    try {
        $inventarioModel = new InvCatalogo();
        $articulo = $inventarioModel->getArticuloById($id_articulo); // Ajusta el modelo para que devuelva una fila
        if ($articulo) {
            echo json_encode(['status' => 'success', 'data' => $articulo]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Artículo no encontrado.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function addArticulo() {
    // Validar campos obligatorios
    $requiredFields = ['nombre', 'id_categoria', 'unidad_medida'];
    foreach ($requiredFields as $field) {
        if (empty($_POST[$field])) {
            echo json_encode(['status' => 'error', 'message' => "El campo $field es obligatorio."]);
            return;
        }
    }

    try {
        $inventarioModel = new InvCatalogo();
        $result = $inventarioModel->addOrUpdateArticulo(
            1, // Operación: Agregar
            0, // ID (se ignora en inserción)
            $_POST['nombre'],
            $_POST['id_categoria'],
            $_POST['unidad_medida']
        );

        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Artículo registrado correctamente.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al registrar el artículo.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function updateArticulo() {
    // Validar campos obligatorios
    $requiredFields = ['id_articulo', 'nombre', 'id_categoria', 'unidad_medida'];
    foreach ($requiredFields as $field) {
        if (empty($_POST[$field])) {
            echo json_encode(['status' => 'error', 'message' => "El campo $field es obligatorio."]);
            return;
        }
    }

    try {
        $inventarioModel = new InvCatalogo();
        $result = $inventarioModel->addOrUpdateArticulo(
            2, // Operación: Actualizar
            $_POST['id_articulo'],
            $_POST['nombre'],
            $_POST['id_categoria'],
            $_POST['unidad_medida']
        );

        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Artículo actualizado correctamente.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se pudo actualizar el artículo.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerArticulos() {
    try {
        $inventarioModel = new InvCatalogo();
        $articulos = $inventarioModel->getArticulos();

        if (isset($articulos['error'])) {
            throw new Exception($articulos['error']);
        }

        echo json_encode(['status' => 'success', 'data' => $articulos]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>