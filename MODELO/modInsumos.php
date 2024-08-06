<?php

//MODELO/modInsumos.php
class Insumos {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addOrUpdateInsumo($opcion, $insumo_id, $nombre, $descripcion, $unidad_medida, $destino) {
        $query = "CALL acciones_insumo(?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);

        // sanitize
        $nombre = htmlspecialchars(strip_tags($nombre));
        $descripcion = htmlspecialchars(strip_tags($descripcion));
        $unidad_medida = htmlspecialchars(strip_tags($unidad_medida));
        $destino = htmlspecialchars(strip_tags($destino));

        // bind values
        $stmt->bind_param('issss', $insumo_id, $nombre, $descripcion, $unidad_medida, $destino);

        try {
            if ($stmt->execute()) {
                return true;
            }
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
        }
        return false;
    }
    
    public function getInsumos() {
        $query = "CALL pa_obt_insumos()";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        $insumos = array();

        while ($row = $result->fetch_assoc()) {
            $insumos[] = $row;
        }

        return $insumos; // Devuelve solo el array de insumos
    }

    public function deleteInsumo($insumo_id) {
        $query = "CALL pa_eliminar_insumo(?)"; // Asegúrate de que el nombre sea correcto
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $insumo_id);

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