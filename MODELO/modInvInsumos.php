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
            SELECT numero_lote 
            FROM inventario 
            WHERE numero_lote LIKE CONCAT(?, ?, '%')
            ORDER BY CAST(SUBSTRING(numero_lote, LENGTH(?) + LENGTH(?) + 1) AS UNSIGNED) DESC 
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
    


    public function insertarInsumo($id_articulo, $proveedor_id, $fecha, $hora, $numero_lote, $cantidad_ingresada, $presentacion, $precio_unitario) {
        // Ajustar la llamada al procedimiento almacenado ac_InsertarINS con los parámetros correctos
        $stmt = $this->conn->prepare("CALL ac_InsertarINS(?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('iisssssd', $id_articulo, $proveedor_id, $fecha, $hora, $numero_lote, $cantidad_ingresada, $presentacion, $precio_unitario);


        if ($stmt->execute()) {
            return true;
        } else {
            throw new Exception("Error al insertar el insumo: " . $stmt->error);
        }
        
        $stmt->close();
    }

    // FUNCION ANTERIOR PARA INSERTAR O ACTULIZAR NO SE USA ACTULAMENTE: 
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
    
    
    public function eliminar($inventins_id) {
        $sql = "CALL sp_EliminarRegistroMP(?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $inventins_id);
        if (!$stmt->execute()) {
            throw new Exception($stmt->error);
        }
        $stmt->close();
    }

    
    public function obtenerProveedoresPorCategoria($id_categoria) {
        $query = "
            SELECT DISTINCT p.proveedor_id, p.nombre_empresa 
            FROM proveedores p
            JOIN invent_catalogo ic ON p.proveedor_id = ic.proveedor_id
            WHERE ic.id_categoria = ? AND ic.estado = 'disponible'
        ";
        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
        }

        $stmt->bind_param("i", $id_categoria);
        $stmt->execute();
        $result = $stmt->get_result();
        $proveedores = [];

        while ($row = $result->fetch_assoc()) {
            $proveedores[] = $row;
        }

        $stmt->close();
        return $proveedores;
    }

    public function obtenerInsumosPorProveedor($proveedor_id) {
        $query = "SELECT id_articulo, nombre_articulo 
                  FROM invent_catalogo 
                  WHERE proveedor_id = ? AND estado = 'disponible'";
        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
        }
    
        $stmt->bind_param("i", $proveedor_id);
        $stmt->execute();
        $result = $stmt->get_result();
    
        if (!$result) {
            throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
        }
    
        $insumos = [];
        while ($row = $result->fetch_assoc()) {
            $insumos[] = $row;
        }
    
        $stmt->close();
    
        // Registro para depuración, como en materia prima
        if (empty($insumos)) {
            error_log("No se encontraron insumos para proveedor_id: $proveedor_id");
        }
    
        return $insumos;
    }
    

    
}

?>
