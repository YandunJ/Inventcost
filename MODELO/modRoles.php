<?php
// MODELO/modRoles.php

class Roles {
    private $conn;
    private $table_name = "roles";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addRole($rol_nombre, $rol_descripcion, $permiso_id) {
        $query = "CALL acciones_rol(NULL, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('ssi', $rol_nombre, $rol_descripcion, $permiso_id);
        return $stmt->execute();
    }

    public function updateRole($rol_id, $rol_nombre, $rol_descripcion, $permiso_id) {
        $query = "CALL acciones_rol(?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('issi', $rol_id, $rol_nombre, $rol_descripcion, $permiso_id);
        return $stmt->execute();
    }

    public function deleteRole($rol_id) {
        $query = "CALL pa_eliminar_rol(?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $rol_id);
        return $stmt->execute();
    }

    public function getRoles() {
        $query = "CALL pa_obtener_roles()"; // Tu procedimiento
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $roles = [];
        while ($row = $result->fetch_assoc()) {
            $roles[] = $row;
        }
        
        return $roles;
    }

    public function getRoleById($rol_id) {
        $query = "SELECT rol_id, rol_nombre, rol_descripcion, permiso_id FROM roles WHERE rol_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $rol_id);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc(); // Retornar solo una fila
    }
    
    
}
?>
