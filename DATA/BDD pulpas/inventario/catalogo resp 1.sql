SELECT * FROM fpulpas.invent_catalogo;

CREATE TABLE invent_catalogo (
    id_articulo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_articulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_categoria INT,
    
    uni_id INT NOT NULL,
    estado ENUM('disponible', 'stock bajo', 'agotado') DEFAULT 'disponible',
    fecha_creacion DATE NOT NULL,	
    stock INT DEFAULT 0,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    
    FOREIGN KEY (uni_id) REFERENCES unidades_medida(uni_id)
);


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Catalogo_CRUD`(
    IN p_opcion INT, -- Nuevo parámetro
    IN p_id_articulo INT,
    IN p_nombre_articulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_id_categoria INT,
    IN p_uni_id INT
)
BEGIN
    -- Declaración de la variable antes del bloque IF
    DECLARE articulo_existente INT;

    -- Validar si el artículo ya existe
    IF p_opcion = 1 THEN
        -- Verificar si ya existe el artículo con el mismo nombre y unidad
        SELECT COUNT(*) INTO articulo_existente
        FROM invent_catalogo
        WHERE nombre_articulo = p_nombre_articulo
        AND uni_id = p_uni_id;

        IF articulo_existente > 0 THEN
            -- Si el artículo ya existe, no lo inserta
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El artículo ya está registrado con esta unidad.';
        ELSE
            -- Inserción de un nuevo registro
            INSERT INTO invent_catalogo (nombre_articulo, descripcion, id_categoria, uni_id, fecha_creacion)
            VALUES (p_nombre_articulo, p_descripcion, p_id_categoria, p_uni_id, CURDATE());
        END IF;

    ELSEIF p_opcion = 2 THEN
        -- Actualización de un registro existente
        UPDATE invent_catalogo
        SET nombre_articulo = p_nombre_articulo,
            descripcion = p_descripcion,
            id_categoria = p_id_categoria,
            uni_id = p_uni_id
        WHERE id_articulo = p_id_articulo;
    END IF;
END$$
DELIMITER ;


CALL Catalogo_CRUD(1, 0, 'Pera', 'Descripción de Pera', 1, 2);

CALL Catalogo_CRUD(2, 1, 'Pera Actualizada', 'Descripción actualizada de Pera', 2, 3);


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Catalogo_data`()
BEGIN
    SELECT 
        ic.id_articulo, 
        ic.nombre_articulo, 
        ic.descripcion, 
        c.nombre_categoria AS categoria, 
        um.uni_nombre AS unidad_medida, 
        ic.estado, 
        ic.fecha_creacion, 
        ic.stock
    FROM invent_catalogo ic
    INNER JOIN categorias c ON ic.id_categoria = c.id_categoria
    INNER JOIN unidades_medida um ON ic.uni_id = um.uni_id;
END$$
DELIMITER ;

call fpulpas.Catalogo_data();


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Catalogo_data_id`(IN p_id_articulo INT)
BEGIN
    SELECT * FROM invent_catalogo WHERE id_articulo = p_id_articulo;
END$$
DELIMITER ;

call fpulpas.Catalogo_data_id(1);

