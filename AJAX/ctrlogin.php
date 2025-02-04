<?php
session_start();
require_once "../CONFIG/conexion.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = $_POST['Usuario'];
    $contrasenia = $_POST['Contrasenia'];

    try {
        $conexion = new Cls_DataConnection();
        $conn = $conexion->FN_getConnect();
        $stmt = $conn->prepare("SELECT * FROM usuarios WHERE usu_usuario = ?");
        $stmt->bind_param('s', $usuario);
        $stmt->execute();
        $result = $stmt->get_result();
        $usuario_db = $result->fetch_assoc();

        if ($usuario_db && password_verify($contrasenia, $usuario_db['usu_contrasenia']) && $usuario_db['estado'] === 'habilitado') {
            $_SESSION['usuario_id'] = $usuario_db['usu_id'];
            $_SESSION['nombre'] = $usuario_db['usu_nombre'];
            $_SESSION['apellido'] = $usuario_db['usu_apellido'];
            $_SESSION['rol_id'] = $usuario_db['rol_id'];
            $_SESSION['estado'] = $usuario_db['estado'];

            echo 'success';
        } else {
            echo 'error';
        }
    } catch (Exception $e) {
        error_log($e->getMessage());
        echo 'error';
    }
}
?>