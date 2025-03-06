SELECT * FROM fpulpas.inventario_pt;
-- ultimo
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_reg`(
    IN p_pro_id INT, -- ID de la producción
    IN p_fecha_elaboracion DATE, -- Fecha de elaboración (misma que la producción)
    IN p_presentaciones JSON -- JSON con las presentaciones, cantidades y costos
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE v_presentacion VARCHAR(20);
    DECLARE v_cant_disponible DECIMAL(10,2);
    DECLARE v_p_u DECIMAL(10,2);
    DECLARE v_p_t DECIMAL(10,2);
    DECLARE v_precio_venta_sugerido DECIMAL(10,2);
    DECLARE v_fecha_caducidad DATE;
    DECLARE v_composicion TEXT;
    DECLARE v_estado ENUM('disponible', 'stock bajo', 'agotado') DEFAULT 'disponible';
    DECLARE v_observacion TEXT DEFAULT NULL;

    -- Recorrer el JSON de presentaciones
    WHILE i < JSON_LENGTH(p_presentaciones) DO
        -- Obtener los valores de cada presentación
        SET v_presentacion = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].presentacion')));
        SET v_cant_disponible = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].cant_disponible')));
        SET v_p_u = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].p_u')));
        SET v_p_t = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].p_t')));
        SET v_composicion = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].composicion')));

        -- Calcular el precio de venta sugerido (costo unitario + 20%)
        SET v_precio_venta_sugerido = v_p_u * 1.20;

        -- Calcular la fecha de caducidad (fecha de elaboración + 30 días)
        SET v_fecha_caducidad = DATE_ADD(p_fecha_elaboracion, INTERVAL 30 DAY);

        -- Insertar el registro en la tabla inventario_pt
        INSERT INTO inventario_pt (
            pro_id, presentacion, cant_disponible, p_u, p_t,
            p_v_s, fecha_caducidad, composicion, estado, observacion
        ) VALUES (
            p_pro_id, v_presentacion, v_cant_disponible, v_p_u, v_p_t,
            v_precio_venta_sugerido, v_fecha_caducidad, v_composicion, v_estado, v_observacion
        );

        -- Incrementar el contador
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_reg`(
    IN p_pro_id INT, -- ID de la producción
    IN p_fecha_elaboracion DATE, -- Fecha de elaboración
    IN p_presentaciones JSON -- JSON con las presentaciones, cantidades y costos
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE v_presentacion VARCHAR(20);
    DECLARE v_cant_disponible DECIMAL(10,2);
    DECLARE v_p_u DECIMAL(10,2);
    DECLARE v_p_t DECIMAL(10,2);
    DECLARE v_precio_venta_sugerido DECIMAL(10,2);
    DECLARE v_fecha_caducidad DATE;

    -- Recorrer el JSON de presentaciones
    WHILE i < JSON_LENGTH(p_presentaciones) DO
        -- Obtener los valores de cada presentación
        SET v_presentacion = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].presentacion')));
        SET v_cant_disponible = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].cant_disponible')));
        SET v_p_u = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].p_u')));
        SET v_p_t = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].p_t')));

        -- Calcular el precio de venta sugerido (costo unitario + 20%)
        SET v_precio_venta_sugerido = v_p_u * 1.20;

        -- Calcular la fecha de caducidad (fecha de elaboración + 30 días)
        SET v_fecha_caducidad = DATE_ADD(p_fecha_elaboracion, INTERVAL 30 DAY);

        -- Insertar el registro en la tabla inventario_pt
        INSERT INTO inventario_pt (
            pro_id, presentacion, cant_disponible, p_u, p_t,
            p_v_s, fecha_caducidad
        ) VALUES (
            p_pro_id, v_presentacion, v_cant_disponible, v_p_u, v_p_t,
            v_precio_venta_sugerido, v_fecha_caducidad
        );

        -- Incrementar el contador
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
-- ultimo fucnionando 
DELIMITER $$

CREATE PROCEDURE PR_consumo(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON,
    IN mano_obra JSON,
    IN costos_indirectos JSON,
    OUT pro_id INT
)
BEGIN
    DECLARE pro_id INT;
    DECLARE subtotal_mtpm DECIMAL(10, 2) DEFAULT 0;
    DECLARE subtotal_ins DECIMAL(10, 2) DEFAULT 0;
    DECLARE subtotal_mo DECIMAL(10, 2) DEFAULT 0; -- Subtotal de mano de obra
    DECLARE subtotal_ci DECIMAL(10, 2) DEFAULT 0; -- Subtotal de costos indirectos
    DECLARE i INT DEFAULT 0;
    DECLARE lote_id INT;
    DECLARE cantidad DECIMAL(10, 2);
    DECLARE precio DECIMAL(10, 2);
    DECLARE stock_actual DECIMAL(10, 2);
    DECLARE mensaje_error VARCHAR(255);
    DECLARE prev_safe_updates INT;
    DECLARE cat_id INT;
    DECLARE horas_persona DECIMAL(10, 2);
    DECLARE precio_ht DECIMAL(10, 2);
    DECLARE costo_total DECIMAL(10, 2);
    DECLARE total_horas DECIMAL(10, 2);
    DECLARE presentacion VARCHAR(20);

    -- Guardar estado original de SQL_SAFE_UPDATES
    SET prev_safe_updates = @@SQL_SAFE_UPDATES;
    SET SQL_SAFE_UPDATES = 0;

    -- Insertar en producción
    INSERT INTO produccion (pro_cant_producida)
    VALUES (cant_producida);
    SET pro_id = LAST_INSERT_ID();

    -- Procesar lotes de materia prima
    IF JSON_LENGTH(lotes_mp) > 0 THEN
        WHILE i < JSON_LENGTH(lotes_mp) DO
            SET lote_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].id_inv')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].cantidad')));

            SELECT cant_restante INTO stock_actual
            FROM inventario
            WHERE id_inv = lote_id;

            IF stock_actual < cantidad THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente stock en el lote ', lote_id, '. Stock disponible: ', stock_actual);
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = mensaje_error;
            END IF;

            SELECT p_u INTO precio FROM inventario WHERE id_inv = lote_id;

            INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
            VALUES (pro_id, lote_id, cantidad);

            UPDATE inventario
            SET cant_restante = cant_restante - cantidad
            WHERE id_inv = lote_id;

            SET subtotal_mtpm = subtotal_mtpm + (cantidad * precio);
            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar lotes de insumos
    SET i = 0;
    IF JSON_LENGTH(lotes_ins) > 0 THEN
        WHILE i < JSON_LENGTH(lotes_ins) DO
            SET lote_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].id_inv')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].cantidad')));

            SELECT cant_restante INTO stock_actual
            FROM inventario
            WHERE id_inv = lote_id;

            IF stock_actual < cantidad THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente stock en el lote ', lote_id, '. Stock disponible: ', stock_actual);
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = mensaje_error;
            END IF;

            SELECT p_u INTO precio FROM inventario WHERE id_inv = lote_id;

            INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
            VALUES (pro_id, lote_id, cantidad);

            UPDATE inventario
            SET cant_restante = cant_restante - cantidad
            WHERE id_inv = lote_id;

            SET subtotal_ins = subtotal_ins + (cantidad * precio);
            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar mano de obra
    IF JSON_LENGTH(mano_obra) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(mano_obra) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].cat_id')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_cant_personas')));
            SET horas_persona = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_horas_trabajadas')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_precio_hora')));
            SET total_horas = cantidad * horas_persona;
            SET costo_total = total_horas * precio_ht;

            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_horas_persona, cst_precio_ht, cst_total_horas_actividad, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cantidad, 'UNIDADES', horas_persona, precio_ht, total_horas, costo_total
            );

            SET subtotal_mo = subtotal_mo + costo_total;
            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar costos indirectos
    IF JSON_LENGTH(costos_indirectos) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(costos_indirectos) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cat_id')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_cant')));
            SET presentacion = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_presentacion')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_precio_ht')));
            SET costo_total = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_costo_total')));

            IF costo_total IS NULL THEN
                SET costo_total = cantidad * precio_ht;
            END IF;

            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_precio_ht, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cantidad, presentacion, precio_ht, costo_total
            );

            SET subtotal_ci = subtotal_ci + costo_total;
            SET i = i + 1;
        END WHILE;
    END IF;

    -- Actualizar subtotales en producción
    UPDATE produccion
    SET pro_subtotal_mtpm = subtotal_mtpm,
        pro_subtotal_ins = subtotal_ins,
        pro_subtotal_mo = subtotal_mo,
        pro_subtotal_ci = subtotal_ci,
        pro_total = subtotal_mtpm + subtotal_ins + subtotal_mo + subtotal_ci
    WHERE pro_id = pro_id;

    -- Restaurar estado original de SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = prev_safe_updates;
     SET pro_id = LAST_INSERT_ID();
END$$

DELIMITER ;


-- Declarar una variable para almacenar el ID de la producción
SET @pro_id = 0;

-- Llamar al SP PR_consumo
CALL PR_consumo(
    50.00, -- Cantidad producida
    '[{"id_inv": 3, "cantidad": 1.00}]', -- Lotes de materia prima
    '[{"id_inv": 4, "cantidad": 1.00}]', -- Lotes de insumos
    '[{"cat_id": 1, "mo_cant_personas": 2, "mo_horas_trabajadas": 8, "mo_precio_hora": 50}]', -- Mano de obra
    '[{"cat_id": 2, "cst_cant": 5, "cst_presentacion": "LITROS", "cst_precio_ht": 30}]', -- Costos indirectos
    'PT_2802253', -- Lote de Producto Terminado
    @pro_id -- Parámetro de salida para el ID de la producción
);
-- Verificar el ID de la producción generada
SELECT @pro_id;

-- Llamar al SP TP_reg con múltiples presentaciones
CALL TP_reg(
    @pro_id, -- ID de la producción generada
    '[{"presentacion": "100 gr", "cant_disponible": 10.00, "p_u": 5.00, "p_t": 50.00}, 
    {"presentacion": "200 gr", "cant_disponible": 20.00, "p_u": 10.00, "p_t": 200.00}]'
);

-- Verificar los registros en la tabla inventario_pt
SELECT * FROM inventario_pt WHERE pro_id = @pro_id;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_cancelar_prod`(
    IN p_pro_id INT -- ID de la producción a cancelar
)
BEGIN
    DECLARE v_lote_id INT;
    DECLARE v_cantidad DECIMAL(10,2);
    DECLARE done INT DEFAULT FALSE;

    -- Cursor para recorrer los consumos de la producción
    DECLARE cur CURSOR FOR
        SELECT id_inv, pdet_cantidad_usada
        FROM prod_detalle
        WHERE pro_id = p_pro_id;

    -- Manejador para cuando no haya más registros en el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Iniciar la reversión de los consumos
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_lote_id, v_cantidad;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Revertir el consumo: aumentar la cantidad disponible en el lote
        UPDATE inventario
        SET cant_restante = cant_restante + v_cantidad
        WHERE id_inv = v_lote_id;
    END LOOP;
    CLOSE cur;

    -- Eliminar los lotes de PT asociados a la producción
    DELETE FROM inventario_pt WHERE pro_id = p_pro_id;

    -- Eliminar los costos asociados a la producción
    DELETE FROM prcostos WHERE pro_id = p_pro_id;

    -- Eliminar los consumos de la producción
    DELETE FROM prod_detalle WHERE pro_id = p_pro_id;

    -- Eliminar la producción
    DELETE FROM produccion WHERE pro_id = p_pro_id;
END$$

DELIMITER ;
-- Llamar al SP para cancelar la producción
CALL PR_cancelar_prod(13);

DELIMITER $$

CREATE TRIGGER composicion_pt
BEFORE INSERT ON inventario_pt
FOR EACH ROW
BEGIN
    DECLARE v_composicion TEXT DEFAULT '';
    DECLARE v_fruta_nombre VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;

    -- Cursor para obtener las frutas utilizadas en la producción
    DECLARE cur CURSOR FOR
        SELECT DISTINCT c.cat_nombre
        FROM prod_detalle pd
        JOIN inventario i ON pd.id_inv = i.id_inv
        JOIN catalogo c ON i.cat_id = c.cat_id
        JOIN categorias ct ON c.ctg_id = ct.ctg_id
        WHERE pd.pro_id = NEW.pro_id 
          AND ct.ctg_nombre = 'Materia Prima';

    -- Manejador para el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Determinar la composición de frutas
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_fruta_nombre;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Concatenar las frutas sin repetir
        IF v_composicion NOT LIKE CONCAT('%', v_fruta_nombre, '%') THEN
            SET v_composicion = CONCAT_WS(', ', v_composicion, v_fruta_nombre);
        END IF;
    END LOOP;
    CLOSE cur;

    -- Asignar la composición a NEW.composicion
    SET NEW.composicion = TRIM(LEADING ', ' FROM v_composicion);
END$$

DELIMITER ;


DROP TRIGGER IF EXISTS composicion_pt;


DELIMITER //

CREATE PROCEDURE `Tp_data`()
BEGIN
    SELECT 
        p.lote_PT AS lote,
        p.pro_fecha AS fecha_produccion,
        SUM(pt.cant_disponible) AS total_disponible,
        SUM(pt.p_t) AS precio_total
    FROM 
        produccion p
    JOIN 
        inventario_pt pt ON p.pro_id = pt.pro_id
    GROUP BY 
        p.lote_PT, p.pro_fecha;
END //

DELIMITER ;

call fpulpas.Tp_data();

DELIMITER //

CREATE PROCEDURE `Tp_detalles`(IN lote_PT VARCHAR(50))
BEGIN
    SELECT 
        pt.id_pt,
        pt.presentacion,
        pt.cant_ingresada,
        pt.cant_disponible,
        pt.p_u,
        pt.p_t,
        pt.p_v_s,
        pt.fecha_caducidad,
        pt.composicion,
        pt.estado,
        pt.observacion
    FROM 
        inventario_pt pt
    JOIN 
        produccion p ON pt.pro_id = p.pro_id
    WHERE 
        p.lote_PT = lote_PT;
END //

DELIMITER ;

call fpulpas.Tp_detalles('PT_0403251');