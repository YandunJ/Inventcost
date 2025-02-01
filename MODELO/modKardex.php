<?php
class KardexModel {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function obtenerKardex($mes, $anio, $categoria) {
        $stmt = $this->conn->prepare("CALL kardex_G(?, ?, ?)");
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }

        $stmt->bind_param("iii", $mes, $anio, $categoria);
        $stmt->execute();
        $result = $stmt->get_result();
        $datos = [];

        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }

        $stmt->close();
        return $datos;
    }

    public function obtenerDetalleKardex($fechaInicio, $fechaFin, $categoria, $articulo) {
        $stmt = $this->conn->prepare("CALL kardex_det(?, ?, ?, ?)");
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }

        $stmt->bind_param("ssii", $fechaInicio, $fechaFin, $categoria, $articulo);
        $stmt->execute();
        $result = $stmt->get_result();
        $datos = [];

        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }

        $stmt->close();
        return $datos;
    }

    public function obtenerCategorias() {
        $stmt = $this->conn->prepare("SELECT ctg_id, ctg_nombre FROM categorias WHERE ctg_id IN (1, 2, 3)");
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }

        $stmt->execute();
        $result = $stmt->get_result();
        $categorias = [];

        while ($row = $result->fetch_assoc()) {
            $categorias[] = $row;
        }

        $stmt->close();
        return $categorias;
    }
}
?>