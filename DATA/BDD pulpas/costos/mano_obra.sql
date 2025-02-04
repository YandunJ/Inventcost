CREATE VIEW vista_inventario_general AS
SELECT 
    i.id_inv AS id_inventario,
    c.cat_nombre AS producto,
    ct.ctg_nombre AS categoria,
    i.cant_restante AS stock_restante,
    i.estado AS estado
FROM inventario i
JOIN catalogo c ON i.cat_id = c.cat_id
JOIN categorias ct ON c.ctg_id = ct.ctg_id;


SELECT * FROM fpulpas.vista_inventario_general;

SELECT * FROM vista_inventario_general WHERE categoria = 'Insumos' AND estado = 'disponible';


CREATE VIEW vista_inventario_detallada AS
SELECT 
    i.id_inv AS id_inventario,
    c.cat_nombre AS producto,
    ct.ctg_nombre AS categoria,
    i.lote,
    i.presentacion,
    i.cant_ingresada AS cantidad_ingresada,
    i.cant_restante AS cantidad_restante,
    i.estado AS estado,
    i.fecha_elaboracion,
    i.fecha_caducidad,
    i.observacion
FROM inventario i
JOIN catalogo c ON i.cat_id = c.cat_id
JOIN categorias ct ON c.ctg_id = ct.ctg_id;


SELECT * FROM vista_inventario_detallada;

SELECT * FROM vista_inventario_detallada WHERE estado = 'disponible';

SELECT * FROM vista_inventario_detallada WHERE categoria = 'Insumos';


CREATE OR REPLACE VIEW vista_kardex AS
SELECT 
    i.id_inv AS id_inventario,
    c.cat_nombre AS producto,
    ct.ctg_nombre AS categoria,
    i.lote,
    i.presentacion,
    i.cant_ingresada AS entradas,
    i.cant_restante AS saldo,
    (i.cant_ingresada - i.cant_restante) AS salidas,
    i.estado AS estado,
    i.fecha_hora AS fecha_movimiento
FROM inventario i
JOIN catalogo c ON i.cat_id = c.cat_id
JOIN categorias ct ON c.ctg_id = ct.ctg_id;

SELECT * FROM fpulpas.vista_kardex;
