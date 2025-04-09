SELECT * FROM fpulpas.catalogo;



DELIMITER $$

CREATE PROCEDURE `SP_ESTAD`()
BEGIN
    -- Cantidad de frutas en catálogo (categoría 1)
    SELECT COUNT(*) AS cantidad_frutas
    FROM catalogo
    WHERE ctg_id = 1;

    -- Cantidad de insumos en catálogo (categoría 2)
    SELECT COUNT(*) AS cantidad_insumos
    FROM catalogo
    WHERE ctg_id = 2;

    -- Cantidad de proveedores
    SELECT COUNT(*) AS cantidad_proveedores
    FROM proveedores;

    -- Cantidad de presentaciones de insumos
    SELECT COUNT(*) AS cantidad_presentaciones_insumos
    FROM presentacion
    WHERE ctg_id = 2;

    -- Cantidad de presentaciones de producto terminado
    SELECT COUNT(*) AS cantidad_presentaciones_pt
    FROM presentacion
    WHERE ctg_id = 3;

    -- Cantidad de lotes de materia prima
    SELECT COUNT(*) AS cantidad_lotes_mp
    FROM inventario
    WHERE cat_id IN (SELECT cat_id FROM catalogo WHERE ctg_id = 1);

    -- Cantidad de lotes de insumos
    SELECT COUNT(*) AS cantidad_lotes_insumos
    FROM inventario
    WHERE cat_id IN (SELECT cat_id FROM catalogo WHERE ctg_id = 2);

    -- Cantidad de lotes de producto terminado
    SELECT COUNT(*) AS cantidad_lotes_pt
    FROM inventario_pt;
END$$

DELIMITER ;
