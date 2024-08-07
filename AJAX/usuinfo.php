<?php
// AJAX/usuinfo.php
session_start();

if (isset($_SESSION['usuario_id'])) {
    $response = array(
        'status' => 'success',
        'usuario_id' => $_SESSION['usuario_id'],
        'usuario_nombre' => $_SESSION['usuario_nombre'],
        'permiso_id' => $_SESSION['permiso_id'] // Asegúrate de que esto está presente
    );
    echo json_encode($response);
} else {
    $response = array('status' => 'error');
    echo json_encode($response);
}
?>
