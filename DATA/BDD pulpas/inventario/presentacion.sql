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



DELIMITER //

CREATE PROCEDURE `UM_data_pt`()
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia
    FROM presentacion
    WHERE ctg_id = 3;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `UM_CRUD_pt`(
    IN `p_opcion` INT,
    IN `p_prs_id` INT,
    IN `p_prs_nombre` VARCHAR(50),
    IN `p_equivalencia` INT
)
BEGIN
    IF p_opcion = 1 THEN
        -- Insertar nueva presentación de producto terminado
        INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia)
        VALUES (p_prs_nombre, '', 'vigente', 3, p_equivalencia);
    ELSEIF p_opcion = 2 THEN
        -- Actualizar presentación de producto terminado existente
        UPDATE presentacion
        SET prs_nombre = p_prs_nombre,
            equivalencia = p_equivalencia
        WHERE prs_id = p_prs_id AND ctg_id = 3;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `UM_data_id_pt`(
    IN `p_prs_id` INT
)
BEGIN
    SELECT prs_id, prs_nombre, equivalencia
    FROM presentacion
    WHERE prs_id = p_prs_id AND ctg_id = 3;
END //

DELIMITER ;