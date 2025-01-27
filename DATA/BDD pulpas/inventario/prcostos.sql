SELECT * FROM fpulpas.prcostos;

CREATE TABLE prcostos (
    cst_id INT AUTO_INCREMENT PRIMARY KEY,        -- ID único de la tabla prcostos
    pro_id INT NOT NULL,                          -- Relación con producción
    cat_id INT NOT NULL,                          -- Relación con catálogo (mano de obra o costos indirectos)
    cst_cant DECIMAL(10,2) DEFAULT NULL,  -- Cantidad de personas o cantidad unitaria para costos indirectos
    cst_presentacion VARCHAR(20) DEFAULT 'UNIDADES',      -- presentacion o unidad de medida
    cst_horas_persona DECIMAL(10,2) DEFAULT NULL,  -- Total de horas por persona (para mano de obra)
    cst_precio_ht DECIMAL(10,2) DEFAULT NULL,          -- Precio por hora o precio unitario para costos indirectos
    cst_total_horas_actividad DECIMAL(10,2) DEFAULT NULL,  -- Total de horas trabajadas (para mano de obra)
    cst_costo_total DECIMAL(10,2) NOT NULL,       -- Costo total calculado
    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id),  -- Relación con producción
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id)    -- Relación con catálogo
    
);


DELIMITER $$

CREATE PROCEDURE PROD_sp(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON,
    IN mano_obra JSON,
    IN costos_indirectos JSON -- Entrada para costos indirectos
)
BEGIN
    DECLARE pro_id INT;
    DECLARE i INT DEFAULT 0;
    DECLARE inv_id INT;
    DECLARE cant DECIMAL(10, 2);
    DECLARE horas_persona DECIMAL(10, 2);
    DECLARE precio_ht DECIMAL(10, 2);
    DECLARE costo_total DECIMAL(10, 2);
    DECLARE total_horas DECIMAL(10, 2); -- Variable para el total de horas trabajadas por actividad
    DECLARE cant_restante DECIMAL(10, 2); -- Variable para almacenar la cantidad restante en inventario
    DECLARE mensaje_error VARCHAR(255);
    DECLARE cat_id INT; -- Agregado para declarar la variable cat_id

    -- Insertar en producción
    INSERT INTO produccion (pro_cant_producida)
    VALUES (cant_producida);
    SET pro_id = LAST_INSERT_ID();

    -- Procesar lotes de materia prima
    IF JSON_LENGTH(lotes_mp) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(lotes_mp) DO
            SET inv_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].id_inv')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].cantidad')));

            -- Verificar la cantidad restante en inventario
            SELECT cant_restante INTO cant_restante
            FROM inventario
            WHERE id_inv = inv_id;

            -- Si la cantidad restante es insuficiente, abortar el proceso
            IF cant_restante < cant THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente cantidad en inventario para el lote ', inv_id);
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
            ELSE
                -- Actualizar inventario (restar la cantidad utilizada)
                UPDATE inventario
                SET cant_restante = cant_restante - cant
                WHERE id_inv = inv_id AND cant_restante >= cant;

                -- Insertar en detalle de producción
                INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
                VALUES (pro_id, inv_id, cant);
            END IF;

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar lotes de insumos
    IF JSON_LENGTH(lotes_ins) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(lotes_ins) DO
            SET inv_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].id_inv')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].cantidad')));

            -- Verificar la cantidad restante en inventario
            SELECT cant_restante INTO cant_restante
            FROM inventario
            WHERE id_inv = inv_id;

            -- Si la cantidad restante es insuficiente, abortar el proceso
            IF cant_restante < cant THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente cantidad en inventario para el lote ', inv_id);
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
            ELSE
                -- Actualizar inventario (restar la cantidad utilizada)
                UPDATE inventario
                SET cant_restante = cant_restante - cant
                WHERE id_inv = inv_id AND cant_restante >= cant;

                -- Insertar en detalle de producción
                INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
                VALUES (pro_id, inv_id, cant);
            END IF;

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar mano de obra
    IF JSON_LENGTH(mano_obra) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(mano_obra) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].cat_id')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_cant_personas')));
            SET horas_persona = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_horas_trabajadas')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_precio_hora')));
            SET total_horas = cant * horas_persona; -- Total de horas de trabajo para la actividad
            SET costo_total = total_horas * precio_ht; -- Costo total

            -- Insertar en costos
            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_horas_persona, cst_precio_ht, cst_total_horas_actividad, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cant, 'UNIDADES', horas_persona, precio_ht, total_horas, costo_total
            );

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar costos indirectos
    IF JSON_LENGTH(costos_indirectos) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(costos_indirectos) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cat_id')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_cant')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_precio_ht')));
            SET costo_total = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_costo_total')));

            -- Calcular el costo total si no se pasa el valor, usando cantidad y precio unitario
            IF costo_total IS NULL THEN
                SET costo_total = cant * precio_ht;
            END IF;

            -- Insertar en costos
            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_precio_ht, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cant, 'UNIDADES', precio_ht, costo_total
            );

            SET i = i + 1;
        END WHILE;
    END IF;

END$$

DELIMITER ;

CALL PROD_sp(
    100.00, -- Cantidad producida
    '[{"id_inv": 13, "cantidad": 1}, {"id_inv": 14, "cantidad": 1}]', -- Lotes de materia prima
    '[{"id_inv": 17, "cantidad": 1}, {"id_inv": 18, "cantidad": 1}]', -- Lotes de insumos
    '[{"cat_id": 1, "mo_cant_personas": 2, "mo_horas_trabajadas": 8, "mo_precio_hora": 50}]', -- Mano de obra
    '[{"cat_id": 3, "cst_cant": 5, "cst_precio_ht": 20, "cst_costo_total": 100}]' -- Costos indirectos
);

CALL PROD_sp(
    100.00, -- Cantidad producida
    '[{"id_inv": 1, "cantidad": 10}, {"id_inv": 2, "cantidad": 15}]', -- Lotes de materia prima
    '[{"id_inv": 3, "cantidad": 5}, {"id_inv": 4, "cantidad": 8}]', -- Lotes de insumos
    '[{"cat_id": 1, "mo_cant_personas": 2, "mo_horas_trabajadas": 8, "mo_precio_hora": 50}]', -- Mano de obra
    '[{"cat_id": 3, "cst_cant": 5, "cst_precio_ht": 20, "cst_costo_total": 100}]' -- Costos indirectos
);



CALL PROD_sp(
    100.00, -- Cantidad producida
    '[{"id_inv": 1, "cantidad": 10}, {"id_inv": 2, "cantidad": 15}]', -- Lotes de MP
    '[{"id_inv": 3, "cantidad": 5}, {"id_inv": 4, "cantidad": 8}]', -- Lotes de insumos
    '[{"cat_id": 1, "mo_cant_personas": 2, "mo_horas_trabajadas": 8, "mo_precio_hora": 50}]', -- Mano de obra
    '[{"cat_id": 3, "cst_costo_total": 200}]' -- Costos indirectos
);
DELIMITER $$

CREATE PROCEDURE PR_consumo(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON,
    IN mano_obra JSON,
    IN costos_indirectos JSON
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
END$$

DELIMITER ;



CALL PR_consumo(
    50.00, -- Cantidad producida
    '[{"id_inv": 20, "cantidad": 1.00}]', -- Lotes de materia prima
    '[{"id_inv": 21, "cantidad": 1.00}]', -- Lotes de insumos
    '[{"cat_id": 1, "mo_cant_personas": 2, "mo_horas_trabajadas": 8, "mo_precio_hora": 50}]', -- Mano de obra
    '[{"cat_id": 2, "cst_cant": 5, "cst_presentacion": "LITROS", "cst_precio_ht": 30}]' -- Costos indirectos
);
