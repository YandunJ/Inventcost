<?php
// MODELO/modProducto.php

class Producto {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function obtenerLotesProductoTerminado() {
        $query = "CALL Tp_data()";

        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            return ['error' => "Error al preparar la consulta: " . $this->conn->error];
        }

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $lotes = $result->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $lotes;
        } else {
            $stmt->close();
            return ['error' => "Error al ejecutar la consulta: " . $this->conn->error];
        }
    }

    public function obtenerDetallesLote($lote_PT) {
        $query = "CALL Tp_detalles(?)";

        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            return ['error' => "Error al preparar la consulta: " . $this->conn->error];
        }

        $stmt->bind_param("s", $lote_PT);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $detalles = $result->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            return $detalles;
        } else {
            $stmt->close();
            return ['error' => "Error al ejecutar la consulta: " . $this->conn->error];
        }
    }
}
?>