<?php
// MODELO/sbmateria.php
class MateriaPrimaModel {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function obtenerFrutas() {
        $query = "SELECT fruta_id, nombre FROM frutas";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();

        $frutas = array();
        while ($row = $result->fetch_assoc()) {
            $frutas[] = $row;
        }

        return $frutas;
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
