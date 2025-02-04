<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restablecer Contraseña</title>
    <link rel="stylesheet" href="../FILES/stlogin.css">
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="JS/restablecer.js"></script>
</head>
<body>
    <div class="container">
        <div class="login-form">
            <div class="logo">
                <img src="../FILES/fran2.png" alt="Logo">
            </div>
            <h1>Restablecer Contraseña</h1>
            <form id="restablecerForm">
                <div class="form-group">
                    <label for="codigo">Código de Verificación:</label>
                    <input type="text" id="codigo" name="codigo" required>
                </div>
                <div class="form-group">
                    <label for="nueva_contrasenia">Nueva Contraseña:</label>
                    <input type="password" id="nueva_contrasenia" name="nueva_contrasenia" required>
                </div>
                <div class="form-group">
                    <label for="confirmar_contrasenia">Confirmar Contraseña:</label>
                    <input type="password" id="confirmar_contrasenia" name="confirmar_contrasenia" required>
                </div>
                <button type="submit">
                    <span class="box">Restablecer</span>
                </button>
            </form>
        </div>
        <div class="image-container"></div>
    </div>
</body>
</html>