SELECT * FROM fpulpas.produccion;

-- pro_lote VARCHAR(255) NOT NULL, 
CREATE TABLE produccion (
    pro_id INT AUTO_INCREMENT PRIMARY KEY,
    pro_fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    pro_cant_producida DECIMAL(10,2) NULL,
    pro_estado VARCHAR(20) DEFAULT 'en proceso',
    pro_subtotal_mtpm DECIMAL(10,2) DEFAULT '0.00',
    pro_subtotal_ins DECIMAL(10,2) DEFAULT '0.00',
    pro_subtotal_mo DECIMAL(10,2) DEFAULT '0.00',
    pro_subtotal_ci DECIMAL(10,2) DEFAULT '0.00',
    pro_total DECIMAL(10,2) DEFAULT '0.00'
);


DELIMITER $$

CREATE PROCEDURE PROD_sp(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON,
    IN mano_obra JSON -- Nueva entrada para mano de obra
)
BEGIN
    DECLARE pro_id INT;
    DECLARE subtotal_mtpm DECIMAL(10, 2) DEFAULT 0;
    DECLARE subtotal_ins DECIMAL(10, 2) DEFAULT 0;
    DECLARE subtotal_mo DECIMAL(10, 2) DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE cat_id INT;
    DECLARE cant_personas INT;
    DECLARE precio_hora DECIMAL(10, 2);
    DECLARE horas_trabajadas DECIMAL(10, 2);
    DECLARE horas_totales DECIMAL(10, 2);
    DECLARE costo_dia DECIMAL(10, 2);
    DECLARE costo_total DECIMAL(10, 2);

    -- Insertar en producción (sin especificar fecha)
    INSERT INTO produccion (pro_cant_producida)
    VALUES (cant_producida);
    SET pro_id = LAST_INSERT_ID();

    -- Procesar lotes de materia prima (igual que antes)
    IF JSON_LENGTH(lotes_mp) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(lotes_mp) DO
            -- Lógica de procesamiento de materia prima
            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar lotes de insumos (igual que antes)
    IF JSON_LENGTH(lotes_ins) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(lotes_ins) DO
            -- Lógica de procesamiento de insumos
            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar mano de obra
    IF JSON_LENGTH(mano_obra) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(mano_obra) DO
            -- Extraer valores de JSON
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].cat_id')));
            SET cant_personas = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_cant_personas')));
            SET precio_hora = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_precio_hora')));
            SET horas_trabajadas = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_horas_trabajadas')));
            SET horas_totales = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_horas_totales')));
            SET costo_dia = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_costo_dia')));
            SET costo_total = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_costo_total')));

            -- Insertar datos en la tabla mano_obra
            INSERT INTO mano_obra (
                pro_id, cat_id, mo_cant_personas, mo_precio_hora, 
                mo_horas_trabajadas, mo_horas_totales, mo_costo_dia, mo_costo_total
            )
            VALUES (
                pro_id, cat_id, cant_personas, precio_hora,
                horas_trabajadas, horas_totales, costo_dia, costo_total
            );

            -- Calcular subtotal de mano de obra
            SET subtotal_mo = subtotal_mo + costo_total;

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Actualizar subtotales en producción
    UPDATE produccion
    SET pro_subtotal_mtpm = subtotal_mtpm,
        pro_subtotal_ins = subtotal_ins,
        pro_subtotal_mo = subtotal_mo,
        pro_total = subtotal_mtpm + subtotal_ins + subtotal_mo
    WHERE pro_id = pro_id;
END$$

DELIMITER ;


CALL PROD_sp(
    50.00, -- Cantidad producida
    '[{"id_inv": 13, "cantidad": 2.00}]', -- Lotes de materia prima
    '[{"id_inv": 16, "cantidad": 2.00}]', -- Lotes de insumos
    '[
        {
            "cat_id": 1,
            "mo_cant_personas": 5,
            "mo_precio_hora": 12.50,
            "mo_horas_trabajadas": 8.00,
            "mo_horas_totales": 40.00,
            "mo_costo_dia": 500.00,
            "mo_costo_total": 500.00
        },
        {
            "cat_id": 2,
            "mo_cant_personas": 3,
            "mo_precio_hora": 15.00,
            "mo_horas_trabajadas": 6.00,
            "mo_horas_totales": 18.00,
            "mo_costo_dia": 270.00,
            "mo_costo_total": 270.00
        }
    ]'
);

SP PRODUCCION CONSUMIR CANTIDADES

DELIMITER $$

CREATE PROCEDURE PR_consumo(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON
)
BEGIN
    DECLARE pro_id INT;
    DECLARE subtotal_mtpm DECIMAL(10, 2) DEFAULT 0;
    DECLARE subtotal_ins DECIMAL(10, 2) DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE lote_id INT;
    DECLARE cantidad DECIMAL(10, 2);
    DECLARE precio DECIMAL(10, 2);
    DECLARE stock_actual DECIMAL(10, 2);
    DECLARE mensaje_error VARCHAR(255);
    DECLARE prev_safe_updates INT;

    -- Guardar estado original de SQL_SAFE_UPDATES
    SET prev_safe_updates = @@SQL_SAFE_UPDATES;
    SET SQL_SAFE_UPDATES = 0;

    -- Insertar en producción (sin especificar fecha)
    INSERT INTO produccion (pro_cant_producida)
    VALUES (cant_producida);
    SET pro_id = LAST_INSERT_ID();

    -- Procesar lotes de materia prima
    IF JSON_LENGTH(lotes_mp) > 0 THEN
        WHILE i < JSON_LENGTH(lotes_mp) DO
            SET lote_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].id_inv')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].cantidad')));

            -- Verificar stock disponible
            SELECT cant_restante INTO stock_actual
            FROM inventario
            WHERE id_inv = lote_id;

            IF stock_actual < cantidad THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente stock en el lote ', lote_id, '. Stock disponible: ', stock_actual);
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = mensaje_error;
            END IF;

            -- Obtener precio unitario
            SELECT p_u INTO precio FROM inventario WHERE id_inv = lote_id;

            -- Insertar detalle
            INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
            VALUES (pro_id, lote_id, cantidad);

            -- Actualizar inventario
            UPDATE inventario
            SET cant_restante = cant_restante - cantidad
            WHERE id_inv = lote_id;

            -- Calcular subtotal
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

            -- Verificar stock disponible
            SELECT cant_restante INTO stock_actual
            FROM inventario
            WHERE id_inv = lote_id;

            IF stock_actual < cantidad THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente stock en el lote ', lote_id, '. Stock disponible: ', stock_actual);
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = mensaje_error;
            END IF;

            -- Obtener precio unitario
            SELECT p_u INTO precio FROM inventario WHERE id_inv = lote_id;

            -- Insertar detalle
            INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
            VALUES (pro_id, lote_id, cantidad);

            -- Actualizar inventario
            UPDATE inventario
            SET cant_restante = cant_restante - cantidad
            WHERE id_inv = lote_id;

            -- Calcular subtotal
            SET subtotal_ins = subtotal_ins + (cantidad * precio);
            SET i = i + 1;
        END WHILE;
    END IF;

    -- Actualizar subtotales en producción
    UPDATE produccion
    SET pro_subtotal_mtpm = subtotal_mtpm,
        pro_subtotal_ins = subtotal_ins,
        pro_total = subtotal_mtpm + subtotal_ins
    WHERE pro_id = pro_id;

    -- Restaurar estado original de SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = prev_safe_updates;
END$$

DELIMITER ;

CALL PR_consumo(
    50.00, -- Cantidad producida
    '[{"id_inv": 17, "cantidad": 1.00}]', -- Lotes de materia prima
    '[{"id_inv": 18, "cantidad": 1.00}]' -- Lotes de insumos
);


revisar ??? 

CALL PROD_sp(
    '2025-01-16 12:00:00',  -- Fecha de producción
    100.00,                 -- Cantidad producida
    '[{"id_inv": 1, "cantidad": 2.5}, {"id_inv": 2, "cantidad": 3.0}, {"id_inv": 3, "cantidad": 3.5}]',  -- Lotes de materia prima
    '[{"id_inv": 4, "cantidad": 4.0}, {"id_inv": 5, "cantidad": 2.5}, {"id_inv": 6, "cantidad": 1.0}]'   -- Lotes de insumos
);

CALL PROD_sp(
    8.00, -- Cantidad producida
    '[{"id_inv": 20, "cantidad": 1.00}]', -- Lote único de materia prima (ID 7)
    '[{"id_inv": 21, "cantidad": 1.00}, {"id_inv": 22, "cantidad": 3.00}]' -- Dos lotes de insumos (IDs 6 y 20)
);

CALL PROD_sp(
    8.00, -- Cantidad producida
    '[{"id_inv": 10, "cantidad": 5.00}]', -- Lote único de materia prima (ID 7)
    '[{"id_inv": 11, "cantidad": 1.00}' -- Dos lotes de insumos (IDs 6 y 20)
);

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 1;



DELIMITER //

CREATE PROCEDURE Consumo_inv(
    IN p_lote VARCHAR(255),
    IN p_cant_producida DECIMAL(10,2),
    IN p_estado VARCHAR(20),
    IN p_subtotal_mtpm DECIMAL(10,2),
    IN p_subtotal_ins DECIMAL(10,2),
    IN p_subtotal_mo DECIMAL(10,2),
    IN p_subtotal_ci DECIMAL(10,2),
    IN p_total DECIMAL(10,2),
    IN p_detalle JSON,
    IN p_mano_obra JSON,
    IN p_costos_indirectos JSON
)
BEGIN
    DECLARE last_pro_id INT;

    -- Insertar en la tabla produccion
    INSERT INTO produccion (pro_lote, pro_cant_producida, pro_estado, pro_subtotal_mtpm, pro_subtotal_ins, pro_subtotal_mo, pro_subtotal_ci, pro_total)
    VALUES (p_lote, p_cant_producida, p_estado, p_subtotal_mtpm, p_subtotal_ins, p_subtotal_mo, p_subtotal_ci, p_total);

    SET last_pro_id = LAST_INSERT_ID();

    -- Insertar en la tabla prod_detalle
    INSERT INTO prod_detalle (pro_id, inv_id, inv_lote, pdet_cantidad_usada, pdet_cantidad_producida, pdet_cantidad_desperdiciada)
    SELECT last_pro_id, JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.inv_id')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.inv_lote')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.pdet_cantidad_usada')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.pdet_cantidad_producida')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.pdet_cantidad_desperdiciada'))
    FROM JSON_TABLE(p_detalle, '$[*]' COLUMNS (value JSON PATH '$')) AS j;

    -- Insertar en la tabla mano_obra
    INSERT INTO mano_obra (pro_id, cat_id, mo_cant_personas, mo_precio_hora, mo_horas_trabajadas, mo_horas_totales, mo_costo_dia, mo_costo_total)
    SELECT last_pro_id, JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cat_id')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_cant_personas')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_precio_hora')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_horas_trabajadas')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_horas_totales')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_costo_dia')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_costo_total'))
    FROM JSON_TABLE(p_mano_obra, '$[*]' COLUMNS (value JSON PATH '$')) AS j;

    -- Insertar en la tabla costos_indirectos
    INSERT INTO costos_indirectos (pro_id, cat_id, cost_cant, cost_unit, cost_total)
    SELECT last_pro_id, JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cat_id')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cost_cant')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cost_unit')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cost_total'))
    FROM JSON_TABLE(p_costos_indirectos, '$[*]' COLUMNS (value JSON PATH '$')) AS j;
END //

DELIMITER ;


CALL Consumo_inv(
    
    'PT_1401251',           -- p_lote
    100.00,                 -- p_cant_producida
    'completado',           -- p_estado
    500.00,                 -- p_subtotal_mtpm
    300.00,                 -- p_subtotal_ins
    200.00,                 -- p_subtotal_mo
    100.00,                 -- p_subtotal_ci
    1100.00,                -- p_total
    '[{"inv_id": 1, "pdet_cantidad_usada": 10, "pdet_cantidad_producida": 5, "pdet_cantidad_desperdiciada": 0}]',  -- p_detalle
    '[{"cat_id": 1, "mo_cant_personas": 5, "mo_precio_hora": 20, "mo_horas_trabajadas": 8, "mo_horas_totales": 40, "mo_costo_dia": 800, "mo_costo_total": 800}]',  -- p_mano_obra
    '[{"cat_id": 1, "cost_cant": 2, "cost_unit": 50, "cost_total": 100}]'  -- p_costos_indirectos
);


CREATE DEFINER=root@localhost PROCEDURE sp_ObtenerMovimientosAgrupadosConDetalle(IN KardexIDs VARCHAR(255))
BEGIN
    SELECT 
        -- Producto: Dependiendo de si es maquinaria, tanque o catálogo, mostrar la categoría desde Catalogo
        CASE 
            WHEN t.tan_tipo IS NOT NULL THEN (SELECT c.Categoria FROM Catalogo c WHERE c.ID_Catalogo = t.tan_tipo LIMIT 1)  -- Mostrar la categoria de tanque
            WHEN m.Marca IS NOT NULL THEN (SELECT c.Categoria FROM Catalogo c WHERE c.ID_Catalogo = m.Marca LIMIT 1)        -- Mostrar la categoria de maquinaria
            ELSE (SELECT c.Categoria FROM Catalogo c WHERE c.ID_Catalogo = k.kar_ID_Producto LIMIT 1)        -- Mostrar la categoria del producto desde Catalogo
        END AS Producto,

        -- Mostrar el código del producto: Si es un tanque, mostrar tan_Codigo, si es maquinaria, mostrar Codigo
        CASE
            WHEN t.tan_tipo IS NOT NULL THEN t.tan_Codigo      -- Si es un tanque, mostrar el código del tanque
            WHEN m.Marca IS NOT NULL THEN m.Codigo              -- Si es maquinaria, mostrar el código de la maquinaria
            ELSE k.kar_ID_Producto                              -- Si no es ni tanque ni maquinaria, mostrar el ID de producto directamente
        END AS Codigo,

        -- Marca: Obtener la categoría de la marca desde el Catalogo
        CASE
            WHEN c.Categoria IS NOT NULL THEN c.Categoria -- Mostrar la Categoria de Marca solo si no está vacía
            ELSE NULL  -- Si no existe, no mostrar
        END AS Marca,

        -- Capacidad: Obtener la categoría de la capacidad desde el Catalogo
        CASE
            WHEN c2.Categoria IS NOT NULL THEN c2.Categoria -- Mostrar la Categoria de Capacidad solo si no está vacía
            ELSE NULL  -- Si no existe, no mostrar
        END AS Capacidad,

        -- Descripción: La lógica para mostrar las descripciones
        CASE
            WHEN t.tan_tipo IS NOT NULL THEN NULL -- Si es un tanque, dejar el campo en blanco
            WHEN m.Descripcion IS NOT NULL THEN m.Descripcion  -- Descripción de Maquinaria si existe
            WHEN c.Categoria IS NOT NULL THEN c.Categoria      -- Mostrar la Categoria asociada a la Marca si no existe Descripcion en Maquinaria
            WHEN c2.Categoria IS NOT NULL THEN c2.Categoria    -- Mostrar la Categoria asociada a la Capacidad si no existe Descripcion ni en Maquinaria ni en Marca
            ELSE NULL                                          -- Dejar en blanco si todas son nulas
        END AS Descripcion,

        -- El resto de los campos como están en el original
        k.kar_Fecha AS Fecha,
        k.kar_Cantidad AS Cantidad,
        k.kar_Numero_Lote AS Numero_Lote,
        k.kar_Fecha_Caducidad AS Fecha_Caducidad,
        k.kar_Registro_Sanitario AS Registro_Sanitario,
        k.kar_Costo_Compra AS Costo_Compra,
        k.kar_Costo_Actual AS Costo_Actual,
        k.kar_Tipo_Movimiento AS Tipo_Movimiento

    FROM Kardex k
    LEFT JOIN Catalogo c ON k.kar_Marca = c.ID_Catalogo    -- Unir con Catalogo para obtener la Categoria de Marca
    LEFT JOIN Catalogo c2 ON k.kar_Capacidad = c2.ID_Catalogo -- Unir con Catalogo para obtener la Categoria de Capacidad
    LEFT JOIN Tanque t ON k.kar_ID_Producto = t.tan_ID_Tanque -- Unir con Tanque para obtener tipo de producto (sin descripcion)
    LEFT JOIN Maquinaria_Equipo m ON k.kar_ID_Producto = m.ID_Maquinaria  -- Unir con Maquinaria_Equipo para obtener la Descripcion de Maquinaria
    WHERE FIND_IN_SET(k.kar_ID_Kardex, KardexIDs)
      AND (
          -- Filtrar para no mostrar productos con campos vacíos
          t.tan_tipo IS NOT NULL OR
          m.Marca IS NOT NULL OR
          c.Categoria IS NOT NULL OR
          c2.Categoria IS NOT NULL OR
          m.Descripcion IS NOT NULL
      );
END