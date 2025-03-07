SELECT * FROM fpulpas.presentacion;

CREATE TABLE `presentacion` (
  `prs_id` int NOT NULL AUTO_INCREMENT,
  `prs_nombre` varchar(50) NOT NULL,
  `prs_abreviacion` varchar(10) DEFAULT NULL,
  `prs_estado` enum('vigente','descontinuado') NOT NULL DEFAULT 'vigente',
  `ctg_id` int DEFAULT NULL,
  `equivalencia` int DEFAULT NULL,
  PRIMARY KEY (`prs_id`),
  KEY `fk_categoria` (`ctg_id`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`ctg_id`) REFERENCES `categorias` (`ctg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 
INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado) VALUES
('Kilogramos', 'kg', 'vigente'),
('Litros', 'lt', 'vigente'),
('Unidades', 'u', 'vigente');


DELIMITER //
CREATE PROCEDURE UM_CRUD(
    IN p_opcion INT,
    IN p_prs_id INT,
    IN p_prs_nombre VARCHAR(50),
    IN p_prs_abreviacion VARCHAR(10),
    IN p_prs_estado ENUM('vigente', 'descontinuado'),
    IN p_ctg_id INT,
    IN p_equivalencia INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error ejecutando UM_CRUD';
    END;

    START TRANSACTION;

    IF p_opcion = 1 THEN
        IF p_ctg_id = 3 THEN
            INSERT INTO presentacion (prs_nombre, prs_estado, ctg_id, equivalencia)
            VALUES (p_prs_nombre, p_prs_estado, p_ctg_id, p_equivalencia);
        ELSE
            INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia)
            VALUES (p_prs_nombre, p_prs_abreviacion, p_prs_estado, p_ctg_id, p_equivalencia);
        END IF;
    ELSEIF p_opcion = 2 THEN
        IF p_ctg_id = 3 THEN
            UPDATE presentacion
            SET prs_nombre = p_prs_nombre,
                prs_estado = p_prs_estado,
                ctg_id = p_ctg_id,
                equivalencia = p_equivalencia
            WHERE prs_id = p_prs_id;
        ELSE
            UPDATE presentacion
            SET prs_nombre = p_prs_nombre,
                prs_abreviacion = p_prs_abreviacion,
                prs_estado = p_prs_estado,
                ctg_id = p_ctg_id,
                equivalencia = p_equivalencia
            WHERE prs_id = p_prs_id;
        END IF;
    END IF;

    COMMIT;

    -- Devuelve un mensaje de éxito
    SELECT 'Success' AS message;
END //
DELIMITER ;

-- REGISTRO 
CALL UM_CRUD(1, 0, '1 kg', '', 'vigente', 3, 1000); 	

CALL UM_CRUD(1, 0, '1 kg', '1KG', 'vigente', 1, 1000);

-- ACTUALIZACION
CALL UM_CRUD(2, 14, '1 kg actualizado', '', 'vigente', 3, 1500);

CALL UM_CRUD(2, 1, '1 kg actualizado', '1KG actualizado', 'vigente', 1, 1500);


CALL UM_CRUD(
    1, -- Opción 1 para registrar
    0, -- ID de la presentación (no se usa en registro)
    '1 kg', -- Nombre de la presentación
    '', -- Abreviación (valor vacío para Producto Terminado)
    'vigente', -- Estado
    3, -- ID de la categoría (Producto Terminado)
    1000 -- Equivalencia en gramos
);

CALL UM_CRUD(
    2, -- Opción 2 para actualizar
    4, -- ID de la presentación a actualizar
    '2 kg', -- Nombre de la presentación
    'kg', -- Abreviación
    'vigente', -- Estado
    3, -- ID de la categoría (Producto Terminado)
    2000 -- Equivalencia en gramos
);


DELIMITER //

CREATE PROCEDURE UM_data_id(
    IN p_prs_id INT
)
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia
    FROM presentacion
    WHERE prs_id = p_prs_id;
END //

DELIMITER ;
call fpulpas.UM_data_id(1);


DELIMITER //

CREATE PROCEDURE `UM_data_ins`()
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia
    FROM presentacion
    WHERE ctg_id = 2;
END //

DELIMITER ;
call fpulpas.UM_data_ins();
ALTER TABLE presentacion MODIFY prs_abreviacion VARCHAR(250) NULL;


DELIMITER //
CREATE PROCEDURE `UM_CRUD_ins`(
    IN `p_opcion` INT,
    IN `p_prs_id` INT,
    IN `p_prs_nombre` VARCHAR(50),
    IN `p_prs_abreviacion` VARCHAR(10)
)
BEGIN
    IF p_opcion = 1 THEN
        -- Insertar nueva presentación de insumo
        INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado, ctg_id)
        VALUES (p_prs_nombre, p_prs_abreviacion, 'vigente', 2);
    ELSEIF p_opcion = 2 THEN
        -- Actualizar presentación de insumo existente
        UPDATE presentacion
        SET prs_nombre = p_prs_nombre,
            prs_abreviacion = p_prs_abreviacion
        WHERE prs_id = p_prs_id AND ctg_id = 2;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE `UM_data_id_ins`(
    IN `p_prs_id` INT
)
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion
    FROM presentacion
    WHERE prs_id = p_prs_id AND ctg_id = 2;
END //
DELIMITER ;
call fpulpas.UM_data_id_ins(2);