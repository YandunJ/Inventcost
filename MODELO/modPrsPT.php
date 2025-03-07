<?php
require_once "../CONFIG/conexion.php";

class PresentacionPT {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

    public function gestionarPresentacion($opcion, $prs_id, $prs_nombre, $equivalencia) {
        // Validar si la presentación ya existe en la base de datos
        if ($opcion == 1) {
            $queryExist = "SELECT COUNT(*) AS total FROM presentacion WHERE prs_nombre = ? AND equivalencia = ? AND ctg_id = 3";
            $paramsExist = [$prs_nombre, $equivalencia];
        } else {
            $queryExist = "SELECT COUNT(*) AS total FROM presentacion WHERE prs_nombre = ? AND equivalencia = ? AND prs_id != ? AND ctg_id = 3";
            $paramsExist = [$prs_nombre, $equivalencia, $prs_id];
        }

        $resultExist = $this->conn->ejecutarSP($queryExist, $paramsExist);

        if ($resultExist && $resultExist->fetch_assoc()['total'] > 0) {
            return ['error' => 'La presentación ya existe con este nombre y equivalencia.'];
        }

        // Ejecutar el procedimiento almacenado para agregar o actualizar
        $query = "CALL UM_CRUD_pt(?, ?, ?, ?)";
        $params = [$opcion, $prs_id, $prs_nombre, $equivalencia];
        return $this->conn->ejecutarSP($query, $params);
    }

    public function obtenerPresentacionPorId($prs_id) {
        $query = "CALL UM_data_id_pt(?)";
        $params = [$prs_id];
        return $this->conn->ejecutarSP($query, $params)->fetch_assoc();
    }

    public function obtenerPresentacionesPT() {
        $query = "CALL UM_data_pt()";
        return $this->conn->ejecutarSP($query);
    }
}
?>