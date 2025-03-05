SELECT * FROM fpulpas.despacho_pt;

SELECT * FROM fpulpas.det_despacho;


CREATE TABLE `det_despacho` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_despacho` int NOT NULL,
  `id_pt` int NOT NULL,
  `lote` varchar(50) NOT NULL,
  `cantidad_despachada` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_despacho` (`id_despacho`),
  KEY `id_pt` (`id_pt`),
  CONSTRAINT `det_despacho_ibfk_1` FOREIGN KEY (`id_despacho`) REFERENCES `despacho_pt` (`id_despacho`),
  CONSTRAINT `det_despacho_ibfk_2` FOREIGN KEY (`id_pt`) REFERENCES `inventario_pt` (`id_pt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


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

SET GLOBAL max_allowed_packet = 67108864; -- 64MB
SET GLOBAL wait_timeout = 600;
SET GLOBAL interactive_timeout = 600;

SHOW VARIABLES LIKE 'max_allowed_packet';
SHOW VARIABLES LIKE 'wait_timeout';
SHOW VARIABLES LIKE 'interactive_timeout';