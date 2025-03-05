-- estado INVENTARIO
DELIMITER $$

CREATE TRIGGER act_estado_stock_inv
BEFORE UPDATE ON inventario
FOR EACH ROW
BEGIN
    -- Verificar si la cantidad restante es menor que 0
    IF NEW.cant_restante < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se puede consumir más de lo disponible.';
    END IF;

    -- Actualizar estado según la cantidad restante
    IF NEW.cant_restante = 0 THEN
        SET NEW.estado = 'agotado';
    ELSEIF NEW.cant_restante < (NEW.cant_ingresada * 0.2) THEN
        SET NEW.estado = 'stock bajo';
    ELSE
        SET NEW.estado = 'disponible';
    END IF;
END$$
DELIMITER ;


SELECT * FROM fpulpas.kardex;

-- elimar un trigger
DROP TRIGGER IF EXISTS kar2;

-- TG Kardex para entradas y salidas 
-- ENTRADAS MP , INS

DELIMITER $$

CREATE TRIGGER kar1
AFTER INSERT ON inventario
FOR EACH ROW
BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex
    WHERE cat_id = NEW.cat_id
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Insertar registro en kardex
    INSERT INTO kardex (fecha_hora, cat_id, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento)
    VALUES (
        NEW.fecha_hora,
        NEW.cat_id,
        NEW.lote,
        NEW.cant_ingresada,
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) + NEW.cant_ingresada,
        'entrada'
    );
END $$

DELIMITER ;

-- SALIDAS MP , INS
DELIMITER $$

CREATE TRIGGER kar2
AFTER INSERT ON prod_detalle
FOR EACH ROW
BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex
    WHERE cat_id = (SELECT cat_id FROM inventario WHERE id_inv = NEW.id_inv)
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Insertar registro en kardex
    INSERT INTO kardex (fecha_hora, cat_id, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento)
    VALUES (
        (SELECT fecha_hora FROM inventario WHERE id_inv = NEW.id_inv),
        (SELECT cat_id FROM inventario WHERE id_inv = NEW.id_inv),
        (SELECT lote FROM inventario WHERE id_inv = NEW.id_inv),
        NEW.pdet_cantidad_usada,  -- Registrar la salida como un valor positivo
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) - NEW.pdet_cantidad_usada,  -- Ajustar el stock restando la cantidad usada
        'salida'
    );
END $$

DELIMITER ;

-- EDICIONES MP , INS
DELIMITER $$

CREATE TRIGGER kar3
AFTER UPDATE ON inventario
FOR EACH ROW
BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);
    DECLARE cantidad_diferencia DECIMAL(10, 2);

    -- Calcular la diferencia en la cantidad
    SET cantidad_diferencia = NEW.cant_ingresada - OLD.cant_ingresada;

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex
    WHERE cat_id = NEW.cat_id
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Insertar registro de ajuste en kardex
    INSERT INTO kardex (fecha_hora, cat_id, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento)
    VALUES (
        NEW.fecha_hora,
        NEW.cat_id,
        NEW.lote,
        cantidad_diferencia,
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) + cantidad_diferencia,
        'ajuste'
    );
END $$

DELIMITER ;