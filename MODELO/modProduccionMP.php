<?php
// MODELO/modProduccionMP.php

class Produccion {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function registrarProduccion($cant_producida, $lotes_mp, $lotes_ins) {
        $sql = "CALL PROD_sp(?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("dss", $cant_producida, $lotes_mp, $lotes_ins);
    
        if ($stmt->execute()) {
            return ['status' => 'success', 'message' => 'Producción registrada correctamente'];
        } else {
            return ['status' => 'error', 'message' => $stmt->error];
        }
    }
}
?>