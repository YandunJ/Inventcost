SELECT * FROM fpulpas.invent_detalle_mp;

CREATE TABLE invent_detalle_MP (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_inv INT,
    bultos_o_canastas INT,                   -- Cantidad de bultos o canastas
    peso_unitario DECIMAL(10, 2),            -- Peso unitario en kg de cada bulto o canasta
    brix DECIMAL(5, 2),
    observacion TEXT,
    decision ENUM('aprobado', 'no aprobado') DEFAULT 'no aprobado', -- Estado de aprobación del lote
    FOREIGN KEY (id_inv) REFERENCES inventario(id_inv)
);

CREATE TABLE invent_detalle_MP (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_inv INT,
    bultos_o_canastas INT,                    -- Valor predeterminado
    peso_unitario DECIMAL(10, 2),          -- Valor predeterminado
    brix DECIMAL(5, 2),                     -- Valor predeterminado
    observacion TEXT,       -- Valor predeterminado
    decision ENUM('aprobado', 'no aprobado') DEFAULT 'aprobado', -- Valor predeterminado

    FOREIGN KEY (id_inv) REFERENCES inventario(id_inv)
);

INSERT INTO invent_detalle_MP 
(id_detalle, id_inv, bultos_canastas, peso_unitario, brix, observaciones)
VALUES 
(LAST_INSERT_ID(), 50, 10.0, 14.5, 'Calidad óptima');


DELIMITER //

CREATE PROCEDURE sp_DetalleLote(IN lote_id INT)
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.fecha AS Fecha,
        inv.hora AS Hora,
        inv.numero_lote AS Numero_Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Artículo,
        inv.cantidad_ingresada AS Cantidad_Ingresada,
        inv.cantidad_restante AS Cantidad_Restante,
        inv.unidad_medida AS Unidad_Medida,
        inv.presentacion AS Presentación,
        inv.estado AS Estado,
        inv.precio_unitario AS Precio_Unitario,
        inv.precio_total AS Precio_Total,
        det.bultos_o_canastas AS Bultos_Canastas,
        det.peso_unitario AS Peso_Unitario,
        det.brix AS Brix,
        det.observacion AS Observación,
        det.decision AS Aprobación
    FROM 
        inventario inv
    JOIN 
        proveedores prov ON inv.proveedor_id = prov.proveedor_id
    JOIN 
        invent_catalogo cat ON inv.id_articulo = cat.id_articulo
    LEFT JOIN 
        invent_detalle_MP det ON inv.id_inv = det.id_inv
    WHERE 
        inv.id_inv = lote_id;
END //

DELIMITER ;

call fpulpas.sp_DetalleLote(1);


SELECT COUNT(*) FROM inventario WHERE numero_lote = 'L12345';