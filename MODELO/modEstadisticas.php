<?php
require_once "../CONFIG/conexion.php";

class Estadisticas {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

  // Métodos nuevos para los lotes
  public function obtenerLotesMP() {
    $sql = "CALL EST_Lotes_MP_Disp()";
    $result = $this->conn->ejecutarSP($sql);
    return $result->fetch_assoc();
}

public function obtenerLotesINS() {
    $sql = "CALL EST_Lotes_INS_Disp()";
    $result = $this->conn->ejecutarSP($sql);
    return $result->fetch_assoc();
}

public function obtenerLotesPT() {
    $sql = "CALL EST_Lotes_PT_Disponibles()";
    $result = $this->conn->ejecutarSP($sql);
    return $result->fetch_assoc();
}

public function obtenerLotesProximosVencer() {
    $sql = "CALL EST_Lotes_Proximos_Vencer()";
    $result = $this->conn->ejecutarSP($sql);
    return $result->fetch_assoc();
}


    public function obtenerEntradasPorCategoria($mes, $anio) {
        $sql = "CALL Zentradas_cat(?, ?)";
        $params = [$mes, $anio];
        $result = $this->conn->ejecutarSP($sql, $params);

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