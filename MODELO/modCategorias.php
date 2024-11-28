<?php
// MODELO/modCategorias.php
class Categorias {
    private $conn;

    public function __construct() {
        $this->conn = new Cls_DataConnection();
    }

    public function getCategorias() {
        $query = "SELECT id_categoria, nombre_categoria FROM categorias";
        return $this->conn->ejecutarConsulta($query);
    }

    public function getUnidadesMedida() {
        $query = "SELECT uni_id, uni_nombre FROM unidades_medida";
        return $this->conn->ejecutarConsulta($query);
    }

 public function obtenerProveedores() {
        $query = "SELECT proveedor_id, nombre_empresa FROM proveedores";
             return $this->conn->ejecutarConsulta($query);
            }
        }

?>


