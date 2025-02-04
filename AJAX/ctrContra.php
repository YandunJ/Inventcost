<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../CONFIG/conexion.php";
require_once "../MODELO/modUsuario.php";
require_once "../vendor/autoload.php"; // Esta ruta es correcta

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $correo = $_POST['correo'];
    $usuarioModel = new Usuario();
    $usuario = $usuarioModel->obtenerUsuarioPorCorreo($correo);

    if ($usuario) {
        $codigo = rand(100000, 999999);
        $usuarioModel->guardarCodigoVerificacion($usuario['usu_id'], $codigo);

        $mail = new PHPMailer(true);
        try {
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com'; // Servidor SMTP de Gmail
            $mail->SMTPAuth = true;
            $mail->Username = 'jeffersonyandun01@gmail.com'; // Tu dirección de correo de Gmail
            $mail->Password = ''; // Tu contraseña de Gmail
            $mail->SMTPSecure = 'tls';
            $mail->Port = 587;

            $mail->setFrom('jeffersonyandun01@gmail.com', 'Jefferson'); // Tu dirección de correo y nombre
            $mail->addAddress($correo);

            $mail->isHTML(true);
            $mail->Subject = 'Código de Verificación';
            $mail->Body    = "Tu código de verificación es: $codigo";

            $mail->send();
            echo json_encode(['status' => 'success', 'message' => 'Correo enviado con éxito.']);
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => 'Error al enviar el correo: ' . $mail->ErrorInfo]);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Correo no encontrado.']);
    }
}
?>