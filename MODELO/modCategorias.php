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
}


?>
