<?php
// MODELO/modUsuario.php
class Usuario {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }



    
    public function obtenerUsuarioPorCorreo($correo) {
        $query = "SELECT * FROM usuarios WHERE correo = ?";
        $params = [$correo];
        return $this->conn->ejecutarSP($query, $params)->fetch_assoc();
    }

    public function guardarCodigoVerificacion($usu_id, $codigo) {
        $query = "UPDATE usuarios SET codigo_verificacion = ? WHERE usu_id = ?";
        $params = [$codigo, $usu_id];
        return $this->conn->ejecutarSP($query, $params);
    }

    public function obtenerUsuarioPorCodigo($codigo) {
        $query = "SELECT * FROM usuarios WHERE codigo_verificacion = ?";
        $params = [$codigo];
        return $this->conn->ejecutarSP($query, $params)->fetch_assoc();
    }

    public function actualizarContrasenia($usu_id, $nueva_contrasenia) {
        $query = "UPDATE usuarios SET usu_contrasenia = ?, codigo_verificacion = NULL WHERE usu_id = ?";
        $params = [$nueva_contrasenia, $usu_id];
        return $this->conn->ejecutarSP($query, $params);
    }


    public function gestionarUsuario($opcion, $usu_id, $cedula, $nombre, $apellido, $telefono, $usuarioNombre, $contrasenia, $rol_id, $correo) {
        $query = "CALL usu_CRUD(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $params = [$opcion, $usu_id, $cedula, $nombre, $apellido, $telefono, $usuarioNombre, $contrasenia, $rol_id, $correo];
        return $this->conn->ejecutarSP($query, $params);
    }

    public function obtenerUsuarios() {
        $query = "CALL usu_data()";
        $result = $this->conn->FN_getConnect()->query($query);

        if ($result) {
            $usuarios = [];
            while ($row = $result->fetch_assoc()) {
                $usuarios[] = $row;
            }
            return $usuarios;
        } else {
            return ['error' => 'Error al obtener usuarios: ' . $this->conn->FN_getConnect()->error];
        }
    }
    public function obtenerUsuarioPorID($usu_id) {
        $query = "CALL usu_data_id(?)";
        $params = [$usu_id];
    
        try {
            $result = $this->conn->ejecutarSP($query, $params);
            if ($result && $result->num_rows > 0) {
                return $result->fetch_assoc();
            } else {
                throw new Exception("No se encontraron datos para el ID: $usu_id");
            }
        } catch (Exception $e) {
            return null; // Manejo de errores simplificado
        }
    }

    public function obtenerRoles() {
        $query = "SELECT rol_id, rol_nombre FROM roles";
        $result = $this->conn->FN_getConnect()->query($query);

        if ($result) {
            $roles = [];
            while ($row = $result->fetch_assoc()) {
                $roles[] = $row;
            }
            return $roles;
        } else {
            return ['error' => 'Error al obtener roles: ' . $this->conn->FN_getConnect()->error];
        }
    }




    public function cambiarEstadoUsuario($usu_id, $estado) {
        $query = "UPDATE usuarios SET estado = ? WHERE usu_id = ?";
        $params = [$estado, $usu_id];
        return $this->conn->ejecutarSP($query, $params);
    }
}
?>