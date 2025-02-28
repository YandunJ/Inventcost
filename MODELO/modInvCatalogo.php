<?php
// MODELO/modInvCatalogo.php

require_once "../CONFIG/conexion.php";

class InvCatalogo {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

// Método para agregar o actualizar un artículo
public function addOrUpdateArticulo($opcion, $cat_id, $cat_nombre, $ctg_id, $prs_id) {
    // Validar si el artículo ya existe en la base de datos
    $queryExist = "SELECT COUNT(*) AS total FROM catalogo WHERE cat_nombre = ? AND prs_id = ?";
    $paramsExist = [$cat_nombre, $prs_id];
    $resultExist = $this->conn->ejecutarSP($queryExist, $paramsExist);

    if ($resultExist && $resultExist->fetch_assoc()['total'] > 0 && $opcion == 1) {
        return ['error' => 'El artículo ya existe en el catálogo con esta presentación.'];
    }

    // Validar si el artículo ya existe con otra presentación al actualizar
    if ($opcion == 2) {
        $queryExistUpdate = "SELECT COUNT(*) AS total FROM catalogo WHERE cat_nombre = ? AND prs_id = ? AND cat_id != ?";
        $paramsExistUpdate = [$cat_nombre, $prs_id, $cat_id];
        $resultExistUpdate = $this->conn->ejecutarSP($queryExistUpdate, $paramsExistUpdate);

        if ($resultExistUpdate && $resultExistUpdate->fetch_assoc()['total'] > 0) {
            return ['error' => 'No se puede actualizar el artículo. Ya existe un artículo con este nombre y presentación.'];
        }
    }

    // Ejecutar el procedimiento almacenado para agregar o actualizar
    $query = "CALL Catalogo_CRUD(?, ?, ?, ?, ?)";
    $params = [$opcion, $cat_id, $cat_nombre, $ctg_id, $prs_id];

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

// Método para obtener un artículo por ID
public function getArticuloById($cat_id) {
    $query = "CALL Catalogo_data_id(?)";
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

    
    // Método para obtener todos los artículos
    public function getArticulos() {
        try {
            $query = "CALL Catalogo_data()";
            $result = $this->conn->FN_getConnect()->query($query);

            if ($result) {
                $articulos = [];
                while ($row = $result->fetch_assoc()) {
                    $articulos[] = $row;
                }
                return $articulos;
            } else {
                throw new Exception("Error al ejecutar el procedimiento almacenado: " . $this->conn->FN_getConnect()->error);
            }
        } catch (Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
        // Métodos relacionados con categorías y unidades de medida
        public function getCategorias() {
            $query = "SELECT ctg_id, ctg_nombre FROM categorias";
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
        
        public function getUnidadesMedida() {
            $query = "SELECT prs_id, prs_nombre FROM presentacion";
            $result = $this->conn->FN_getConnect()->query($query);
        
            if ($result) {
                $unidades = [];
                while ($row = $result->fetch_assoc()) {
                    $unidades[] = $row;
                }
                return $unidades;
            } else {
                return ['error' => 'Error al obtener unidades: ' . $this->conn->FN_getConnect()->error];
            }
        }
        

    
}
?>
