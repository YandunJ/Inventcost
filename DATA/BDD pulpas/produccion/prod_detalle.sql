SELECT * FROM fpulpas.prod_detalle;
-- Tabla que enlaza los insumos y materia prima con la producción
CREATE TABLE prod_detalle (
    pdet_id INT AUTO_INCREMENT PRIMARY KEY,
    pro_id INT NOT NULL,
    id_inv INT NOT NULL ,
    pdet_cantidad_usada DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id) ON DELETE CASCADE,
    FOREIGN KEY (id_inv) REFERENCES inventario(id_inv) ON DELETE CASCADE
);

DROP TRIGGER IF EXISTS k2;



SELECT 
    pd.pdet_cantidad_usada, 
    i.p_u, 
    i.lote,
    CASE 
        WHEN i.lote LIKE 'MP%' THEN pd.pdet_cantidad_usada * i.p_u 
        ELSE 0 
    END AS subtotal_mtpm,
    CASE 
        WHEN i.lote LIKE 'INS%' THEN pd.pdet_cantidad_usada * i.p_u 
        ELSE 0 
    END AS subtotal_ins
FROM prod_detalle pd
LEFT JOIN inventario i ON pd.id_inv = i.id_inv
WHERE pd.pro_id = 24;


SELECT 
    pc.cst_costo_total, 
    pc.cst_presentacion,
    CASE 
        WHEN pc.cst_presentacion = 'UNIDADES' THEN pc.cst_costo_total 
        ELSE 0 
    END AS subtotal_mo,
    CASE 
        WHEN pc.cst_presentacion != 'UNIDADES' THEN pc.cst_costo_total 
        ELSE 0 
    END AS subtotal_ci
FROM prcostos pc
WHERE pc.pro_id = 24;


DELIMITER $$

CREATE PROCEDURE PROD_sp(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON,
    IN datos_mano_obra JSON
)
BEGIN
    DECLARE pro_id INT;
    DECLARE subtotal_mtpm DECIMAL(10, 2) DEFAULT 0;
    DECLARE subtotal_ins DECIMAL(10, 2) DEFAULT 0;
    DECLARE subtotal_mo DECIMAL(10, 2) DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE lote_id INT;
    DECLARE cantidad DECIMAL(10, 2);
    DECLARE precio DECIMAL(10, 2);
    DECLARE stock_actual DECIMAL(10, 2);
    DECLARE cat_id INT;
    DECLARE cant_personas INT;
    DECLARE precio_hora DECIMAL(10, 2);
    DECLARE horas_trabajadas DECIMAL(10, 2);
    DECLARE horas_totales DECIMAL(10, 2);
    DECLARE costo_dia DECIMAL(10, 2);
    DECLARE costo_total DECIMAL(10, 2);
    DECLARE actividad_nombre VARCHAR(100);
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

    -- Procesar datos de mano de obra
    SET i = 0;
    IF JSON_LENGTH(datos_mano_obra) > 0 THEN
        WHILE i < JSON_LENGTH(datos_mano_obra) DO
            SET actividad_nombre = JSON_UNQUOTE(JSON_EXTRACT(datos_mano_obra, CONCAT('$[', i, '].cat_nombre')));
            SET cant_personas = JSON_UNQUOTE(JSON_EXTRACT(datos_mano_obra, CONCAT('$[', i, '].mo_cant_personas')));
            SET precio_hora = JSON_UNQUOTE(JSON_EXTRACT(datos_mano_obra, CONCAT('$[', i, '].mo_precio_hora')));
            SET horas_trabajadas = JSON_UNQUOTE(JSON_EXTRACT(datos_mano_obra, CONCAT('$[', i, '].mo_horas_trabajadas')));
            SET horas_totales = JSON_UNQUOTE(JSON_EXTRACT(datos_mano_obra, CONCAT('$[', i, '].mo_horas_totales')));
            SET costo_dia = JSON_UNQUOTE(JSON_EXTRACT(datos_mano_obra, CONCAT('$[', i, '].mo_costo_dia')));
            SET costo_total = JSON_UNQUOTE(JSON_EXTRACT(datos_mano_obra, CONCAT('$[', i, '].mo_costo_total')));

            -- Obtener el ID de la actividad en base al nombre
      -- Obtener el ID de la actividad en base al nombre
				SELECT cat_id INTO cat_id
				FROM catalogo
				WHERE cat_nombre = actividad_nombre;

				IF cat_id IS NULL THEN
					SET mensaje_error = CONCAT('Error: No se encontró el ID para la actividad ', actividad_nombre);
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = mensaje_error;
				END IF;


            -- Insertar datos de mano de obra
            INSERT INTO mano_obra (pro_id, cat_id, mo_cant_personas, mo_precio_hora, mo_horas_trabajadas, mo_horas_totales, mo_costo_dia, mo_costo_total)
            VALUES (pro_id, cat_id, cant_personas, precio_hora, horas_trabajadas, horas_totales, costo_dia, costo_total);

            -- Calcular subtotal
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

    -- Restaurar estado original de SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = prev_safe_updates;
END$$

DELIMITER ;

CALL PROD_sp(
    50, -- Cantidad producida
    '[{"id_inv": 13, "cantidad": 1}, {"id_inv": 14, "cantidad": 1}]', -- Lotes de materia prima
    '[{"id_inv": 16, "cantidad": 1}, {"id_inv": 23, "cantidad": 1}]', -- Lotes de insumos
    '[{"cat_nombre": "SELECCION", "mo_cant_personas": 2, "mo_precio_hora": 10, "mo_horas_trabajadas": 4, "mo_horas_totales": 8, "mo_costo_dia": 40, "mo_costo_total": 80}]' -- Mano de obra
);


CALL PROD_sp(
    20.00, -- Cantidad producida
    '[{"id_inv": 18, "cantidad": 1.00}]', -- Lotes de materia prima
    '[{"id_inv": 19, "cantidad": 1.00}]', -- Lotes de insumos
    '[{"cat_id": 1, "cant_personas": 5, "precio_hora": 10.00, "horas_trabajadas": 8}]' -- Datos de mano de obra
);


SELECT * FROM catalogo WHERE cat_nombre = 'SELECCION';



DELIMITER $$

CREATE PROCEDURE PROD_data_G()
BEGIN
    SELECT 
        pro_fecha,
        pro_cant_producida,
        pro_subtotal_mtpm,
        pro_subtotal_ins,
        pro_subtotal_mo,
        pro_subtotal_ci,
        pro_total
    FROM produccion;
END$$

DELIMITER ;

CALL PROD_data_G();


DELIMITER //

CREATE PROCEDURE PROD_detalle(IN pro_id INT)
BEGIN
    -- Seleccionar los detalles de la producción
    SELECT 
        p.pro_fecha,
        p.pro_cant_producida,
        p.pro_estado,
        p.pro_subtotal_mtpm,
        p.pro_subtotal_ins,
        p.pro_subtotal_mo,
        p.pro_subtotal_ci,
        p.pro_total
    FROM 
        produccion p
    WHERE 
        p.pro_id = pro_id;

    -- Seleccionar los lotes consumidos en la producción
    SELECT 
        pd.id_inv,
        pd.pdet_cantidad_usada
    FROM 
        prod_detalle pd
    WHERE 
        pd.pro_id = pro_id;

    -- Seleccionar los costos asociados a la producción
    SELECT 
        c.cst_id,
        c.cat_id,
        c.cst_cant,
        c.cst_presentacion,
        c.cst_horas_persona,
        c.cst_precio_ht,
        c.cst_total_horas_actividad,
        c.cst_costo_total
    FROM 
        prcostos c
    WHERE 
        c.pro_id = pro_id;
END //

DELIMITER ;

	call fpulpas.PROD_detalle(8);
