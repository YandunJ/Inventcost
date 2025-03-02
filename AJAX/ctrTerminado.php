function obtenerLotesPT() {
    global $conn;
    $sql = "SELECT 
                p.lote_PT AS lote,
                p.pro_fecha AS fecha_produccion,
                GROUP_CONCAT(CONCAT(i.presentacion, ' (', i.cant_disponible, ' ', i.estado, ')')) AS presentaciones,
                SUM(i.cant_disponible) AS total_disponible
            FROM produccion p
            JOIN inventario_pt i ON p.pro_id = i.pro_id
            GROUP BY p.lote_PT";
    $result = $conn->query($sql);

    $data = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $pro_id = $row['pro_id'];
            $sql_presentaciones = "SELECT presentacion, cant_disponible, estado
                                   FROM inventario_pt
                                   WHERE pro_id = $pro_id";
            $result_presentaciones = $conn->query($sql_presentaciones);
            $presentaciones = [];
            if ($result_presentaciones->num_rows > 0) {
                while ($row_presentacion = $result_presentaciones->fetch_assoc()) {
                    $presentaciones[] = $row_presentacion;
                }
            }
            $row['presentaciones'] = $presentaciones;
            $data[] = $row;
        }
    }

    echo json_encode($data);
}
