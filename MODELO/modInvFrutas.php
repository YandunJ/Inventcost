        <?php
        // MODELO/Inventario.php
        class MateriaPrima {
            private $conn;

            public function __construct() {
                $conexion = new Cls_DataConnection();
                $this->conn = $conexion->FN_getConnect();
            }

            public function insertar($mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $observaciones) {
                $stmt = $this->conn->prepare("CALL invent_materia_prima(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                $stmt->bind_param('iisidddsss', $mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $observaciones);
                $stmt->execute();
                $stmt->close();
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
                $sql = "CALL pa_eliminar_materia_prima(?)";
                $stmt = $this->conn->prepare($sql);
                $stmt->bind_param("i", $mp_id);
                if (!$stmt->execute()) {
                    throw new Exception($stmt->error);
                }
            }

            
        }
        ?>
