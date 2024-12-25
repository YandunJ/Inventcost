<?php
class KardexModel {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function obtenerKardex($fechaInicio, $fechaFin, $categoria) {
        $stmt = $this->conn->prepare("CALL Kardex_data(?, ?, ?)");
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }

        $stmt->bind_param("sss", $fechaInicio, $fechaFin, $categoria);
        $stmt->execute();
        $result = $stmt->get_result();
        $datos = [];

        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }

        $stmt->close();
        return $datos;
    }

    public function obtenerEntradas($articuloId) {
        $stmt = $this->conn->prepare("CALL Kardex_entradas(?)");
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }

        $stmt->bind_param("i", $articuloId);
        $stmt->execute();
        $result = $stmt->get_result();
        $datos = [];

        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }

        $stmt->close();
        error_log(print_r($datos, true)); // Usar error_log para depurar
        return $datos;
    }
}
?>