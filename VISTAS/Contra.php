<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Contraseña</title>
    <link rel="stylesheet" href="../FILES/stlogin.css">
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- Incluir SweetAlert2 -->
    <script src="JS/recuperar.js"></script>
</head>
<body>
    <div class="container">
        <div class="login-form">
            <div class="logo">
                <img src="../FILES/fran2.png" alt="Logo">
            </div>
            <h1>Recuperar Contraseña</h1>
            <form id="recuperarForm">
                <div class="form-group">
                    <label for="correo">Correo Electrónico:</label>
                    <input type="email" id="correo" name="correo" required>
                </div>
                <button type="submit">
                    <span class="box">Enviar</span>
                </button>
            </form>
        </div>
        <div class="image-container"></div>
    </div>
</body>
</html>