<?php
// MODELO/sbinsumos.php

class InsumosModel {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function obtenerInsumos() {
        $query = "SELECT insumo_id, nombre FROM insumos";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();

        $insumos = array();
        while ($row = $result->fetch_assoc()) {
            $insumos[] = $row;
        }

        return $insumos;
    }


    public function obtenerProveedores() {
        $query = "SELECT proveedor_id, nombre_empresa FROM proveedores";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();

        $proveedores = array();
        while ($row = $result->fetch_assoc()) {
            $proveedores[] = $row;
        }

        return $proveedores;
    }


}
?>

