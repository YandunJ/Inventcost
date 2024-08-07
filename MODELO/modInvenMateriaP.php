<?php
// MODELO/InvenMateriaP.php
class MateriaPrima {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function insertar($mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $estado, $usuario_id, $observaciones) {
        $sql = "CALL invent_materia_prima(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([$mp_id, $fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $precio_total, $birx, $presentacion, $estado, $usuario_id, $observaciones]);
    }

    public function obtenerMateriaPrima() {
        $sql = "CALL pa_obt_materia_prima()";
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

    public function eliminar($mp_id) {
        $sql = "CALL pa_eliminar_materia_prima(?)";
        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([$mp_id]);
    }
}
?>
