<?php
// MODELO/modProduccionMP.php

class Produccion {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function generarNumeroLotePT() {
        $prefijo = 'PT_';
        $fecha = date('dmy');

        // Obtener el último número de lote para la fecha actual
        $stmt = $this->conn->prepare("
            SELECT lote_PT 
            FROM produccion 
            WHERE lote_PT LIKE CONCAT(?, ?, '%')
            ORDER BY CAST(SUBSTRING(lote_PT, LENGTH(?) + LENGTH(?) + 1) AS UNSIGNED) DESC 
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
    public function registrarProduccion($cant_producida, $lotes_mp, $lotes_ins, $mano_obra, $costos_indirectos, $presentaciones_pt, $lote_pt, $fecha_elaboracion) {
        // Llamar al SP PR_consumo
        $sql = "CALL PR_consumo(?, ?, ?, ?, ?, ?, @pro_id)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("dsssss", $cant_producida, $lotes_mp, $lotes_ins, $mano_obra, $costos_indirectos, $lote_pt);
        
        if ($stmt->execute()) {
            // Obtener el ID de la producción generada
            $result = $this->conn->query("SELECT @pro_id AS pro_id");
            $row = $result->fetch_assoc();
            $pro_id = $row['pro_id'];
        
            // Llamar al SP TP_reg para registrar las presentaciones de PT
            $sql_pt = "CALL TP_reg(?, ?, ?)";
            $stmt_pt = $this->conn->prepare($sql_pt);
            $stmt_pt->bind_param("iss", $pro_id, $fecha_elaboracion, $presentaciones_pt);
            $stmt_pt->execute();
            $stmt_pt->close();
        
            return ['status' => 'success', 'message' => 'Producción registrada correctamente'];
        } else {
            return ['status' => 'error', 'message' => $stmt->error];
        }
    }




    
    public function cancelarProduccion($pro_id) {
        $sql = "CALL PR_cancelar_prod(?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $pro_id);

        if ($stmt->execute()) {
            return ['status' => 'success', 'message' => 'Producción cancelada correctamente'];
        } else {
            return ['status' => 'error', 'message' => $stmt->error];
        }
    }

    
    public function obtenerProducciones() {
        $sql = "CALL PROD_data_G()";
        $result = $this->conn->query($sql);

        $data = [];
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }


    public function obtenerPresentacionesPT() {
        $sql = "SELECT prs_id, prs_nombre, equivalencia FROM presentacion WHERE ctg_id = 3 AND prs_estado = 'vigente'";
        $result = $this->conn->query($sql);

        $data = [];
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    public function obtenerDetallesProduccion($pro_id) {
        // Obtener costos asociados a la producción
        $sqlCostosAsociados = "SELECT 
                                c.cst_id,
                                c.cat_id,
                                c.cst_cant,
                                c.cst_presentacion,
                                c.cst_horas_persona,
                                c.cst_precio_ht,
                                c.cst_total_horas_actividad,
                                c.cst_costo_total
                               FROM prcostos c
                               WHERE c.pro_id = ?";
        $stmtCostosAsociados = $this->conn->prepare($sqlCostosAsociados);
        $stmtCostosAsociados->bind_param("i", $pro_id);
        $stmtCostosAsociados->execute();
        $resultCostosAsociados = $stmtCostosAsociados->get_result();
        $costosAsociados = $resultCostosAsociados->fetch_all(MYSQLI_ASSOC);

        return [
            'costosAsociados' => $costosAsociados
        ];
    }
}
?>