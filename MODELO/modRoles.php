<?php
// MODELO/modRoles.php


class Frutas {
    private $conn;
    private $table_name = "frutas";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addFruit($nombre, $descripcion) {
        $query = "CALL sp_reg_fruta(?, ?)";
        $stmt = $this->conn->prepare($query);

        // sanitize
        $nombre = htmlspecialchars(strip_tags($nombre));
        $descripcion = htmlspecialchars(strip_tags($descripcion));

        // bind values
        $stmt->bind_param('ss', $nombre, $descripcion);

        try {
            if ($stmt->execute()) {
                return true;
            }
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
        }
        return false;
    }

    public function updateFruit($fruta_id, $nombre, $descripcion) {
        $query = "UPDATE " . $this->table_name . " SET nombre = ?, descripcion = ? WHERE fruta_id = ?";
        $stmt = $this->conn->prepare($query);

        // sanitize
        $nombre = htmlspecialchars(strip_tags($nombre));
        $descripcion = htmlspecialchars(strip_tags($descripcion));
        $fruta_id = htmlspecialchars(strip_tags($fruta_id));

        // bind values
        $stmt->bind_param('ssi', $nombre, $descripcion, $fruta_id);

        if ($stmt->execute()) {
            return true;
        }
        return false;   
    }
}



/*
class Roles {
    private $conn;
    private $table_name = "roles";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addRole($rol_nombre, $rol_descripcion, $permiso_id) {
        $query = "CALL sp_registrar_rol(?, ?, ?)";
        $stmt = $this->conn->prepare($query);
    
        // sanitize
        $rol_nombre = htmlspecialchars(strip_tags($rol_nombre));
        $rol_descripcion = htmlspecialchars(strip_tags($rol_descripcion));
        $permiso_id = htmlspecialchars(strip_tags($permiso_id));
    
        // bind values
        $stmt->bind_param('ssi', $rol_nombre, $rol_descripcion, $permiso_id);
    
        try {
            if ($stmt->execute()) {
                return true;
            }
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
        }
        return false;
    }
    

    public function updateRole($rol_id, $rol_nombre, $rol_descripcion, $rol_area_trabajo) {
        $query = "UPDATE " . $this->table_name . " SET rol_nombre = ?, rol_descripcion = ?, rol_area_trabajo = ? WHERE rol_id = ?";
        $stmt = $this->conn->prepare($query);

        // sanitize
        $rol_nombre = htmlspecialchars(strip_tags($rol_nombre));
        $rol_descripcion = htmlspecialchars(strip_tags($rol_descripcion));
        $rol_area_trabajo = htmlspecialchars(strip_tags($rol_area_trabajo));
        $rol_id = htmlspecialchars(strip_tags($rol_id));

        // bind values
        $stmt->bind_param('ssii', $rol_nombre, $rol_descripcion, $rol_area_trabajo, $rol_id);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }
}
    */
?>
