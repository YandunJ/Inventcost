SELECT * FROM fpulpas.categorias;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_registro DATE NOT NULL
);

INSERT INTO categorias (nombre_categoria, descripcion, fecha_registro)
VALUES
('Materia Prima', 'Frutas para almacenamiento y uso en producción', '2024-10-05'),
('Insumos', 'Materiales utilizados en la producción', '2024-10-05'),
('Productos Terminado', 'Paquetes de Pulpa Procesada', '2024-10-05');


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

CREATE PROCEDURE sp_generar_lote (
    IN categoria CHAR(3), -- MP, INS, PT
    OUT numero_lote VARCHAR(20)
)
BEGIN
    DECLARE prefijo VARCHAR(5);
    DECLARE fecha VARCHAR(6);
    DECLARE consecutivo INT;

    -- Determinar el prefijo según la categoría
    CASE categoria
        WHEN 'MP' THEN SET prefijo = 'MP_';
        WHEN 'INS' THEN SET prefijo = 'INS_';
        WHEN 'PT' THEN SET prefijo = 'PT_';
        ELSE SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Categoría no válida';
    END CASE;

    -- Fecha en formato DDMMAA
    SET fecha = DATE_FORMAT(NOW(), '%d%m%y');

    -- Obtener el consecutivo
    SELECT COUNT(*) + 1
    INTO consecutivo
    FROM inventario
    WHERE numero_lote LIKE CONCAT(prefijo, fecha, '%');

    -- Construir el número de lote
    SET numero_lote = CONCAT(prefijo, fecha, consecutivo);
END //

DELIMITER ;
