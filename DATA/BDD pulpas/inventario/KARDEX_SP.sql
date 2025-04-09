SELECT * FROM fpulpas.kardex;

CREATE TABLE `PT_kardex` (
    `id_pt_kardex` INT AUTO_INCREMENT PRIMARY KEY,
    `fecha_hora` DATETIME NOT NULL,
    `id_pt` INT NOT NULL,
    `presentacion` VARCHAR(20) NOT NULL,
    `lote` VARCHAR(50) NOT NULL,
    `cantidad` DECIMAL(10, 2) NOT NULL,
    `stock_anterior` DECIMAL(10, 2) NOT NULL,
    `stock_actual` DECIMAL(10, 2) NOT NULL,
    `tipo_movimiento` ENUM('entrada', 'salida', 'ajuste') NOT NULL,
    `comprobante_despacho` VARCHAR(50) DEFAULT NULL,  -- Número de comprobante de despacho (solo para salidas)
    FOREIGN KEY (`id_pt`) REFERENCES `inventario_pt`(`id_pt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER $$

CREATE PROCEDURE `Akardex`(
    IN p_categoria_id INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    -- Obtener las entradas y salidas del mes actual y el saldo inicial por producto
    SELECT 
        c.cat_id,
        c.cat_nombre AS Producto,
        p.prs_nombre AS Presentación,
        COALESCE((
            SELECT stock_actual
            FROM kardex k2
            WHERE k2.cat_id = c.cat_id
            AND k2.fecha_hora < p_fecha_inicio
            ORDER BY k2.fecha_hora DESC
            LIMIT 1
        ), 0) AS Saldo_Inicial,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0) AS Entradas,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0) AS Salidas,
        (
            COALESCE((SELECT stock_actual FROM kardex k2 WHERE k2.cat_id = c.cat_id AND k2.fecha_hora < p_fecha_inicio ORDER BY k2.fecha_hora DESC LIMIT 1), 0)
            + COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0)
            - COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0)
        ) AS Saldo_Final
    FROM 
        catalogo c
    LEFT JOIN 
        kardex k ON c.cat_id = k.cat_id AND k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    LEFT JOIN 
        presentacion p ON c.prs_id = p.prs_id
    WHERE 
        c.ctg_id = p_categoria_id
    GROUP BY 
        c.cat_id, c.cat_nombre, p.prs_nombre
    HAVING 
        Saldo_Inicial > 0 OR Entradas > 0 OR Salidas > 0 OR Saldo_Final > 0;
END $$

DELIMITER ;







----- kardex general funcional ---
DELIMITER $$
CREATE PROCEDURE `Akardex`(
    IN p_categoria_id INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    -- Obtener las entradas y salidas del mes actual y el saldo inicial por producto
    SELECT 
        c.cat_id,
        c.cat_nombre AS Producto,
        p.prs_nombre AS Presentación,
        COALESCE((
            SELECT stock_actual
            FROM kardex k2
            WHERE k2.cat_id = c.cat_id
            AND k2.fecha_hora < p_fecha_inicio
            ORDER BY k2.fecha_hora DESC
            LIMIT 1
        ), 0) AS Saldo_Inicial,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0) AS Entradas,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0) AS Salidas,
        (
            COALESCE((SELECT stock_actual FROM kardex k2 WHERE k2.cat_id = c.cat_id AND k2.fecha_hora < p_fecha_inicio ORDER BY k2.fecha_hora DESC LIMIT 1), 0)
            + COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0)
            - COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0)
        ) AS Saldo_Final
    FROM 
        catalogo c
    LEFT JOIN 
        kardex k ON c.cat_id = k.cat_id AND k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    LEFT JOIN 
        presentacion p ON c.prs_id = p.prs_id
    WHERE 
        c.ctg_id = p_categoria_id
    GROUP BY 
        c.cat_id, c.cat_nombre, p.prs_nombre;
END $$

DELIMITER ;

CALL Akardex(1, '2024-12-01', '2024-12-31');

CALL Akardex(1, '2025-01-01', '2025-01-31');

CALL Akardex(1, '2025-02-01', '2025-02-28');

INSERT INTO inventario (fecha_hora, cat_id, proveedor_id, lote, presentacion, cant_ingresada, cant_restante, p_u, p_t, estado, brix, observacion) VALUES
('2024-12-01 10:00:00', 1, 1, 'MP_0112241', 'KILOGRAMOS', 10.00, 10.00, 2.50, 25.00, 'disponible', 10.00, 'Entrada inicial'),
('2024-12-05 11:30:00', 1, 1, 'MP_0512242', 'KILOGRAMOS', 20.00, 20.00, 2.50, 50.00, 'disponible', 10.00, 'Entrada adicional'),
('2024-12-11 11:45:00', 2, 1, 'MP_1112243', 'KILOGRAMOS', 15.00, 15.00, 1.80, 27.00, 'disponible', 9.50, 'Entrada adicional'),
('2024-12-16 13:00:00', 2, 1, 'MP_1612244', 'KILOGRAMOS', 20.00, 20.00, 1.80, 36.00, 'disponible', 9.50, 'Entrada adicional'),
('2024-12-21 14:15:00', 2, 1, 'MP_2112245', 'KILOGRAMOS', 25.00, 25.00, 1.80, 45.00, 'disponible', 9.50, 'Entrada adicional');

INSERT INTO inventario (fecha_hora, cat_id, proveedor_id, lote, presentacion, cant_ingresada, cant_restante, p_u, p_t, estado, fecha_elaboracion, fecha_caducidad) VALUES
('2024-12-03 08:00:00', 7, 2, 'INS_0312241', 'UNIDAD', 50.00, 50.00, 0.50, 25.00, 'disponible', '2024-11-28', '2025-11-28'),
('2024-12-07 09:30:00', 7, 2, 'INS_0712242', 'UNIDAD', 100.00, 100.00, 0.50, 50.00, 'disponible', '2024-12-02', '2025-12-02'),
('2024-12-13 09:45:00', 8, 4, 'INS_1312243', 'KILOGRAMOS', 30.00, 30.00, 1.20, 36.00, 'disponible', '2024-12-08', '2025-12-08'),
('2024-12-18 11:00:00', 8, 4, 'INS_1812244', 'KILOGRAMOS', 40.00, 40.00, 1.20, 48.00, 'disponible', '2024-12-13', '2025-12-13'),
('2024-12-23 12:15:00', 8, 4, 'INS_2312245', 'KILOGRAMOS', 50.00, 50.00, 1.20, 60.00, 'disponible', '2024-12-18', '2025-12-18');


DELIMITER $$

CREATE PROCEDURE `DetalleKardex`(
    IN p_cat_id INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        k.id_kardex,
        k.fecha_hora,
        k.cat_id,
        k.lote,
        k.cantidad,
        i.p_u AS precio_unitario,
        i.p_t AS precio_total,
        i.proveedor_id AS proveedor,
        CASE 
            WHEN c.ctg_id = 1 THEN i.brix
            ELSE NULL
        END AS brix,
        CASE 
            WHEN c.ctg_id = 1 THEN i.observacion
            ELSE NULL
        END AS observacion,
        CASE 
            WHEN c.ctg_id = 2 THEN i.fecha_elaboracion
            ELSE NULL
        END AS fecha_elaboracion,
        CASE 
            WHEN c.ctg_id = 2 THEN i.fecha_caducidad
            ELSE NULL
        END AS fecha_caducidad,
        k.tipo_movimiento
    FROM 
        kardex k
    JOIN 
        inventario i ON k.lote = i.lote
    JOIN 
        catalogo c ON k.cat_id = c.cat_id
    WHERE 
        k.cat_id = p_cat_id
        AND k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY 
        k.fecha_hora;
END $$

DELIMITER ;

CALL DetalleKardex(1, '2024-12-01', '2024-12-31');

CALL DetalleKardex(2, '2024-12-01', '2024-12-31');

CALL DetalleKardex(7, '2024-12-01', '2024-12-31');

CALL DetalleKardex(8, '2024-12-01', '2024-12-31');