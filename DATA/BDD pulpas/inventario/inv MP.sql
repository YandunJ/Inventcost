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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Obt_inven_MP`()
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.fecha AS Fecha,
        inv.hora AS Hora,
        inv.numero_lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Artículo,
        inv.cantidad_restante AS Cantidad_Disponible,
        inv.estado AS Estado,
        inv.precio_total AS Precio_Total  -- o inv.precio_unitario si prefieres
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


DELIMITER //
CREATE PROCEDURE acc_Invent_MP (
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
END//
DELIMITER ;


CALL ac_InsertarMP(
    '2024-11-05',             -- Fecha de ingreso
    '12:30:00',               -- Hora de ingreso
    1,                        -- ID de artículo (fruta)
    2,                        -- ID del proveedor
    'L12345',                 -- Número de lote
    100.00,                   -- Cantidad ingresada en kg
    1.50,                     -- Precio unitario
    'cajas',                  -- Presentación
    10,                       -- Bultos o canastas
    1.00,                     -- Peso unitario de cada bulto o canasta en kg
    12.5,                     -- Brix
    'Fruta fresca, buen estado' -- Observaciones
);
--  !!!!!!!!!!!!!!!!!!!!! actulizar un regsitro de iventario !!!!!!!!!!!!!!!!!!!!!!!
DELIMITER //
CREATE PROCEDURE ActualizarMP (
    IN p_id_inv INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10,2),
    IN p_precio_unitario DECIMAL(10,2),
    IN p_presentacion VARCHAR(50),
    IN p_brix DECIMAL(5,2),
    IN p_bultos_o_canastas INT,
    IN p_peso_unitario DECIMAL(10,2),
    IN p_observacion TEXT
)
BEGIN
    -- Actualizar tabla inventario con los campos en el mismo orden del formulario
    UPDATE inventario
    SET 
        fecha = p_fecha,
        hora = p_hora,
        id_articulo = p_id_articulo,
        proveedor_id = p_proveedor_id,
        numero_lote = p_numero_lote,
        cantidad_ingresada = p_cantidad_ingresada,
        precio_unitario = p_precio_unitario,
        presentacion = p_presentacion
    WHERE id_inv = p_id_inv;
    
    -- Actualizar tabla invent_detalle_mp con los campos en el mismo orden del formulario
    UPDATE invent_detalle_mp
    SET 
        brix = p_brix,
        bultos_o_canastas = p_bultos_o_canastas,
        peso_unitario = p_peso_unitario,
        observacion = p_observacion
    WHERE id_inv = p_id_inv;
END//
DELIMITER ;


	
--  OBTENER POR ID MP  !!!!!!!!!!!!!!!!!!!!!!!
DELIMITER //
CREATE PROCEDURE Obt_MP_por_id(
    IN p_id_inv INT
)
BEGIN
    SELECT 
        i.id_inv,
        i.fecha,
        i.hora,
        i.id_articulo,
        i.proveedor_id,
        i.numero_lote,
        i.cantidad_ingresada,
        i.precio_unitario,
        i.presentacion,
        d.brix,
        d.bultos_o_canastas,
        d.peso_unitario,
        d.observacion
    FROM inventario i
    JOIN invent_detalle_mp d ON i.id_inv = d.id_inv
    WHERE i.id_inv = p_id_inv;
END//
DELIMITER ;


call fpulpas.Obt_MP_por_id(1);


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ac_InsertarMP`(
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_bultos_o_canastas INT,
    IN p_peso_unitario DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_observacion TEXT
)
BEGIN
    DECLARE v_id_inv INT;

    -- Inicio de la transacción
    START TRANSACTION;

    -- Inserción en la tabla inventario (sin `precio_total` ya que es una columna generada)
    INSERT INTO inventario (
        fecha, hora, id_articulo, proveedor_id, numero_lote,
        cantidad_ingresada, cantidad_restante, 
        precio_unitario, presentacion
    ) VALUES (
        p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote,
        p_cantidad_ingresada, p_cantidad_ingresada, -- `cantidad_restante` inicial
        p_precio_unitario, p_presentacion
    );

    -- Obtener el último ID insertado en inventario
    SET v_id_inv = LAST_INSERT_ID();

    -- Inserción en la tabla invent_detalle_MP
    INSERT INTO invent_detalle_MP (
        id_inv, bultos_o_canastas, peso_unitario, 
        brix, observacion
    ) VALUES (
        v_id_inv, p_bultos_o_canastas, p_peso_unitario, 
        p_brix, p_observacion
    );

    -- Confirmación de la transacción
    COMMIT;
END$$
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ac_InsertarInsumo (
    IN fecha_in DATE,
    IN hora_in TIME,
    IN id_articulo_in INT,
    IN proveedor_id_in INT,
    IN numero_lote_in VARCHAR(50),
    IN unidad_medida_in VARCHAR(20), -- Permite cualquier valor especificado
    IN cantidad_ingresada_in DECIMAL(10, 2),
    IN precio_unitario_in DECIMAL(10, 2),
    IN presentacion_in VARCHAR(50),
    IN estado_in ENUM('disponible', 'stock bajo', 'agotado')
)
BEGIN
    INSERT INTO inventario (
        fecha,
        hora,
        id_articulo,
        proveedor_id,
        numero_lote,
        unidad_medida,
        cantidad_ingresada,
        cantidad_restante,
        precio_unitario,
        presentacion,
        estado
    )
    VALUES (
        fecha_in,
        hora_in,
        id_articulo_in,
        proveedor_id_in,
        numero_lote_in,
        unidad_medida_in, -- Toma el valor pasado sin usar el predeterminado
        cantidad_ingresada_in,
        cantidad_ingresada_in, -- Asignar cantidad_restante como igual a cantidad_ingresada
        precio_unitario_in,
        presentacion_in,
        estado_in
    );
END //
DELIMITER ;


CALL ac_InsertarInsumo(
    '2024-11-13',       -- fecha_in
    '15:30:00',         -- hora_in
    3,                  -- id_articulo_in
    2,                  -- proveedor_id_in
    'INS12345',         -- numero_lote_in
    'unidad',                -- unidad_medida_in (unidad para este insumo)
    100,                -- cantidad_ingresada_in
    5.00,               -- precio_unitario_in
    'Caja',             -- presentacion_in
    'disponible'        -- estado_in
);


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Obt_inven_MP`()
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.fecha AS Fecha,
        inv.hora AS Hora,
        inv.numero_lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Artículo,
        inv.cantidad_restante AS Cantidad_Disponible,
        inv.estado AS Estado,
        inv.precio_total AS Precio_Total  -- o inv.precio_unitario si prefieres
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
