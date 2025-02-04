<?php
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modUsuario.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $codigo = $_POST['codigo'];
    $nueva_contrasenia = password_hash($_POST['nueva_contrasenia'], PASSWORD_BCRYPT);
    $usuarioModel = new Usuario();
    $usuario = $usuarioModel->obtenerUsuarioPorCodigo($codigo);

    if ($usuario) {
        $result = $usuarioModel->actualizarContrasenia($usuario['usu_id'], $nueva_contrasenia);
        if ($result) {
            echo json_encode(['status' => 'success', 'message' => 'Contraseña restablecida con éxito.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error al restablecer la contraseña.']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Código de verificación inválido.']);
    }
}
?>