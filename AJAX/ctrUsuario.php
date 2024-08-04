<?php
// AJAX/ctrUsuario.php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../CONFIG/conexion.php';
require_once '../MODELO/modUsuario.php';
require_once '../MODELO/sbRoles.php';

$conn = (new Cls_DataConnection())->FN_getConnect();

$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'obtenerRoles':
        obtenerRoles();
        break;
    case 'registrarUsuario':
        registrarUsuario();
        break;
    case 'actualizarUsuario':
        actualizarUsuario();
        break;
    case 'obtenerUsuarios':
        obtenerUsuarios();
        break;
    case 'eliminarUsuario':
        eliminarUsuario();
        break;
    case 'obtenerUsuarioPorID':
        obtenerUsuarioPorID();
        break;
    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}

function obtenerRoles() {
    global $conn;
    $rolesModel = new Roles($conn);
    $roles = $rolesModel->getRoles();
    
    if (!$roles) {
        echo json_encode(['status' => 'error', 'message' => 'No se pudieron obtener los roles']);
    } else {
        $response = ['status' => 'success', 'data' => $roles];
        error_log(json_encode($response)); // Log para depuración
        echo json_encode($response);
    }
}

function registrarUsuario() {
    global $conn;

    $cedula = $_POST['cedula'];
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $telefono = $_POST['telefono'];
    $direccion = $_POST['direccion'];
    $correo = $_POST['correo'];
    $usuario = $_POST['usuario'];
    $contrasenia = password_hash($_POST['contrasenia'], PASSWORD_BCRYPT);
    $rol_id = $_POST['rol_id'];

    $sql = "CALL sp_reg_usu('$cedula', '$nombre', '$apellido', '$telefono', '$direccion', '$correo', '$usuario', '$contrasenia', $rol_id)";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        echo json_encode(['status' => 'success']);
    } else {
        error_log("Error al registrar usuario: " . mysqli_error($conn)); // Log de errores
        echo json_encode(['status' => 'error', 'message' => 'Error al registrar usuario.']);
    }
}

function actualizarUsuario() {
    global $conn;

    $usu_id = $_POST['usu_id'];
    $cedula = $_POST['cedula'];
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $telefono = $_POST['telefono'];
    $direccion = $_POST['direccion'];
    $correo = $_POST['correo'];
    $usuario = $_POST['usuario'];
    $contrasenia = password_hash($_POST['contrasenia'], PASSWORD_BCRYPT);
    $rol_id = $_POST['rol_id'];

    $sql = "CALL sp_act_usu($usu_id, '$cedula', '$nombre', '$apellido', '$telefono', '$direccion', '$correo', '$usuario', '$contrasenia', $rol_id)";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        echo json_encode(['status' => 'success']);
    } else {
        error_log("Error al actualizar usuario: " . mysqli_error($conn)); // Log de errores
        echo json_encode(['status' => 'error', 'message' => 'Error al actualizar usuario.']);
    }
}

function obtenerUsuarios() {
    global $conn;

    $sql = "CALL pa_obtener_usuarios()";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        $usuarios = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $usuarios[] = $row;
        }
        echo json_encode(['status' => 'success', 'data' => $usuarios]);
    } else {
        error_log("Error al obtener usuarios: " . mysqli_error($conn)); // Log de errores
        echo json_encode(['status' => 'error', 'message' => 'Error al obtener usuarios.']);
    }
}

function eliminarUsuario() {
    global $conn;

    $usu_id = $_POST['usu_id'];

    $sql = "CALL pa_eliminar_usu($usu_id)";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        echo json_encode(['status' => 'success']);
    } else {
        error_log("Error al eliminar usuario: " . mysqli_error($conn)); // Log de errores
        echo json_encode(['status' => 'error', 'message' => 'Error al eliminar usuario.']);
    }
}

function obtenerUsuarioPorID() {
    global $conn;

    $usu_id = $_GET['usu_id'];

    $sql = "CALL sp_obt_usu__id($usu_id)"; // Asegúrate que el nombre del SP sea correcto
    $result = mysqli_query($conn, $sql);

    if ($result) {
        $usuario = mysqli_fetch_assoc($result);
        echo json_encode(['status' => 'success', 'data' => $usuario]);
    } else {
        error_log("Error al obtener usuario por ID: " . mysqli_error($conn)); // Log de errores
        echo json_encode(['status' => 'error', 'message' => 'Error al obtener usuario.']);
    }
}


?>


