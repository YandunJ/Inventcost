<?php
require_once "../CONFIG/conexion.php";

class PresentacionInsumos {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

    public function gestionarPresentacion($opcion, $prs_id, $prs_nombre, $prs_abreviacion) {
        // Validar si la presentación ya existe en la base de datos
        if ($opcion == 1) {
            $queryExist = "SELECT COUNT(*) AS total FROM presentacion WHERE prs_nombre = ? AND prs_abreviacion = ? AND ctg_id = 2";
            $paramsExist = [$prs_nombre, $prs_abreviacion];
        } else {
            $queryExist = "SELECT COUNT(*) AS total FROM presentacion WHERE prs_nombre = ? AND prs_abreviacion = ? AND prs_id != ? AND ctg_id = 2";
            $paramsExist = [$prs_nombre, $prs_abreviacion, $prs_id];
        }

        $resultExist = $this->conn->ejecutarSP($queryExist, $paramsExist);

        if ($resultExist && $resultExist->fetch_assoc()['total'] > 0) {
            return ['error' => 'La presentación ya existe con este nombre y abreviación.'];
        }

        // Ejecutar el procedimiento almacenado para agregar o actualizar
        $query = "CALL UM_CRUD_ins(?, ?, ?, ?)";
        $params = [$opcion, $prs_id, $prs_nombre, $prs_abreviacion];
        return $this->conn->ejecutarSP($query, $params);
    }

    public function obtenerPresentacionPorId($prs_id) {
        $query = "CALL UM_data_id_ins(?)";
        $params = [$prs_id];
        return $this->conn->ejecutarSP($query, $params)->fetch_assoc();
    }

    public function obtenerPresentacionesInsumos() {
        $query = "CALL UM_data_ins()";
        return $this->conn->ejecutarSP($query);
    }
}
?>