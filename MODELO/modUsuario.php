<?php
// MODELO/modUsuario.php
class Usuario {
    private $conn;

    public function __construct() {
        $this->conn = new Conexion();
    }
    public function insertarUsuario($cedula, $nombre, $apellido, $telefono, $correo, $direccion, $usuarioNombre, $contrasenia, $rol_id) {
        $query = "INSERT INTO usuarios (usu_cedula, usu_nombre, usu_apellido, usu_telefono, usu_correo, usu_direccion, usu_usuario, usu_contrasenia, rol_id, fecha_reg) 
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$cedula, $nombre, $apellido, $telefono, $correo, $direccion, $usuarioNombre, $contrasenia, $rol_id]);
    }

    public function obtenerUsuarios() {
        $query = "CALL pa_obtener_usuarios()";
        $result = $this->conn->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerUsuarioPorID($usu_id) {
        $query = "SELECT * FROM usuarios WHERE usu_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$usu_id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function actualizarUsuario($usu_id, $cedula, $nombre, $apellido, $telefono, $correo, $direccion, $usuarioNombre, $contrasenia, $rol_id) {
        $query = "UPDATE usuarios SET usu_cedula = ?, usu_nombre = ?, usu_apellido = ?, usu_telefono = ?, usu_correo = ?, usu_direccion = ?, usu_usuario = ?, usu_contrasenia = ?, rol_id = ? WHERE usu_id = ?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$cedula, $nombre, $apellido, $telefono, $correo, $direccion, $usuarioNombre, $contrasenia, $rol_id, $usu_id]);
    }

    public function eliminarUsuario($usu_id) {
        $query = "DELETE FROM usuarios WHERE usu_id = ?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$usu_id]);
    }
}
?>