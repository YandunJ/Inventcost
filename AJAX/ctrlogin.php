<?php
// AJAX/ctrlogin.php
session_start();
require_once "../CONFIG/conexion.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = $_POST['usuario'];
    $contrasenia = $_POST['contrasenia'];

    try {
        $conexion = new Cls_DataConnection();
        $conn = $conexion->FN_getConnect();
        $stmt = $conn->prepare("SELECT usu_id, usu_nombre, usu_apellido, usu_contrasenia FROM usuarios WHERE usu_usuario = ?");
        $stmt->bind_param('s', $usuario);
        $stmt->execute();
        $result = $stmt->get_result();
        $usuario_db = $result->fetch_assoc();

        if ($usuario_db && $contrasenia === $usuario_db['usu_contrasenia']) {
            $_SESSION['usuario_id'] = $usuario_db['usu_id'];
            $_SESSION['usuario_nombre'] = $usuario_db['usu_nombre'];
            $_SESSION['usuario_apellido'] = $usuario_db['usu_apellido'];
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
