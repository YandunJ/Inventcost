<?php
// MODELO/InvInsumos.php
class InventarioInsumos {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }


    public function generarNumeroLote() {
        $prefijo = 'INS_';
        $fecha = date('dmy');

        $stmt = $this->conn->prepare("
            SELECT lote 
            FROM inventario 
            WHERE lote LIKE CONCAT(?, ?, '%')
            ORDER BY CAST(SUBSTRING(lote, LENGTH(?) + LENGTH(?) + 1) AS UNSIGNED) DESC 
            LIMIT 1
        ");
        $stmt->bind_param('ssss', $prefijo, $fecha, $prefijo, $fecha);
        $stmt->execute();
        $stmt->bind_result($ultimoLote);
        $stmt->fetch();
        $stmt->close();

        $nuevoConsecutivo = $ultimoLote 
            ? intval(substr($ultimoLote, strlen($prefijo . $fecha))) + 1 
            : 1;

        return $prefijo . $fecha . $nuevoConsecutivo;
    }
    public function insertarInsumo(
        $proveedor_id, $cat_id, $fecha_elaboracion, $fecha_caducidad, 
        $numero_lote, $cantidad_ingresada, $precio_unitario, $precio_total
    ) {
        $stmt = $this->conn->prepare("CALL ins_reg(?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param(
            'iisssdds', // Ajustamos el orden para reflejar el SP
            $proveedor_id, $cat_id, $fecha_elaboracion, $fecha_caducidad, $numero_lote,
            $cantidad_ingresada, $precio_unitario, $precio_total
        );
    
        if ($stmt->execute()) {
            return true;
        } else {
            throw new Exception("Error al insertar el insumo: " . $stmt->error);
        }
    
        $stmt->close();
    }

    public function obtenerInventarioINS() {
        $sql = "CALL ins_data()";
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

    public function obtenerInsumoPorID($inventins_id) {
        $stmt = $this->conn->prepare("CALL Obt_INS_por_id(?)"); // Cambio en el nombre del SP
        $stmt->bind_param('i', $inventins_id);
        
        if ($stmt->execute()) {
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                return $result->fetch_assoc();
            } else {
                return null;
            }
        } else {
            throw new Exception("Error al obtener el insumo por ID: " . $stmt->error);
        }
        
        $stmt->close();
    }
    

    
   

    
    public function obtenerInsumos() {
        $query = "SELECT cat_id, cat_nombre FROM catalogo WHERE ctg_id = 2";
        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
        }
    
        $stmt->execute();
        $result = $stmt->get_result();
        $insumos = array();
    
        while ($row = $result->fetch_assoc()) {
            $insumos[] = $row;
        }
    
        $stmt->close();
        return $insumos;
    }
    
}

?>
