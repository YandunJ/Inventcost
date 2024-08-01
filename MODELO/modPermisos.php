<?php
// MODELO/modPermisos.php

class Permisos {
    private $conn;
    
    public function __construct($db) {
        $this->conn = $db;
    }

    public function getPermisos() {
        $query = "SELECT permiso_id, permiso_nombre FROM permisos";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        $permisos = [];
        while ($row = $result->fetch_assoc()) {
            $permisos[] = $row;
        }
        return $permisos;
    }
}

?>
