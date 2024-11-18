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

CREATE PROCEDURE ObtINS_por_id(IN p_inventins_id INT)
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
        precio_unitario, 
        precio_total
    FROM 
        inventario
    WHERE 
        id_inv = p_inventins_id;
END //

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



`fpulpas`.`ac_InsertarInsumo`




