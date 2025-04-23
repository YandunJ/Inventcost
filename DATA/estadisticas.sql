-- ESTADITICAS 

DELIMITER //
CREATE PROCEDURE EST_Lotes_MP_Disp()
BEGIN
    SELECT COUNT(*) AS cantidad 
    FROM inventario i
    INNER JOIN catalogo c ON i.cat_id = c.cat_id
    INNER JOIN categorias ctg ON c.ctg_id = ctg.ctg_id
    WHERE ctg.ctg_nombre = 'Materia Prima'  -- Ajustar según nombre real en tu tabla
      AND i.estado = 'disponible';          -- Ajustar según lógica de estados
END //
DELIMITER ;

call fpulpas.EST_Lotes_MP_Disp();

DELIMITER //
CREATE PROCEDURE EST_Lotes_INS_Disp()
BEGIN
    SELECT COUNT(*) AS cantidad 
    FROM inventario i
    INNER JOIN catalogo c ON i.cat_id = c.cat_id
    INNER JOIN categorias ctg ON c.ctg_id = ctg.ctg_id
    WHERE ctg.ctg_nombre = 'Insumos'        -- Ajustar según nombre real
      AND i.estado = 'disponible';
END //
DELIMITER ;

call fpulpas.EST_Lotes_INS_Disp();


DELIMITER //
CREATE PROCEDURE EST_Lotes_PT_Disp()
BEGIN
    SELECT COUNT(*) AS cantidad 
    FROM inventario_pt 
    WHERE estado = 'disponible';            -- Asumiendo que PT usa el mismo estado
END //
DELIMITER ;

call fpulpas.EST_Lotes_PT_Disp();

DELIMITER //
CREATE PROCEDURE EST_Lotes_Proximos_Vencer()
BEGIN
    -- Lotes MP/INS próximos a vencer (30 días)
    SELECT COUNT(*) AS cantidad 
    FROM inventario 
    WHERE fecha_caducidad BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
    UNION ALL
    -- Lotes PT próximos a vencer
    SELECT COUNT(*) 
    FROM inventario_pt 
    WHERE fecha_caducidad BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);
END //
DELIMITER ;

call fpulpas.EST_Lotes_Proximos_Vencer();

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Zentradas_cat`(IN mes INT, IN anio INT)
BEGIN
    SELECT c.ctg_nombre, SUM(i.cant_ingresada) AS cantidad
    FROM inventario i
    JOIN catalogo cat ON i.cat_id = cat.cat_id
    JOIN categorias c ON cat.ctg_id = c.ctg_id
    WHERE MONTH(i.fecha_hora) = mes AND YEAR(i.fecha_hora) = anio
    GROUP BY c.ctg_id;
END$$
DELIMITER ;



DELIMITER //
CREATE PROCEDURE EST_invert_mes(IN mes INT, IN anio INT)
BEGIN
    -- MP e INS: Sumar p_t de inventario donde tipo_movimiento = 'entrada'
    SELECT 
        c.ctg_nombre AS categoria,
        SUM(i.p_t) AS total
    FROM inventario i
    INNER JOIN catalogo cat ON i.cat_id = cat.cat_id
    INNER JOIN categorias c ON cat.ctg_id = c.ctg_id
    INNER JOIN kardex k ON i.id_inv = k.id_kardex -- Asumiendo relación inventario-kardex
    WHERE 
        MONTH(i.fecha_hora) = mes 
        AND YEAR(i.fecha_hora) = anio 
        AND k.tipo_movimiento = 'entrada'
    GROUP BY c.ctg_nombre
    UNION ALL
    -- PT: Sumar p_t de inventario_pt (entradas de producción)
    SELECT 
        'Productos Terminados' AS categoria,
        SUM(p_t) AS total
    FROM inventario_pt
    WHERE 
        MONTH(fecha_caducidad) = mes  -- Ajustar según campo de fecha correcto
        AND YEAR(fecha_caducidad) = anio;
END //
DELIMITER ;

CALL EST_invert_mes(03, 2025); -- Octubre 2023