<?php
// MODELO/modKardex.php
class KardexModel {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function obtenerKardex($fechaInicio, $fechaFin, $categoria) {
        try {
            $stmt = $this->conn->prepare("CALL DatosKardex(?, ?, ?)");
            if (!$stmt) {
                throw new Exception("Error al preparar la consulta: " . $this->conn->error);
            }

            $stmt->bind_param("sss", $fechaInicio, $fechaFin, $categoria);
            if (!$stmt->execute()) {
                throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
            }

            $result = $stmt->get_result();
            $datos = [];
            while ($row = $result->fetch_assoc()) {
                $datos[] = $row;
            }

            $stmt->close();
            return $datos;
        } catch (Exception $e) {
            throw new Exception("Error en obtenerKardex: " . $e->getMessage());
        }
    }
}
?>
