DELIMITER $$

CREATE PROCEDURE ESTFrutas()
BEGIN
    SELECT cat_nombre AS fruta, SUM(cant_restante) AS cantidad
    FROM inventario
    JOIN catalogo ON inventario.cat_id = catalogo.cat_id
    WHERE catalogo.ctg_id = 1
    GROUP BY cat_nombre;
END$$

DELIMITER ;

call fpulpas.ESTFrutas();


DELIMITER $$

CREATE PROCEDURE ESTProv()
BEGIN
    SELECT COUNT(*) AS cantidad_proveedores
    FROM proveedores;
END$$

DELIMITER ;

call fpulpas.ESTProv();

DELIMITER $$

CREATE PROCEDURE ESTPresent()
BEGIN
    SELECT COUNT(*) AS cantidad_presentaciones
    FROM presentacion; 
END$$

DELIMITER ;

call fpulpas.ESTPresent();


DELIMITER $$

CREATE PROCEDURE ESTManoObra()
BEGIN
    SELECT COUNT(*) AS cantidad_mano_obra
    FROM catalogo
    WHERE ctg_id = 4;
END$$

DELIMITER ;

call fpulpas.ESTManoObra();

SELECT cat_id FROM catalogo WHERE ctg_id = 4;

DELIMITER $$

CREATE PROCEDURE ESTCostosInd()
BEGIN
    SELECT COUNT(*) AS cantidad_costos_indirectos
    FROM catalogo
    WHERE ctg_id = 5;
END$$

DELIMITER ;

CALL ESTCostosInd();

 