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
CREATE PROCEDURE EST_Lotes_PT_Disponibles()
BEGIN
    SELECT COUNT(*) AS cantidad 
    FROM inventario_pt 
    WHERE estado = 'disponible';            -- Asumiendo que PT usa el mismo estado
END //
DELIMITER ;