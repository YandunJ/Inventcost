<?php
require_once "../CONFIG/conexion.php";

class Presentacion {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

    public function gestionarPresentacion($opcion, $prs_id, $prs_nombre, $prs_abreviacion, $prs_estado, $ctg_id, $equivalencia) {
        // Ajustar abreviación según categoría
        if ($ctg_id == 3) {
            $prs_abreviacion = ''; // Producto Terminado no usa abreviación
        }
        $query = "CALL UM_CRUD(?, ?, ?, ?, ?, ?, ?)";
        $params = [$opcion, $prs_id, $prs_nombre, $prs_abreviacion, $prs_estado, $ctg_id, $equivalencia];
        return $this->conn->ejecutarSP($query, $params);
    }
    

    public function obtenerPresentacionPorId($prs_id) {
        $query = "CALL UM_data_id(?)";
        $params = [$prs_id];
        return $this->conn->ejecutarSP($query, $params)->fetch_assoc();
    }

    public function obtenerTodasPresentaciones() {
        $query = "CALL UM_data()";
        return $this->conn->ejecutarSP($query);
    }
}
?>