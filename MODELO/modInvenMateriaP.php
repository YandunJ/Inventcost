<?php

// MODELO/InvenMateriaP.php

class MateriaPrima {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function insertar($fruta_id, $fecha_cad, $proveedor_id, $cantidad, $precio_unit, $birx, $estado, $usuario_id, $observaciones) {
        $sql = "CALL sp_reg_materia_prima('$fruta_id', '$fecha_cad', '$proveedor_id', '$cantidad', '$precio_unit', '$birx', '$estado', '$usuario_id', '$observaciones')";
        return $this->ejecutarConsultaSP($sql);
    }

    public function cargarFrutas() {
        $sql = "CALL pa_obtener_frutas()";
        return $this->ejecutarConsultaSP($sql);
    }

    public function eliminar($mp_id) {
        $sql = "DELETE FROM materia_prima WHERE mp_id='$mp_id'";
        return $this->ejecutarConsultaSP($sql);
    }

    public function cargarProveedores() {
        $sql = "CALL pa_obtener_proveedores()";
        return $this->ejecutarConsultaSP($sql);
    }

    private function ejecutarConsultaSP($sql) {
        $result = $this->conn->query($sql);
        if (!$result) {
            throw new Exception("Error en la ejecución de la consulta: " . $this->conn->error);
        }
        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        return $data;
    }
}
?>
