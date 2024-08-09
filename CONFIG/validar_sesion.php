<?php
// CONFIG/validar_sesion.php
session_start();
if (empty($_SESSION['usuario_id'])) {
    header('Location: ../VISTAS/frlogin.php');
    exit();
}
$usuario_id = $_SESSION['usuario_id'];
?>
