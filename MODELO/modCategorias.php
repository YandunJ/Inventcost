<?php
// MODELO/modCategorias.php
class Categorias {
    private $conn;
    
    public function __construct($db) {
        $this->conn = $db;
    }

    public function getCategorias() {
        $query = "SELECT id_categoria, nombre_categoria FROM categorias";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        $categorias = [];
        while ($row = $result->fetch_assoc()) {
            $categorias[] = $row;
        }
        return $categorias;

    }
    public function getUnidadesMedida() {
        $query = "SELECT uni_id, uni_nombre FROM unidades_medida";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();
        $unidades = [];
        while ($row = $result->fetch_assoc()) {
            $unidades[] = $row;
        }
        return $unidades;
    }
    
}


?>


