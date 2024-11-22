<?php
// MODELO/modInvCatalogo.php

class InvCatalogo {
    private $conn;
    private $table_name = "invent_catalogo";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addOrUpdateArticulo($opcion, $id_articulo, $nombre_articulo, $descripcion, $id_categoria, $proveedor_id, $uni_id, $stock) {
        $query = "CALL acc_invent_catalogo(?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
    
        // Sanitize inputs
        $nombre_articulo = htmlspecialchars(strip_tags($nombre_articulo));
        $descripcion = htmlspecialchars(strip_tags($descripcion));
    
        // Bind values
        $stmt->bind_param('issiiii', $id_articulo, $nombre_articulo, $descripcion, $id_categoria, $proveedor_id, $uni_id, $stock);
    
        try {
            if ($stmt->execute()) {
                return true;
            }
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
        }
        return false;
    }
    

    public function getArticulos() {
        $query = "CALL obt_invCatalogo()";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        $articulos = array();

        while ($row = $result->fetch_assoc()) {
            $articulos[] = $row;
        }

        return array('data' => $articulos);
    }

    public function deleteArticulo($id_articulo) {
        $query = "CALL elim_invCatalogo(?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $id_articulo);

        try {
            if ($stmt->execute()) {
                return true;
            }
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
        }
        return false;
    }

    public function getArticuloById($id_articulo) {
        $query = "CALL obt_invCatalogo_id(?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $id_articulo);
        $stmt->execute();
        $result = $stmt->get_result();

        return $result->fetch_assoc();
    }
}

?>
