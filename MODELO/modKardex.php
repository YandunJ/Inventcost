<?php
class KardexModel {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    public function obtenerKardex($fechaInicio, $fechaFin, $categoria) {
        $stmt = $this->conn->prepare("CALL Kardex_data(?, ?, ?)");
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }

        $stmt->bind_param("sss", $fechaInicio, $fechaFin, $categoria);
        $stmt->execute();
        $result = $stmt->get_result();
        $datos = [];

        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }

        $stmt->close();
        return $datos;
    }
    public function obtenerEntradas($articuloId, $fechaInicio, $fechaFin) {
        // Preparar consulta para obtener las entradas
        $stmt = $this->conn->prepare("
        SELECT 
            fecha_hora AS FechaHora, 
            lote AS Lote, 
            proveedor_id AS Proveedor, 
            cat_id AS Articulo, 
            presentacion AS Presentacion, 
            cant_ingresada AS CantidadInicial, 
            cant_restante AS CantidadDisponible, 
            p_u AS PrecioUnitario, 
            (cant_restante * p_u) AS PrecioTotal,
            estado AS Estado, 
            brix AS Brix, 
            observacion AS Observacion 
        FROM inventario 
        WHERE cat_id = ? 
        AND fecha_hora BETWEEN ? AND ?
    ");
    
    
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $this->conn->error);
        }
    
        // Vincular parámetros y ejecutar consulta
        $stmt->bind_param("iss", $articuloId, $fechaInicio, $fechaFin);
        $stmt->execute();
        $result = $stmt->get_result();
        $datos = [];
    
        while ($row = $result->fetch_assoc()) {
            $datos[] = $row;
        }
    
        $stmt->close();
        return $datos;
    }
    
    
}
?>