 
CREATE TABLE kardex (
    id_kardex INT AUTO_INCREMENT PRIMARY KEY, -- ID del registro en kardex
    fecha_hora DATETIME NOT NULL,             -- Fecha y hora del movimiento
    cat_id INT NOT NULL,                      -- ID del catálogo
    lote VARCHAR(50),                         -- Lote relacionado al producto
    cantidad DECIMAL(10, 2) NOT NULL,         -- Cantidad movida (positivo para ingreso, negativo para salida)
    stock_anterior DECIMAL(10, 2),            -- Stock disponible antes del movimiento
    stock_actual DECIMAL(10, 2),              -- Stock disponible después del movimiento
    tipo_movimiento ENUM('entrada', 'salida', 'ajuste') NOT NULL, -- Tipo de movimiento
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id)
) ENGINE=InnoDB;





















DELIMITER $$
CREATE TRIGGER TR_entradas
AFTER INSERT ON inventario
FOR EACH ROW
BEGIN
    DECLARE stock_anterior DECIMAL(10, 2);
    DECLARE stock_actual DECIMAL(10, 2);

    -- Consultar el stock anterior del producto
    SELECT COALESCE(cat_stock, 0) INTO stock_anterior
    FROM catalogo
    WHERE cat_id = NEW.cat_id;

    -- Calcular el nuevo stock actual
    SET stock_actual = stock_anterior + NEW.cant_ingresada;

    -- Insertar registro en la tabla kardex
    INSERT INTO kardex (
        fecha_hora, 
        cat_id, 
        lote, 
        descripcion, 
        cantidad, 
        stock_anterior, 
        stock_actual, 
        tipo_movimiento
    )
    VALUES (
        NEW.fecha_hora, 
        NEW.cat_id, 
        NEW.lote, 
        'Ingreso al inventario', 
        NEW.cant_ingresada, 
        stock_anterior, 
        stock_actual, 
        'entrada'
    );

    -- Actualizar el stock en la tabla catalogo
    UPDATE catalogo
    SET cat_stock = stock_actual
    WHERE cat_id = NEW.cat_id;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_insert_inventario;

DELIMITER $$
CREATE TRIGGER TR_salidas
AFTER INSERT ON prod_detalle
FOR EACH ROW
BEGIN
    DECLARE stock_anterior DECIMAL(10, 2);
    DECLARE stock_actual DECIMAL(10, 2);

    -- Consultar el stock anterior del producto
    SELECT COALESCE(cat_stock, 0) INTO stock_anterior
    FROM catalogo
    WHERE cat_id = (SELECT cat_id FROM inventario WHERE id_inv = NEW.id_inv);

    -- Validar si hay suficiente stock para la salida
    IF stock_anterior >= NEW.pdet_cantidad_usada THEN
        -- Calcular el nuevo stock actual
        SET stock_actual = stock_anterior - NEW.pdet_cantidad_usada;

        -- Insertar registro en la tabla kardex
        INSERT INTO kardex (
            fecha_hora, 
            cat_id, 
            lote, 
            descripcion, 
            cantidad, 
            stock_anterior, 
            stock_actual, 
            tipo_movimiento
        )
        VALUES (
            NOW(), 
            (SELECT cat_id FROM inventario WHERE id_inv = NEW.id_inv), 
            (SELECT lote FROM inventario WHERE id_inv = NEW.id_inv), 
            'Salida por producción', 
            NEW.pdet_cantidad_usada, 
            stock_anterior, 
            stock_actual, 
            'salida'
        );

        -- Actualizar el stock en la tabla catalogo
        UPDATE catalogo
        SET cat_stock = stock_actual
        WHERE cat_id = (SELECT cat_id FROM inventario WHERE id_inv = NEW.id_inv);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock para realizar la salida.';
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS TR_salidas;
DELIMITER //

CREATE PROCEDURE kardex_G(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_categoria_id INT
)
BEGIN
    SELECT 
        i.cat_id AS ID,
        ca.cat_nombre AS Artículo,
        p.prs_nombre AS Presentación,
        SUM(i.cant_ingresada) AS Entradas,
        IFNULL(SUM(pd.pdet_cantidad_usada), 0) AS Salidas,
        SUM(i.cant_ingresada) - IFNULL(SUM(pd.pdet_cantidad_usada), 0) AS Saldo
    FROM inventario i
    JOIN catalogo ca ON i.cat_id = ca.cat_id
    LEFT JOIN presentacion p ON ca.prs_id = p.prs_id
    LEFT JOIN prod_detalle pd ON i.id_inv = pd.id_inv
    WHERE i.fecha_hora BETWEEN p_fecha_inicio AND DATE_ADD(p_fecha_fin, INTERVAL 1 DAY)
      AND (ca.ctg_id = p_categoria_id OR p_categoria_id = 0)
    GROUP BY i.cat_id, ca.cat_nombre, p.prs_nombre
    ORDER BY ca.cat_nombre;
END //

DELIMITER ;

CALL kardex_G('2025-01-01', '2025-01-27', 1);




DELIMITER //

CREATE PROCEDURE kardex_det(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_categoria_id INT,
    IN p_articulo_id INT
)
BEGIN
    SELECT 
        i.fecha_hora AS `Fecha y Hora`,
        i.lote AS Lote,
        pr.nombre_empresa AS Proveedor,
        ca.cat_nombre AS Artículo,
        p.prs_nombre AS Presentación,
        i.cant_ingresada AS Cantidad,
        i.p_u AS `Precio Unitario`,
        i.p_t AS `Precio Total`,
        'Entrada' AS `Tipo de Movimiento`
    FROM inventario i
    LEFT JOIN catalogo ca ON i.cat_id = ca.cat_id
    LEFT JOIN presentacion p ON ca.prs_id = p.prs_id
    LEFT JOIN proveedores pr ON i.proveedor_id = pr.proveedor_id
    WHERE (i.fecha_hora BETWEEN p_fecha_inicio AND DATE_ADD(p_fecha_fin, INTERVAL 1 DAY))
      AND (ca.ctg_id = p_categoria_id OR p_categoria_id = 0)
      AND (ca.cat_id = p_articulo_id OR p_articulo_id = 0)
    
    UNION ALL
    
    SELECT 
        i.fecha_hora AS `Fecha y Hora`,
        i.lote AS Lote,
        NULL AS Proveedor,
        ca.cat_nombre AS Artículo,
        p.prs_nombre AS Presentación,
        pd.pdet_cantidad_usada AS Cantidad,
        i.p_u AS `Precio Unitario`,
        (pd.pdet_cantidad_usada * i.p_u) AS `Precio Total`,
        'Salida' AS `Tipo de Movimiento`
    FROM prod_detalle pd
    INNER JOIN inventario i ON pd.id_inv = i.id_inv
    LEFT JOIN catalogo ca ON i.cat_id = ca.cat_id
    LEFT JOIN presentacion p ON ca.prs_id = p.prs_id
    WHERE (i.fecha_hora BETWEEN p_fecha_inicio AND DATE_ADD(p_fecha_fin, INTERVAL 1 DAY))
      AND (ca.ctg_id = p_categoria_id OR p_categoria_id = 0)
      AND (ca.cat_id = p_articulo_id OR p_articulo_id = 0)
    
    ORDER BY `Fecha y Hora`, `Tipo de Movimiento`;
END //

DELIMITER ;

CALL kardex_det('2025-01-01', '2025-01-27', 1, 1);


CALL kardex_G(1, 2025, 1);


DELIMITER //

CREATE PROCEDURE Zentradas_cat(IN mes INT, IN anio INT)
BEGIN
    SELECT c.ctg_nombre, SUM(i.cant_ingresada) AS cantidad
    FROM inventario i
    JOIN catalogo cat ON i.cat_id = cat.cat_id
    JOIN categorias c ON cat.ctg_id = c.ctg_id
    WHERE MONTH(i.fecha_hora) = mes AND YEAR(i.fecha_hora) = anio
    GROUP BY c.ctg_id;
END //

DELIMITER ;
