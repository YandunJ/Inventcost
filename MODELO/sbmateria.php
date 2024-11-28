<?php
// MODELO/sbmateria.php
// class MateriaPrimaModel {
//     private $conn;

//     public function __construct($conn) {
//         $this->conn = $conn;
//     }

//     public function obtenerFrutas() {
//         $query = "SELECT id_articulo, nombre_articulo FROM invent_catalogo where id_categoria = 1";
//         $stmt = $this->conn->prepare($query);
//         $stmt->execute();
//         $result = $stmt->get_result();

//         $frutas = array();
//         while ($row = $result->fetch_assoc()) {
//             $frutas[] = $row;
//         }

//         return $frutas;
//     }

//     public function obtenerProveedores() {
//         $query = "SELECT proveedor_id, nombre_empresa FROM proveedores";
//         $stmt = $this->conn->prepare($query);
//         $stmt->execute();
//         $result = $stmt->get_result();

//         $proveedores = array();
//         while ($row = $result->fetch_assoc()) {
//             $proveedores[] = $row;
//         }

//         return $proveedores;
//     }
// }

// ARHIVO USADO ANTES PARA CARGAR SELEC BOX POR SEPARADO AHORA OBSOLOTE O PARA OTRA FUCNIONALDIAD
?>
