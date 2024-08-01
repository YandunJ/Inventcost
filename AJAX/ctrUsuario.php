<?php
// AJAX/ctrUsuario.php
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modUsuario.php";

if (isset($_GET['action'])) {
    $action = $_GET['action'];
    $usuario = new Usuario();

    switch ($action) {
        case 'obtenerRoles':
            try {
                $roles = $usuario->obtenerRoles();
                echo json_encode(['status' => 'success', 'data' => $roles]);
            } catch (Exception $e) {
                echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
            }
            break;
        case 'registrarUsuario':
            try {
                $cedula = $_POST['cedula'];
                $nombre = $_POST['nombre'];
                $apellido = $_POST['apellido'];
                $telefono = $_POST['telefono'];
                $correo = $_POST['correo'];
                $direccion = $_POST['direccion'];
                $usuarioNombre = $_POST['usuario'];
                $contrasenia = $_POST['contrasenia'];
                $rol_id = $_POST['rol_id'];

                $result = $usuario->insertarUsuario($cedula, $nombre, $apellido, $telefono, $correo, $direccion, $usuarioNombre, $contrasenia, $rol_id);

                if ($result) {
                    echo json_encode(['status' => 'success']);
                } else {
                    throw new Exception('Error al registrar usuario');
                }
            } catch (Exception $e) {
                echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
            }
            break;
        default:
            echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'No se especificó ninguna acción']);
}
?>
