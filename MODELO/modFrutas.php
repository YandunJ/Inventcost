<?php
// MODELO/modFrutas.php

class Frutas {
    private $conn;
    private $table_name = "frutas";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addOrUpdateFruta($opcion, $fruta_id, $nombre, $descripcion) {
        $query = "CALL sp_reg_act_fruta(?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
    
        // sanitize
        $nombre = htmlspecialchars(strip_tags($nombre));
        $descripcion = htmlspecialchars(strip_tags($descripcion));
    
        // bind values
        $stmt->bind_param('iiss', $opcion, $fruta_id, $nombre, $descripcion);
    
        try {
            if ($stmt->execute()) {
                return true;
            }
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
        }
        return false;
    }

    public function getFrutas() {
        $query = "CALL pa_obtener_frutas()";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        $frutas = array();

        while ($row = $result->fetch_assoc()) {
            $frutas[] = $row;
        }

        return array('data' => $frutas);
    }

    public function deleteFruta($fruta_id) {
        $query = "CALL pa_borrar_fruta(?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $fruta_id);

        try {
            if ($stmt->execute()) {
                return true;
            }
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
        }
        return false;
    }
}

?>
