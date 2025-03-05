<?php

class VentaPT {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    // Método para obtener el inventario de PT
    public function obtenerInventarioPT() {
        $query = "CALL TP_data()";

        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            return ['error' => "Error al preparar la consulta: " . $this->conn->error];
        }

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $inventario = $result->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $inventario;
        } else {
            $stmt->close();
            return ['error' => "Error al ejecutar la consulta: " . $this->conn->error];
        }
    }

    // Método para registrar un despacho
    public function registrarDespacho($despacho, $precio_total) {
        $query = "CALL TP_salida(?, ?)";

        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            return ['error' => "Error al preparar la consulta: " . $this->conn->error];
        }

        $stmt->bind_param("sd", $despacho, $precio_total);

        if ($stmt->execute()) {
            $affected_rows = $stmt->affected_rows;
            $stmt->close();

            if ($affected_rows > 0) {
                return ['status' => 'success', 'message' => 'Despacho registrado correctamente'];
            } else {
                return ['status' => 'error', 'message' => 'No se registró ningún despacho'];
            }
        } else {
            $stmt->close();
            return ['error' => "Error al ejecutar la consulta: " . $this->conn->error];
        }
    }
}
?>
