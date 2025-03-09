<?php
class HistorialSalidas {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function obtenerHistorialSalidas() {
        $query = "CALL TP_historial_1()";

        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $data = $result->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $data;
        } else {
            $stmt->close();
            throw new Exception("Error al ejecutar la consulta: " . $this->conn->error);
        }
    }

    public function obtenerDetallesSalida($idDespacho) {
        $query = "CALL TP_historial_2(?)";
    
        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }
    
        $stmt->bind_param("i", $idDespacho);
    
        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $data = $result->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $data;
        } else {
            $stmt->close();
            throw new Exception("Error al ejecutar la consulta: " . $this->conn->error);
        }
    }
    public function cancelarDespacho($idDespacho) {
        $query = "CALL TP_cancelar_salida(?)";
        $stmt = $this->conn->prepare($query);
    
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }
    
        $stmt->bind_param("i", $idDespacho);
    
        if ($stmt->execute()) {
            // Si la ejecución fue exitosa, devolver un mensaje de éxito
            return ['status' => 'success', 'message' => 'El despacho ha sido cancelado correctamente.'];
        } else {
            // Si hubo un error, devolver un mensaje de error
            throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
        }
    }
}
?>