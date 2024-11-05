        <?php
        // MODELO/modInvFrutas.php
        class MateriaPrima {
            private $conn;

            public function __construct() {
                $conexion = new Cls_DataConnection();
                $this->conn = $conexion->FN_getConnect();
            }

            public function guardarOActualizarInventarioMateriaPrima(
                $id_inv,
                $fecha,
                $hora,
                $id_articulo,
                $proveedor_id,
                $numero_lote,
                $unidad_medida,
                $cantidad_ingresada,
                $cantidad_restante,
                $precio_unitario,
                $presentacion,
                $estado,
                $bultos_o_canastas,
                $peso_unitario,
                $brix,
                $observacion,
                $decision
            ) {
                // Preparación de la llamada al SP con bind_param
                $stmt = $this->conn->prepare("CALL acc_Invent_MP(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                $stmt->bind_param(
                    'issiiisdddsisdsis',
                    $id_inv, $fecha, $hora, $id_articulo, $proveedor_id, $numero_lote,
                    $unidad_medida, $cantidad_ingresada, $cantidad_restante, $precio_unitario,
                    $presentacion, $estado, $bultos_o_canastas, $peso_unitario, $brix, $observacion, $decision
                );
        
                $result = $stmt->execute();
                if (!$result) {
                    throw new Exception("Error en ejecución: " . $stmt->error);
                }
                $stmt->close();
        
                return $result;
            }
        
            

            public function obtenerInventarioMP() {
                // Llamada al procedimiento almacenado que proporciona los datos resumidos para el DataTable
                $sql = "CALL sp_Obt_inven_MP()";
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
            
            public function obtenerMateriaPrimaPorId($mp_id) {
                $stmt = $this->conn->prepare("SELECT * FROM materia_prima WHERE mp_id = ?");
                $stmt->bind_param("i", $mp_id);
                $stmt->execute();
                $result = $stmt->get_result();
                $data = $result->fetch_assoc();
                $stmt->close();
                return $data;
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
            
// ---------FUNCION DE SISTEMA NATERIOR SIN USAR -----
            public function insertar($mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $observaciones) {
                $stmt = $this->conn->prepare("CALL invent_materia_prima(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                $stmt->bind_param('iisidddsss', $mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $observaciones);
                $stmt->execute();
                $stmt->close();
            } 
            

            
        }
        ?>
