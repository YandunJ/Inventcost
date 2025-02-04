<?php
session_start();
if (empty($_SESSION['usuario_id']) || empty($_SESSION['estado']) || $_SESSION['estado'] !== 'habilitado') {
    header('Location: ../VISTAS/frlogin.php');
    exit();
}
$usuario_id = $_SESSION['usuario_id'];
$rol_id = $_SESSION['rol_id'];
?>