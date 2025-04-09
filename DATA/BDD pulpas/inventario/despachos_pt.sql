SELECT * FROM fpulpas.despacho_pt;

SELECT * FROM fpulpas.det_despacho;

DELIMITER //

CREATE PROCEDURE TP_salida(
    IN p_despacho JSON,
    IN p_precio_total DECIMAL(10,2)
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE v_id_despacho INT;
    DECLARE v_id_pt INT;
    DECLARE v_lote VARCHAR(50);
    DECLARE v_cantidad_despachada DECIMAL(10,2);
    DECLARE v_cantidad_total DECIMAL(10,2) DEFAULT 0;
    DECLARE v_cantidad_disponible DECIMAL(10,2);
    DECLARE mensaje_error VARCHAR(255);
    DECLARE prev_safe_updates INT;

    -- Iniciar transacción
    START TRANSACTION;

    -- Guardar estado original de SQL_SAFE_UPDATES
    SET prev_safe_updates = @@SQL_SAFE_UPDATES;
    SET SQL_SAFE_UPDATES = 0;

    -- Depuración: Verificar los datos recibidos
    SELECT CONCAT('Datos recibidos - p_despacho: ', p_despacho) AS debug;
    SELECT CONCAT('Datos recibidos - p_precio_total: ', p_precio_total) AS debug;

    -- Insertar el despacho en la tabla despacho_pt
    INSERT INTO despacho_pt (fecha_despacho, estado, cantidad_total, precio_total)
    VALUES (NOW(), 'activo', 0, p_precio_total);
    SET v_id_despacho = LAST_INSERT_ID();

    -- Procesar los detalles del despacho
    WHILE i < JSON_LENGTH(p_despacho) DO
        -- Extraer valores del JSON (convertir a tipos correctos)
        SET v_id_pt = CAST(JSON_UNQUOTE(JSON_EXTRACT(p_despacho, CONCAT('$[', i, '].id_pt'))) AS UNSIGNED);
        SET v_lote = JSON_UNQUOTE(JSON_EXTRACT(p_despacho, CONCAT('$[', i, '].lote')));
        SET v_cantidad_despachada = CAST(JSON_UNQUOTE(JSON_EXTRACT(p_despacho, CONCAT('$[', i, '].cantidad_despachada'))) AS DECIMAL(10,2));

        -- Depuración: Verificar los valores extraídos
        SELECT CONCAT('Procesando - id_pt: ', v_id_pt, ', lote: ', v_lote, ', cantidad_despachada: ', v_cantidad_despachada) AS debug;

        -- Validar que el id_pt exista en inventario_pt
        IF NOT EXISTS (SELECT 1 FROM inventario_pt WHERE id_pt = v_id_pt) THEN
            SET mensaje_error = CONCAT('Error: El producto con id_pt ', v_id_pt, ' no existe.');
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
        END IF;

        -- Obtener cantidad disponible
        SELECT cant_disponible 
        INTO v_cantidad_disponible
        FROM inventario_pt 
        WHERE id_pt = v_id_pt;

        -- Validar stock
        IF v_cantidad_disponible < v_cantidad_despachada THEN
            SET mensaje_error = CONCAT('Error: Stock insuficiente para id_pt ', v_id_pt, '. Disponible: ', v_cantidad_disponible);
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
        END IF;

        -- Insertar detalle del despacho
        INSERT INTO det_despacho (id_despacho, id_pt, lote, cantidad_despachada)
        VALUES (v_id_despacho, v_id_pt, v_lote, v_cantidad_despachada);

        -- Actualizar inventario
        UPDATE inventario_pt 
        SET cant_disponible = cant_disponible - v_cantidad_despachada
        WHERE id_pt = v_id_pt;

        -- Acumular totales
        SET v_cantidad_total = v_cantidad_total + v_cantidad_despachada;

        SET i = i + 1;
    END WHILE;

    -- Actualizar totales en despacho_pt
    UPDATE despacho_pt 
    SET cantidad_total = v_cantidad_total
    WHERE id_despacho = v_id_despacho;

    -- Confirmar transacción
    COMMIT;

    -- Restaurar estado original de SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = prev_safe_updates;
END //

DELIMITER ;
-- llamado anterior
CALL TP_salida('[
    {
        "id_pt": 30,
        "lote": "PT_0203251",
        "cantidad_despachada": 1
    },
    {
        "id_pt": 36,
        "lote": "PT_0203252",
        "cantidad_despachada": 1
    }
]', 10.00);

-- ultimo llamado
CALL TP_salida('[{
    "id_pt": 11,
    "lote": "PT_0203251",
    "cantidad_despachada": 1,
    "precio_venta": 1.50
}, {
    "id_pt": 12,
    "lote": "PT_0203252",
    "cantidad_despachada": 1,
    "precio_venta": 2.00
}]', 10.00);

-- ultimo ultimo

CALL TP_salida('[{
    "id_pt": 11,
    "lote": "PT_0203251",
    "cantidad_despachada": 1,
    "precio_venta": 1.50
}, {
    "id_pt": 12,
    "lote": "PT_0203252",
    "cantidad_despachada": 1,
    "precio_venta": 2.00
}]', 10.00);



-- Declarar variables para almacenar el estado y el mensaje
SET @p_status = '';
SET @p_message = '';

-- Llamar al SP
CALL TP_cancelar_salida(16, @p_status, @p_message);

-- Mostrar el resultado
SELECT @p_status AS status, @p_message AS message;
-- Verificar si el despacho fue eliminado
SELECT * FROM despacho_pt WHERE id_despacho = 16;

-- Verificar si los detalles del despacho fueron eliminados
SELECT * FROM det_despacho WHERE id_despacho = 16;

-- Verificar que las cantidades se devolvieron al inventario
SELECT * FROM inventario_pt WHERE id_pt IN (11, 12);

CALL TP_cancelar_salida(13);

DELIMITER $$

CREATE PROCEDURE `TP_historial_1`()
BEGIN
    SELECT 
        d.id_despacho,
        d.fecha_despacho,
        d.estado,
        d.cantidad_total,
        d.precio_total
    FROM 
        despacho_pt d
    ORDER BY 
        d.fecha_despacho DESC;
END $$

DELIMITER ;

CALL TP_historial_1();


DELIMITER //

CREATE PROCEDURE TP_historial_2 (IN despacho_id INT)
BEGIN
    SELECT 
        dp.id_despacho,
        dp.n_comprobante,
        dp.fecha_despacho,
        dp.estado AS estado_despacho,
        dp.cantidad_total,
        dp.precio_total,
        ddp.id_detalle,
        ddp.id_pt,
        ddp.lote,
        ddp.cantidad_despachada,
        ddp.precio_venta,
        ipt.presentacion,
        ipt.p_u AS precio_unitario,
        ipt.p_v_s AS precio_venta_sugerido,
        ipt.fecha_caducidad,
        ipt.composicion,
        ipt.estado AS estado_producto
    FROM 
        despacho_pt dp
    INNER JOIN 
        det_despacho ddp ON dp.id_despacho = ddp.id_despacho
    INNER JOIN 
        inventario_pt ipt ON ddp.id_pt = ipt.id_pt
    WHERE 
        dp.id_despacho = despacho_id;
END //

DELIMITER ;

call fpulpas.TP_historial_2(18);
