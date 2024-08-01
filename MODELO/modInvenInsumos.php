<?php

//MODELO/InvenInsumos.php

require_once "../CONFIG/conexion.php"; // Asegúrate de que la ruta sea correcta

class Insumo {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function registrarInventarioInsumos($insumo_id, $proveedor_id, $cantidad, $precio_unitario) {
        try {
            $stmt = $this->db->prepare("CALL sp_reg_invn_insumos(?, ?, ?, ?)");
            $stmt->bind_param("iiii", $insumo_id, $proveedor_id, $cantidad, $precio_unitario);
            $stmt->execute();

            if ($stmt->affected_rows > 0) {
                return ["status" => "success", "message" => "Registro exitoso"];
            } else {
                return ["status" => "error", "message" => "No se pudo registrar"];
            }
        } catch (Exception $e) {
            return ["status" => "error", "message" => $e->getMessage()];
        }
    }
}
?>