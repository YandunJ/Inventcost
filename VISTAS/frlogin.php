<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="../FILES/stlogin.css"> <!-- Ruta al archivo CSS -->
    <script src="../FILES/jquery-3.7.1.min.js"></script> <!-- Ruta a jQuery -->
    <script src="JS/log.js"></script> <!-- Ruta al archivo JS -->
</head>
<body>
    <div class="login-container">
        <h2>Iniciar Sesión</h2>
        <form id="loginForm">
            <div class="form-group">
                <label for="Usuario">Usuario:</label>
                <input type="text" id="Usuario" name="Usuario" required>
            </div>
            <div class="form-group">
                <label for="Contrasenia">Contraseña:</label>
                <input type="password" id="Contrasenia" name="Contrasenia" required>
            </div>
            <button type="submit">
                <span class="box">
                    Ingresar
                </span>
            </button>
            <h6>Ingresa tus credenciales para inicar sesión</h6>
        </form>
    </div>
</body>
</html>
