<?php
// AJAX/ctrUsuario.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modUsuario.php";

// Captura la acción enviada por el cliente
$action = $_POST['action'] ?? ($_GET['action'] ?? '');

// Controlador principal
switch ($action) {
    case 'registrarUsuario':
        registrarUsuario();
        break;
    case 'actualizarUsuario':
        actualizarUsuario();
        break;
    case 'obtenerUsuarios':
        obtenerUsuarios();
        break;
    case 'obtenerUsuarioPorID':
        obtenerUsuarioPorID();
        break;
    case 'obtenerRoles':
        obtenerRoles();
        break;
        case 'cambiarEstadoUsuario':
            cambiarEstadoUsuario();
            break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function cambiarEstadoUsuario() {
    try {
        $usuarioModel = new Usuario();
        $usu_id = $_POST['usu_id'];
        $estado = $_POST['estado'];

        $result = $usuarioModel->cambiarEstadoUsuario($usu_id, $estado);

        if ($result) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al cambiar el estado del usuario.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

// Funciones relacionadas
function registrarUsuario() {
    try {
        $usuarioModel = new Usuario();
        $cedula = $_POST['cedula'];
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $telefono = $_POST['telefono'];
        $usuario = $_POST['usuario'];
        $contrasenia = password_hash($_POST['contrasenia'], PASSWORD_BCRYPT);
        $rol_id = $_POST['rol_id'];
        
        $correo = $_POST['correo'];

        $result = $usuarioModel->gestionarUsuario(1, NULL, $cedula, $nombre, $apellido, $telefono, $usuario, $contrasenia, $rol_id, $correo);

        if ($result) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al registrar usuario.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function actualizarUsuario() {
    try {
        $usuarioModel = new Usuario();
        $usu_id = $_POST['usu_id'];
        $cedula = $_POST['cedula'];
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $telefono = $_POST['telefono'];
        $usuario = $_POST['usuario'];
        $contrasenia = !empty($_POST['contrasenia']) ? password_hash($_POST['contrasenia'], PASSWORD_BCRYPT) : NULL;
        $rol_id = $_POST['rol_id'];
        $correo = $_POST['correo'];

        $result = $usuarioModel->gestionarUsuario(2, $usu_id, $cedula, $nombre, $apellido, $telefono, $usuario, $contrasenia, $rol_id, $correo);

        if ($result) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al actualizar usuario.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

function obtenerUsuarios() {
    try {
        $usuarioModel = new Usuario();
        $usuarios = $usuarioModel->obtenerUsuarios();

        if (isset($usuarios['error'])) {
            throw new Exception($usuarios['error']);
        }

        echo json_encode(['status' => 'success', 'data' => $usuarios]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
function obtenerUsuarioPorID() {
    try {
        $usuarioModel = new Usuario();
        $usu_id = $_POST['usu_id'];
        $usuario = $usuarioModel->obtenerUsuarioPorID($usu_id);

        if (isset($usuario['error'])) {
            throw new Exception($usuario['error']);
        }

        echo json_encode(['status' => 'success', 'data' => $usuario]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
function obtenerRoles() {
    try {
        $usuarioModel = new Usuario();
        $roles = $usuarioModel->obtenerRoles();

        if (isset($roles['error'])) {
            throw new Exception($roles['error']);
        }

        echo json_encode(['status' => 'success', 'data' => $roles]);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>