<?php
class Kardex {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    // Obtener datos del Kardex
    public function obtenerKardex($categoria_id, $fecha_inicio, $fecha_fin) {
        $stmt = $this->conn->prepare("CALL Akardex(?, ?, ?)");
        $stmt->bind_param('iss', $categoria_id, $fecha_inicio, $fecha_fin);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        return $data;
    }
}
?>