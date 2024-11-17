<?php
// MODELO/InvInsumos.php
class InventarioInsumos {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }


    public function insertarInsumo($id_articulo, $proveedor_id, $fecha, $hora, $numero_lote, $cantidad_ingresada, $presentacion, $precio_unitario) {
        // Ajustar la llamada al procedimiento almacenado ac_InsertarINS con los parámetros correctos
        $stmt = $this->conn->prepare("CALL ac_InsertarINS(?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('iisssdds', $id_articulo, $proveedor_id, $fecha, $hora, $numero_lote, $cantidad_ingresada, $presentacion, $precio_unitario);

        if ($stmt->execute()) {
            return true;
        } else {
            throw new Exception("Error al insertar el insumo: " . $stmt->error);
        }
        
        $stmt->close();
    }
    public function insertarActualizar($inventins_id, $insumo_id, $proveedor_id, $fecha_cad, $unidad_medida, $cantidad, $precio_unitario, $precio_total) {
        $stmt = $this->conn->prepare("CALL inventario_insumos(?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('iiissddd', $inventins_id, $insumo_id, $proveedor_id, $fecha_cad, $unidad_medida, $cantidad, $precio_unitario, $precio_total);
        $stmt->execute();
        $stmt->close();
    }

    public function obtenerInvenInsumos() {
        $sql = "CALL sp_Obt_inven_INS()";
        $result = $this->conn->query($sql);

        if (!$result) {
            throw new Exception("Error en la ejecución de la consulta: " . $this->conn->error);
        }

        $data = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        return $data;
    }
    public function obtenerInvenInsumoPorId($inventins_id) {  // Cambiado el nombre de la función
        $stmt = $this->conn->prepare("SELECT * FROM inventario_insumos WHERE inventins_id = ?");
        $stmt->bind_param("i", $inventins_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_assoc();
        $stmt->close();
        return $data;
    }

    public function eliminar($inventins_id) {
        $sql = "CALL sp_EliminarRegistroMP(?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $inventins_id);
        if (!$stmt->execute()) {
            throw new Exception($stmt->error);
        }
        $stmt->close();
    }


    
}

?>
