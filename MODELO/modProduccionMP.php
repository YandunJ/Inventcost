<?php
// MODELO/modProduccionMP.php

class Produccion {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function registrarProduccion($cant_producida, $lotes_mp, $lotes_ins, $mano_obra, $costos_indirectos) {
        $sql = "CALL PR_consumo(?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("dssss", $cant_producida, $lotes_mp, $lotes_ins, $mano_obra, $costos_indirectos);
    
        if ($stmt->execute()) {
            return ['status' => 'success', 'message' => 'Producción registrada correctamente'];
        } else {
            return ['status' => 'error', 'message' => $stmt->error];
        } 
    }

    public function obtenerPresentacionesPT() {
        $sql = "SELECT prs_id, prs_nombre, equivalencia FROM presentacion WHERE ctg_id = 3 AND prs_estado = 'vigente'";
        $result = $this->conn->query($sql);

        $data = [];
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }
}
?>