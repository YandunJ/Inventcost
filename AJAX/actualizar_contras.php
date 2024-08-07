<?php
// actualizar_contras.php

require_once "../CONFIG/conexion.php";

$conexion = new Cls_DataConnection();
$conn = $conexion->FN_getConnect();
$usuarios = [
    ['usu_id' => 1, 'usu_contrasenia' => 'j'],
    ['usu_id' => 2, 'usu_contrasenia' => 'p'],
    // Agrega más usuarios según sea necesario
];

foreach ($usuarios as $usuario) {
    $hashedPassword = password_hash($usuario['usu_contrasenia'], PASSWORD_BCRYPT);
    $stmt = $conn->prepare("UPDATE usuarios SET usu_contrasenia = ? WHERE usu_id = ?");
    $stmt->bind_param('si', $hashedPassword, $usuario['usu_id']);
    $stmt->execute();
}

echo "Contraseñas actualizadas.";
