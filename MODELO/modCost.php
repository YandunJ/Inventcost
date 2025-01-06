<?php
// MODELO/modCost.php

require_once "../CONFIG/conexion.php";

class Costos {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

    // Método para agregar o actualizar un costo
    public function addOrUpdateCosto($opcion, $cat_id, $cat_nombre, $ctg_id, $cat_estado) {
        // Validar si el costo ya existe en la base de datos
        $queryExist = "SELECT COUNT(*) AS total FROM catalogo WHERE cat_nombre = ? AND ctg_id = ?";
        $paramsExist = [$cat_nombre, $ctg_id];
        $resultExist = $this->conn->ejecutarSP($queryExist, $paramsExist);

        if ($resultExist && $resultExist->fetch_assoc()['total'] > 0 && $opcion == 1) {
            return ['error' => 'El costo ya existe en el catálogo con esta categoría.'];
        }

        // Ejecutar el procedimiento almacenado para agregar o actualizar
        $query = "CALL Costos_CRUD(?, ?, ?, ?, ?)";
        $params = [$opcion, $cat_id, $cat_nombre, $ctg_id, $cat_estado];

        try {
            $result = $this->conn->ejecutarSP($query, $params);
            if ($result) {
                return true; // Procedimiento ejecutado correctamente
            } else {
                throw new Exception("No se obtuvo un resultado del procedimiento almacenado.");
            }
        } catch (Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }

    // Método para obtener un costo por ID
    public function getCostoById($cat_id) {
        $query = "CALL Costos_data_id(?)";
        $params = [$cat_id];
    
        try {
            $result = $this->conn->ejecutarSP($query, $params);
            if ($result && $result->num_rows > 0) {
                return $result->fetch_assoc();
            } else {
                throw new Exception("No se encontraron datos para el ID: $cat_id");
            }
        } catch (Exception $e) {
            return null; // Manejo de errores simplificado
        }
    }

    // Método para obtener todos los costos
    public function getCostos() {
        try {
            $query = "CALL Costos_data()";
            $result = $this->conn->FN_getConnect()->query($query);

            if ($result) {
                $costos = [];
                while ($row = $result->fetch_assoc()) {
                    $costos[] = $row;
                }
                return $costos;
            } else {
                throw new Exception("Error al ejecutar el procedimiento almacenado: " . $this->conn->FN_getConnect()->error);
            }
        } catch (Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }

    // Métodos relacionados con categorías
    public function getCategorias() {
        $query = "SELECT ctg_id, ctg_nombre FROM categorias WHERE ctg_id IN (4, 5)";
        $result = $this->conn->FN_getConnect()->query($query);
    
        if ($result) {
            $categorias = [];   
            while ($row = $result->fetch_assoc()) {
                $categorias[] = $row;
            }
            return $categorias;
        } else {
            return ['error' => 'Error al obtener categorías: ' . $this->conn->FN_getConnect()->error];
        }
    }
}
?>