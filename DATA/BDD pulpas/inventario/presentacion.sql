SELECT * FROM fpulpas.presentacion;

CREATE TABLE `presentacion` (
  `prs_id` int NOT NULL AUTO_INCREMENT,
  `prs_nombre` varchar(50) NOT NULL,
  `prs_abreviacion` varchar(10) NOT NULL,
  `prs_estado` enum('vigente','descontinuado') NOT NULL DEFAULT 'vigente',
  `ctg_id` int DEFAULT NULL,
  `equivalencia` int DEFAULT NULL,
  PRIMARY KEY (`prs_id`),
  KEY `fk_categoria` (`ctg_id`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`ctg_id`) REFERENCES `categorias` (`ctg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
    IF p_opcion = 1 THEN
        -- Registrar nueva presentación
        INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia)
        VALUES (p_prs_nombre, p_prs_abreviacion, p_prs_estado, p_ctg_id, p_equivalencia);
    ELSEIF p_opcion = 2 THEN
        -- Actualizar presentación existente
        UPDATE presentacion
        SET prs_nombre = p_prs_nombre,
            prs_abreviacion = p_prs_abreviacion,
            prs_estado = p_prs_estado,
            ctg_id = p_ctg_id,
            equivalencia = p_equivalencia
        WHERE prs_id = p_prs_id;
    END IF;
END //
DELIMITER ;

CALL UM_CRUD(
    1, -- Opción 1 para registrar
    0, -- ID de la presentación (no se usa en registro)
    '200 gr', -- Nombre de la presentación
    'gr', -- Abreviación
    'vigente', -- Estado
    3, -- ID de la categoría (Producto Terminado)
    200 -- Equivalencia en gramos
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

CREATE PROCEDURE UM_data()
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia
    FROM presentacion;
END //

DELIMITER ;
call fpulpas.UM_data();

