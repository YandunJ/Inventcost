<?php

//AJAX/sesion.php

session_start();
header('Content-Type: application/json');

if (isset($_SESSION['usuario_id'])) {
    require_once '../CONFIG/conexion.php';
    
    $usuario_id = $_SESSION['usuario_id'];
    
    $stmt = $pdo->prepare("SELECT usu_nombre FROM usuarios WHERE usu_id = ?");
    $stmt->execute([$usuario_id]);
    $usuario = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($usuario) {
        echo json_encode([
            'status' => 'success',
            'nombre' => $usuario['usu_nombre']
        ]);
    } else {
        echo json_encode(['status' => 'error']);
    }
} else {
    echo json_encode(['status' => 'not_logged_in']);
}
?>

