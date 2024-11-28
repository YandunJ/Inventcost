<?php
// MODELO/modInvCatalogo.php

require_once "../CONFIG/conexion.php";

class InvCatalogo {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

 
    public function addOrUpdateArticulo($opcion, $id_articulo, $nombre_articulo, $descripcion, $id_categoria, $proveedor_id, $uni_id) {
        // Validar si el artículo ya existe en la base de datos
        $queryExist = "SELECT * FROM invent_catalogo WHERE nombre_articulo = ? AND proveedor_id = ?";
        $paramsExist = [$nombre_articulo, $proveedor_id];
        $resultExist = $this->conn->ejecutarSP($queryExist, $paramsExist);
        
        // Si ya existe, devolver un mensaje indicando que no se puede duplicar
        if ($resultExist && $resultExist->num_rows > 0) {
            return ['error' => 'El artículo ya existe en el catálogo con este proveedor.'];
        }
     
        // Si no existe, ejecutar el procedimiento para agregarlo
        $query = "CALL acc_invent_catalogo(?, ?, ?, ?, ?, ?, ?)";
        $params = [$opcion, $id_articulo, $nombre_articulo, $descripcion, $id_categoria, $proveedor_id, $uni_id];
    
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
    

     
    public function getArticuloById($id_articulo) {
        $query = "CALL obt_invCatalogo_id(?)";
        $params = [$id_articulo];
    
        try {
            $result = $this->conn->ejecutarSP($query, $params);
            if ($result) {
                return $result->fetch_assoc(); // Retorna la primera fila
            } else {
                throw new Exception("El artículo no fue encontrado.");
            }
        } catch (Exception $e) {
            return null; // Opcional, registra el error si necesitas detalles
        }
    }
    
    
    public function getArticulos() {
        try {
            $query = "CALL obt_invCatalogo()";
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
    
    public function deleteArticulo($id_articulo) {
        $conexion = new Cls_DataConnection();
        $conn = $conexion->FN_getConnect(); // Nueva conexión para esta operación
    
        try {
            $query = "CALL elim_invCatalogo(?)";
            $stmt = $conn->prepare($query);
    
            if (!$stmt) {
                throw new Exception("Error al preparar la consulta: " . $conn->error);
            }
    
            $stmt->bind_param("i", $id_articulo);
    
            if ($stmt->execute()) {
                $stmt->close();
                $conn->close(); // Cierra la conexión después de usarla
                return true; // Eliminación exitosa
            } else {
                throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
            }
        } catch (Exception $e) {
            $conn->close(); // Cierra la conexión en caso de error
            return ['error' => $e->getMessage()];
        }
    }
    
   
    
    // Métodos relacionados con categorías y proveedores
    public function getCategorias() {
        $query = "SELECT id_categoria, nombre_categoria FROM categorias";
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
        $query = "SELECT uni_id, uni_nombre FROM unidades_medida";
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
    
    public function obtenerProveedores() {
        $query = "SELECT proveedor_id, nombre_empresa FROM proveedores";
        $result = $this->conn->FN_getConnect()->query($query);
    
        if ($result) {
            $proveedores = [];
            while ($row = $result->fetch_assoc()) {
                $proveedores[] = $row;
            }
            return $proveedores;
        } else {
            return ['error' => 'Error al obtener proveedores: ' . $this->conn->FN_getConnect()->error];
        }
    }
    
}
?>
