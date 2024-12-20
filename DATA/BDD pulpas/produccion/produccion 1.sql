SELECT * FROM fpulpas.produccion;

CREATE TABLE produccion (
    id_produccion INT NOT NULL AUTO_INCREMENT,   -- Clave primaria autoincremental
    fecha_produccion DATE NOT NULL,             -- Fecha de la producción
    cantidad_producida DECIMAL(10,2) NULL,      -- Cantidad total producida (puede ser nula)
    estado VARCHAR(20) DEFAULT 'en proceso',    -- Estado de la producción
    subt_MtPm DECIMAL(10,2) DEFAULT '0.00',     -- Subtotal de materia prima
    subt_MnOb DECIMAL(10,2) DEFAULT '0.00',     -- Subtotal de mano de obra
    subt_Ins DECIMAL(10,2) DEFAULT '0.00',      -- Subtotal de insumos
    subt_otros_costos DECIMAL(10,2) DEFAULT '0.00', -- Otros costos
    total_produccion DECIMAL(10,2) DEFAULT '0.00',  -- Total de producción
    PRIMARY KEY (id_produccion)
);



-- Registro de producción
INSERT INTO produccion (fecha_produccion, cantidad_producida, estado)
VALUES ('2024-10-20', 500.00, 'en proceso');

INSERT INTO produccion (fecha_produccion, cantidad_producida, estado)
VALUES ('2024-10-20', 500.00, 'en proceso'); -- Esta producción está produciendo 500 unidades

DELIMITER $$

CREATE PROCEDURE Consumo_inv (
    IN p_id_inv INT,            -- ID del inventario (lote a consumir)
    IN p_cantidad_usada DECIMAL(10,2),  -- Cantidad a consumir
    OUT p_mensaje VARCHAR(255) -- Mensaje de salida
)
BEGIN
    DECLARE v_cantidad_restante DECIMAL(10,2); -- Variable para verificar el stock
    DECLARE v_id_produccion INT;               -- Variable para una referencia de producción automática

    -- Etiqueta para el bloque
    sp_label: BEGIN
        -- Verificar existencia del lote y cantidad suficiente
        SELECT cantidad_restante
        INTO v_cantidad_restante
        FROM inventario
        WHERE id_inv = p_id_inv AND estado = 'disponible';

        IF v_cantidad_restante IS NULL THEN
            SET p_mensaje = 'Lote no encontrado o no disponible.';
            LEAVE sp_label;
        END IF;

        IF v_cantidad_restante < p_cantidad_usada THEN
            SET p_mensaje = 'Cantidad insuficiente en el lote.';
            LEAVE sp_label;
        END IF;

        -- Generar un registro de producción genérico si es necesario
        INSERT INTO produccion (fecha_produccion, estado)
        VALUES (CURDATE(), 'consumo registrado');
        SET v_id_produccion = LAST_INSERT_ID();

        -- Registrar el consumo en prod_detalle
        INSERT INTO prod_detalle (
            id_produccion, id_inv, cantidad_usada, cantidad_desperdiciada, cantidad_producida
        )
        VALUES (
            v_id_produccion, p_id_inv, p_cantidad_usada, 0, 0
        );

        -- Actualizar cantidad restante en inventario
        UPDATE inventario
        SET cantidad_restante = cantidad_restante - p_cantidad_usada
        WHERE id_inv = p_id_inv;

        -- Mensaje de éxito
        SET p_mensaje = CONCAT('Consumo registrado en producción ID ', v_id_produccion, ' y stock actualizado correctamente.');
    END sp_label;
END$$

DELIMITER ;


CALL Consumo_inv(1, 5.00, @mensaje);
SELECT @mensaje AS Resultado;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Obt_inven_MP`()
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.numero_lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Artículo,
        inv.unidad_medida AS unidad_medida,
        inv.cantidad_ingresada AS cantidad_ingresada, 
        inv.cantidad_restante AS Cantidad_Disponible,
        inv.precio_unitario AS precio_unitario,
        inv.precio_total AS Precio_Total,
        inv.estado AS Estado
         -- o inv.precio_unitario si prefieres
    FROM 
        inventario inv
    JOIN 
        proveedores prov ON inv.proveedor_id = prov.proveedor_id
    JOIN 
        invent_catalogo cat ON inv.id_articulo = cat.id_articulo
    WHERE 
        cat.id_categoria = 1; -- Filtra solo los registros de Materia Prima
END$$
DELIMITER ;
