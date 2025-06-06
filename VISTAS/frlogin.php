<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="../FILES/stlogin.css"> <!-- Ruta al archivo CSS -->
    
    
</head>
<body>
    <div class="container">
        <div class="login-form">   
            <div class="logo">
                <img src="../FILES/fran2.png" alt="Logo">
            </div>
            <h1>Iniciar Sesión</h1>
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
                    <span class="box">Acceder</span>
                </button>   
            </form>
           
        </div>
        <div class="image-container"></div>
    </div>
</body>
<script src="../FILES/jquery-3.7.1.min.js"></script> <!-- Ruta a jQuery -->
<script src="JS/log.js"></script> 
<script src="JS/zrotar.js"></script> <!-- Ruta al archivo JS -->
</html>