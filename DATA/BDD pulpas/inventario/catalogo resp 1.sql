SELECT * FROM fpulpas.catalogo;

CREATE TABLE catalogo (
    cat_id INT AUTO_INCREMENT PRIMARY KEY,
    cat_nombre VARCHAR(100) NOT NULL,
    ctg_id INT NOT NULL, -- Campo para clave foránea hacia `categorias.ctg_id`
    prs_id INT NOT NULL,       -- Campo para clave foránea hacia `presentacion.prs_id`
    cat_estado ENUM('disponible', 'stock bajo', 'agotado') DEFAULT 'disponible',
    cat_fecha_creacion DATE NOT NULL,
    cat_stock INT DEFAULT 0,
    FOREIGN KEY (ctg_id) REFERENCES categorias(ctg_id),
    FOREIGN KEY (prs_id) REFERENCES presentacion(prs_id)
);

DELIMITER $$
CREATE PROCEDURE Catalogo_CRUD(
    IN p_opcion INT,
    IN p_cat_id INT,
    IN p_cat_nombre VARCHAR(100),
    IN p_ctg_id INT,
    IN p_prs_id INT
)
BEGIN
    DECLARE articulo_existente INT;

    IF p_opcion = 1 THEN
        SELECT COUNT(*) INTO articulo_existente
        FROM catalogo
        WHERE cat_nombre = p_cat_nombre AND prs_id = p_prs_id;

        IF articulo_existente > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El artículo ya está registrado con esta presentación.';
        ELSE
            INSERT INTO catalogo (cat_nombre, ctg_id, prs_id, cat_fecha_creacion)
            VALUES (p_cat_nombre, p_ctg_id, p_prs_id, CURDATE());
        END IF;

    ELSEIF p_opcion = 2 THEN
        UPDATE catalogo
        SET cat_nombre = p_cat_nombre,
            ctg_id = p_ctg_id,
            prs_id = p_prs_id
        WHERE cat_id = p_cat_id;
    END IF;
END$$
DELIMITER ;


CALL Catalogo_CRUD(1, 0, 'Pera', 1, 2);

CALL Catalogo_CRUD(2, 1, 'Pera Actualizada', 2, 3);

DELIMITER $$
CREATE PROCEDURE Catalogo_data()
BEGIN
    SELECT 
        cat.cat_id,
        cat.cat_nombre,
        cat.cat_estado,
        cat.cat_fecha_creacion,
        cat.cat_stock,
        c.ctg_nombre AS categoria,
        p.prs_nombre AS presentacion
    FROM catalogo cat
    INNER JOIN categorias c ON cat.ctg_id = c.ctg_id
    INNER JOIN presentacion p ON cat.prs_id = p.prs_id;
END$$
DELIMITER ;

call fpulpas.Catalogo_data();

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Catalogo_data_id`(IN p_cat_id INT)
BEGIN
    SELECT 
        cat_id AS id_articulo,
        cat_nombre AS nombre_articulo,
        ctg_id,
        prs_id
    FROM catalogo
    WHERE cat_id = p_cat_id;
END$$
DELIMITER ;


call fpulpas.Catalogo_data_id(1);