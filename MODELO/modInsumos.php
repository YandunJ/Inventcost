<?php

//MODELO/modInsumos.php

require_once "../CONFIG/conexion.php"; // Asegúrate de que la ruta sea correcta

class Insumo {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function registrarInsumo($nombre, $descripcion, $unidad_medida) {
        $sql = "CALL sp_reg_insumo(?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('sss', $nombre, $descripcion, $unidad_medida);

        try {
            return $stmt->execute();
        } catch (Exception $e) {
            error_log('Error en la ejecución del SQL: ' . $e->getMessage());
            return false;
        }
    }
}
?>
