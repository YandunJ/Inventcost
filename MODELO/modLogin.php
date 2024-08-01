<?php

//MODELO/modLogin.php

require_once "../CONFIG/conexion.php";

class Usuario {
    public function verificarUsuario($usu_usuario, $usu_contrasenia) {
        $sql = "SELECT * FROM usuarios WHERE usu_usuario = '$usu_usuario' AND usu_contrasenia = '$usu_contrasenia'";
        return ejecutarConsultaSP($sql);
    }
}
?>
