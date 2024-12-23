        <?php
        // MODELO/modInvFrutas.php
        class MateriaPrima {
            private $conn;

            public function __construct() {
                $conexion = new Cls_DataConnection();
                $this->conn = $conexion->FN_getConnect();
            }

             // Generar número de lote con prefijo MP_
    public function generarNumeroLote() {
        $prefijo = 'MP_';
        $fecha = date('dmy');

        // Obtener el último número de lote para la fecha actual
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

  
    public function guardarInventarioMateriaPrima(
        $cat_id, $proveedor_id, $lote, $cantidad_ingresada,
        $precio_unitario, $precio_total, $brix, $observacion
    ) {
        // Preparación y ejecución del SP `mp_reg`
        $stmt = $this->conn->prepare("CALL mp_reg(?, ?, ?, ?, ?, ?, ?, ?)");
        if (!$stmt) {
            throw new Exception("Error en la preparación del SP: " . $this->conn->error);
        }

        $stmt->bind_param(
            'iissddds',
            $cat_id, $proveedor_id, $lote, $cantidad_ingresada,
            $precio_unitario, $precio_total, $brix, $observacion
        );

        $result = $stmt->execute();
        if (!$result) {
            throw new Exception("Error en la ejecución del SP: " . $stmt->error);
        }

        $stmt->close();
        return $result;
    }
            
    
            
            public function obtenerMateriaPrimaPorId($id_inv) {
                $stmt = $this->conn->prepare("CALL Obt_MP_por_id(?)");
                
                if (!$stmt) {
                    throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
                }
        
                $stmt->bind_param("i", $id_inv);
                $stmt->execute();
                $result = $stmt->get_result();
        
                if (!$result) {
                    throw new Exception("Error en la ejecución de la consulta: " . $stmt->error);
                }
        
                $data = $result->fetch_assoc();
                $stmt->close();
                return $data;
            }
        
            // Método para actualizar un registro (usando el procedimiento ActualizarMP actualizado)
            public function actualizarMateriaPrima(
                $id_inv, $fecha, $hora, $id_articulo, $proveedor_id, $numero_lote, $cantidad_ingresada, 
                $precio_unitario, $presentacion, $brix, $bultos_o_canastas, $peso_unitario, $observacion
            ) {
                // Verificación de unicidad del lote, excluyendo el registro actual
                if (!$this->verificarLoteUnicoParaActualizacion($numero_lote, $id_inv)) {
                    throw new Exception("El número de lote ya existe en otro registro.");
                }
            
                // Preparación y ejecución de la actualización si el lote es único
                $stmt = $this->conn->prepare("CALL ActualizarMP(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                if (!$stmt) {
                    throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
                }
            
                $stmt->bind_param(
                    'issisdsdsidds', 
                    $id_inv, $fecha, $hora, $id_articulo, $proveedor_id, $numero_lote,
                    $cantidad_ingresada, $precio_unitario, $presentacion, $brix,
                    $bultos_o_canastas, $peso_unitario, $observacion
                );
            
                $result = $stmt->execute();
                if (!$result) {
                    throw new Exception("Error en la ejecución de la consulta: " . $stmt->error);
                }
            
                $stmt->close();
                return $result;
            }
            
            public function obtenerInventarioMP() {
                // Llamada al procedimiento almacenado que proporciona los datos para el DataTable
                $sql = "CALL mp_data()";
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

            public function verificarLoteUnico($numero_lote) {
                $stmt = $this->conn->prepare("SELECT COUNT(*) FROM inventario WHERE lote = ?");
                if (!$stmt) {
                    throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
                }
            
                $stmt->bind_param("s", $numero_lote);
                $stmt->execute();
                $stmt->bind_result($count);
                $stmt->fetch();
                $stmt->close();
            
                return $count == 0;
            }
            private function verificarLoteUnicoParaActualizacion($numero_lote, $id_inv) {
                $stmt = $this->conn->prepare("SELECT COUNT(*) FROM inventario WHERE lote = ? AND id_inv != ?");
                if (!$stmt) {
                    throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
                }
            
                $stmt->bind_param("si", $numero_lote, $id_inv);
                $stmt->execute();
                $stmt->bind_result($count);
                $stmt->fetch();
                $stmt->close();
            
                // Retorna true si no se encuentra ningún otro registro con el mismo número de lote
                return $count == 0;
            }
            
       
            
            public function eliminar($mp_id) {
                $sql = "CALL sp_EliminarRegistroMP(?)";
                $stmt = $this->conn->prepare($sql);
                $stmt->bind_param("i", $mp_id);
                if (!$stmt->execute()) {
                    throw new Exception($stmt->error);
                }
            }

            public function obtenerDetalleLote($lote_id) {
                $sql = "CALL sp_DetalleLote(?)";
                $stmt = $this->conn->prepare($sql);
                $stmt->bind_param("i", $lote_id);
                $stmt->execute();
                $result = $stmt->get_result();
                
                if (!$result) {
                    throw new Exception("Error en la ejecución de la consulta: " . $this->conn->error);
                }
                
                $data = $result->fetch_assoc();
                $stmt->close();
                
                return $data;
            }
                // Función para obtener frutas
                    public function obtenerFrutas() {
                        $query = "SELECT cat_id, cat_nombre FROM catalogo WHERE ctg_id = 1";
                        $stmt = $this->conn->prepare($query);
                        if (!$stmt) {
                            throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
                        }

                        $stmt->execute();
                        $result = $stmt->get_result();
                        $frutas = array();

                        while ($row = $result->fetch_assoc()) {
                            $frutas[] = $row;
                        }

                        $stmt->close();
                        return $frutas;
                    }
            
                public function obtenerProveedores() {
                    $query = "SELECT proveedor_id, nombre_empresa FROM proveedores";
                    $stmt = $this->conn->prepare($query);
                    if (!$stmt) {
                        throw new Exception("Error en la preparación de la consulta: " . $this->conn->error);
                    }
            
                    $stmt->execute();
                    $result = $stmt->get_result();
                    $proveedores = array();
            
                    while ($row = $result->fetch_assoc()) {
                        $proveedores[] = $row;
                    }
            
                    $stmt->close();
                    return $proveedores;
                }
            }
        ?>
