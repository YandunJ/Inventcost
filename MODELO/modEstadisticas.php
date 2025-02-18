<?php
require_once "../CONFIG/conexion.php";

class Estadisticas {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

    public function obtenerCantidadFrutas() {
        $sql = "CALL ESTFrutas()";
        $result = $this->conn->ejecutarSP($sql);

        $data = [];
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }

        return $data;
    }

    public function obtenerCantidadProveedores() {
        $sql = "CALL ESTProv()";
        $result = $this->conn->ejecutarSP($sql);

        $data = $result->fetch_assoc();

        return $data;
    }

    public function obtenerCantidadPresentaciones() {
        $sql = "CALL ESTPresent()";
        $result = $this->conn->ejecutarSP($sql);

        $data = $result->fetch_assoc();

        return $data;
    }

    public function obtenerCantidadManoObra() {
        $sql = "CALL ESTManoObra()";
        $result = $this->conn->ejecutarSP($sql);

        $data = $result->fetch_assoc();

        return $data;
    }

    public function obtenerCantidadCostosInd() {
        $sql = "CALL ESTCostosInd()";
        $result = $this->conn->ejecutarSP($sql);

        $data = $result->fetch_assoc();

        return $data;
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