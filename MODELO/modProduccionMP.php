<?php
// MODELO/modProduccionMP.php

class ProduccionMateriaPrima {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    } 

    public function obtenerMateriaPrima() {
        $sql = "CALL sp_Obt_inven_MP()"; // Llama al SP directamente
        $result = $this->conn->query($sql);
        if (!$result) {
            throw new Exception("Error en la ejecución de la consulta: " . $this->conn->error);
        }
        $data = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        return $data;
    }
}
?>
