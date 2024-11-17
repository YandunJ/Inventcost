SELECT * FROM fpulpas.inventario;

CREATE TABLE inventario (
    id_inv INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    id_articulo INT NOT NULL, -- Relación con la tabla invent_catalogo
    proveedor_id INT NOT NULL, -- Relación con la tabla proveedores
    numero_lote VARCHAR(50) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL DEFAULT 'kg', -- Valor predeterminado
    cantidad_ingresada DECIMAL(10, 2) NOT NULL,
    cantidad_restante DECIMAL(10, 2) NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    precio_total DECIMAL(10, 2) GENERATED ALWAYS AS (cantidad_restante * precio_unitario) STORED,
    presentacion VARCHAR(50) NOT NULL, -- Valor predeterminado
    estado ENUM('disponible', 'stock bajo', 'agotado') NOT NULL DEFAULT 'disponible', -- Valor predeterminado

    -- Claves foráneas
    FOREIGN KEY (id_articulo) REFERENCES invent_catalogo(id_articulo),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id)
);

INSERT INTO inventario (fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida, cantidad_ingresada, cantidad_restante, precio_unitario, presentacion, estado)
VALUES 
('2023-11-24', '10:30:00', 4, 3, 'LOT231124', 'unidades', 100.00, 100.00, 15.50, 'Caja de 10kg', 'disponible');


call fpulpas.sp_Obt_inven_MP();


DELIMITER //

CREATE PROCEDURE sp_Obt_inven_INS()
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.fecha AS Fecha,
        inv.hora AS Hora,
        inv.numero_lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Insumo,
        inv.unidad_medida AS Unidad_Medida,
        inv.cantidad_ingresada AS Cantidad,
        inv.cantidad_restante AS Cantidad_Restante,
        inv.precio_unitario AS Precio_Unitario,
        inv.precio_total AS Precio_Total,
        inv.presentacion AS Presentacion,
        inv.estado AS Estado
    FROM 
        inventario inv
    JOIN 
        proveedores prov ON inv.proveedor_id = prov.proveedor_id
    JOIN 
        invent_catalogo cat ON inv.id_articulo = cat.id_articulo
    WHERE 
        cat.id_categoria = 2; -- Filtra solo los registros de Insumos
END//

DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarRegistroMP`(IN p_id_inv INT)
BEGIN
    -- Primero eliminar el registro relacionado en invent_detalle_MP si existe
    DELETE FROM invent_detalle_MP
    WHERE id_inv = p_id_inv;

    -- Luego eliminar el registro principal en inventario
    DELETE FROM inventario
    WHERE id_inv = p_id_inv;
END$$
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_EliminarINS(IN p_id_inv INT)
BEGIN

    DELETE FROM inventario
    WHERE id_inv = p_id_inv;
END//
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `elim_invCatalogo`(IN p_id_articulo INT)
BEGIN
    DELETE FROM invent_catalogo WHERE id_articulo = p_id_articulo;
END$$
DELIMITER ;





