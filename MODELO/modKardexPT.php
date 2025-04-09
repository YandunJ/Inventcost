<?php
class KardexPT {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    // Obtener datos del Kardex de productos terminados
    public function obtenerKardexPT($fecha_inicio, $fecha_fin) {
        $stmt = $this->conn->prepare("CALL TP_KardexGeneral(?, ?)");
        $stmt->bind_param('ss', $fecha_inicio, $fecha_fin);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        return $data;
    }
    public function obtenerDetalleKardexPT($presentacion, $fecha_inicio, $fecha_fin) {
        $stmt = $this->conn->prepare("CALL TP_DetalleKardexPT(?, ?, ?)");
        $stmt->bind_param('sss', $presentacion, $fecha_inicio, $fecha_fin);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();
    
        return $data;
    }
}
?>