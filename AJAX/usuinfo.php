<?php
// AJAX/getUserInfo.php

session_start();

$response = array('status' => 'error');

if (isset($_SESSION['usuario_id'])) {
    $response['status'] = 'success';
    $response['usuario_nombre'] = $_SESSION['usuario_nombre'];
    $response['usuario_apellido'] = $_SESSION['usuario_apellido'];
}

echo json_encode($response);
?>