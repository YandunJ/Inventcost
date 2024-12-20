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
    estado ENUM('disponible', 'stock bajo' , 'agotado') NOT NULL DEFAULT 'disponible', -- Valor predeterminado

    -- Claves foráneas
    FOREIGN KEY (id_articulo) REFERENCES invent_catalogo(id_articulo),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id)
);

DELIMITER //

CREATE PROCEDURE Obt_INS_por_id(IN p_inventins_id INT)
BEGIN
    SELECT 
        id_inv, 
        fecha, 
        hora, 
        id_articulo, 
        proveedor_id, 
        numero_lote, 
        unidad_medida, 
        cantidad_ingresada, 
        presentacion, 
        unidad_medida,
        precio_unitario, 
        precio_total
    FROM 
        inventario
    WHERE 
        id_inv = p_inventins_id;
END //

DELIMITER ;

call fpulpas.Obt_INS_por_id(1);



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `acc_Invent_MP`(
    IN p_id_inv INT,                -- Para identificar si se registra o actualiza
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_unidad_medida VARCHAR(20),             -- Unidad de medida (será 'kg' si no se proporciona)
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_cantidad_restante DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_estado ENUM('disponible', 'stock bajo', 'agotado'), -- Estado inicial (será 'disponible' si no se proporciona)
    IN p_bultos_o_canastas INT,                 -- Campos específicos de invent_detalle_MP
    IN p_peso_unitario DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_observacion TEXT,
    IN p_decision ENUM('aprobado', 'no aprobado') -- Estado de aprobación inicial (será 'no aprobado' si no se proporciona)
)
BEGIN
    DECLARE v_id_inv INT;

    -- Asignación de valores predeterminados para los campos opcionales
    SET p_unidad_medida = IFNULL(p_unidad_medida, 'kg');
    SET p_estado = IFNULL(p_estado, 'disponible');
    SET p_decision = IFNULL(p_decision, 'no aprobado');

    IF p_id_inv IS NULL THEN
        -- Inserción en la tabla inventario
        INSERT INTO inventario (
            fecha, hora, id_articulo, proveedor_id, numero_lote, 
            unidad_medida, cantidad_ingresada, cantidad_restante, 
            precio_unitario, presentacion, estado
        ) VALUES (
            p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote, 
            p_unidad_medida, p_cantidad_ingresada, p_cantidad_restante, 
            p_precio_unitario, p_presentacion, p_estado
        );

        -- Capturar el id generado
        SET v_id_inv = LAST_INSERT_ID();

        -- Inserción en la tabla invent_detalle_MP
        INSERT INTO invent_detalle_MP (
            id_inv, bultos_o_canastas, peso_unitario, brix, observacion, decision
        ) VALUES (
            v_id_inv, p_bultos_o_canastas, p_peso_unitario, p_brix, p_observacion, p_decision
        );

    ELSE
        -- Actualización en la tabla inventario
        UPDATE inventario
        SET
            fecha = p_fecha,
            hora = p_hora,
            id_articulo = p_id_articulo,
            proveedor_id = p_proveedor_id,
            numero_lote = p_numero_lote,
            unidad_medida = p_unidad_medida,
            cantidad_ingresada = p_cantidad_ingresada,
            cantidad_restante = p_cantidad_restante,
            precio_unitario = p_precio_unitario,
            presentacion = p_presentacion,
            estado = p_estado
        WHERE id_inv = p_id_inv;

        -- Actualización en la tabla invent_detalle_MP
        UPDATE invent_detalle_MP
        SET
            bultos_o_canastas = p_bultos_o_canastas,
            peso_unitario = p_peso_unitario,
            brix = p_brix,
            observacion = p_observacion,
            decision = p_decision
        WHERE id_inv = p_id_inv;

    END IF;
END$$
DELIMITER ;

DELIMITER //

CREATE PROCEDURE ac_ActualizarINS(
    IN p_id_inv INT,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10,2),
    IN p_presentacion VARCHAR(50),
    IN p_precio_unitario DECIMAL(10,2)
)
BEGIN
    UPDATE inventario
    SET
        id_articulo = p_id_articulo,
        proveedor_id = p_proveedor_id,
        fecha = p_fecha,
        hora = p_hora,
        numero_lote = p_numero_lote,
        cantidad_ingresada = p_cantidad_ingresada,
        presentacion = p_presentacion,
        precio_unitario = p_precio_unitario
    WHERE id_inv = p_id_inv;
END //

DELIMITER ;


DELIMITER //
CREATE PROCEDURE ac_InsertarINS(
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_precio_unitario DECIMAL(10, 2)
)
BEGIN
    DECLARE v_unidad_medida VARCHAR(20);

    -- Obtener la unidad de medida desde invent_catalogo basado en el id_articulo
    SELECT unidad_medida INTO v_unidad_medida
    FROM invent_catalogo
    WHERE id_articulo = p_id_articulo;

    -- Insertar el nuevo registro en la tabla inventario
    INSERT INTO inventario (
        fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida,
        cantidad_ingresada, cantidad_restante, precio_unitario, presentacion, estado
    )
    VALUES (
        p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote, v_unidad_medida,
        p_cantidad_ingresada, p_cantidad_ingresada, p_precio_unitario, p_presentacion, 'disponible'
    );
END//
DELIMITER ;

call fpulpas.ac_InsertarINS(9, 1, '2023-11-24', '10:20:00', 'nada', 12, 'cajas', 12);

INSERT INTO inventario (fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida, cantidad_ingresada, cantidad_restante, precio_unitario, presentacion)
VALUES 
('2023-11-24', '10:30:00', 4, 3, 'LOT231124', 'unidades', 100.00, 100.00, 15.50, 'Caja de 10kg');


call fpulpas.sp_Obt_inven_MP();


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


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ac_InsertarINS`(
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_unidad_medida VARCHAR(20)
)
BEGIN
    -- Inserción de un nuevo registro
    INSERT INTO inventario (
        fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida,
        cantidad_ingresada, cantidad_restante, precio_unitario, precio_total, presentacion, estado
    )
    VALUES (
        p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote, p_unidad_medida,
        p_cantidad_ingresada, p_cantidad_ingresada, p_precio_unitario,
        p_cantidad_ingresada * p_precio_unitario, p_presentacion, 'disponible'
    );
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarINS`(
    IN p_id_inv INT, -- ID del inventario a actualizar
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_unidad_medida VARCHAR(20)
)
BEGIN
    -- Actualización de un registro existente
    UPDATE inventario
    SET 
        fecha = p_fecha,
        hora = p_hora,
        id_articulo = p_id_articulo,
        proveedor_id = p_proveedor_id,
        numero_lote = p_numero_lote,
        unidad_medida = p_unidad_medida,
        cantidad_ingresada = p_cantidad_ingresada,
        cantidad_restante = p_cantidad_ingresada,
        precio_unitario = p_precio_unitario,
        precio_total = p_cantidad_ingresada * p_precio_unitario,
        presentacion = p_presentacion
    WHERE id_inv = p_id_inv;
END$$
DELIMITER ;

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

call fpulpas.sp_Obt_inven_MP();

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ac_InsertarINS`(
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_unidad_medida VARCHAR(20)
)
BEGIN
    -- Inserción de un nuevo registro
    INSERT INTO inventario (
        fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida,
        cantidad_ingresada, cantidad_restante, precio_unitario, presentacion, estado
    )
    VALUES (
        p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote, p_unidad_medida,
        p_cantidad_ingresada, p_cantidad_ingresada, p_precio_unitario, p_presentacion, 'disponible'
    );
END$$
DELIMITER ;


