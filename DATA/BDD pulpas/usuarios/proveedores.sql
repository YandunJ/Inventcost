SELECT * FROM fpulpas.proveedores;

CREATE TABLE proveedores (
    proveedor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(255),
    representante VARCHAR(255),
    direccion VARCHAR(255),
    correo VARCHAR(255),
    telefono VARCHAR(50),
    fecha_reg timestamp
);

INSERT INTO fpulpas.proveedores (nombre_empresa, representante, direccion, correo, telefono, fecha_reg)
VALUES
('Frutas del Valle S.A.', 'Juan Pérez', 'Av. Principal 123, Ciudad Jardín', 'frutasdelvalle@correo.com', '1234567890', '2023-11-01 10:00:00'),
('Agroindustrias del Sur S.A.', 'María Rodríguez', 'Carretera Central Km 5, Pueblo Nuevo', 'agroindustrias@correo.com', '9876543210', '2023-10-25 15:30:00'),
('Pulpas Naturales S.A.', 'Pedro Gómez', 'Zona Industrial, Nave 10', 'pulpasnaturales@correo.com', '5555555555', '2023-12-03 09:15:00'),
('Exportadora del Pacífico S.A.', 'Ana Martínez', 'Puerto Marítimo, Muelle 2', 'exportadoradelpacifico@correo.com', '3333333333', '2023-09-20 14:00:00'),
('Cooperativa Agrícola El Sol', 'Luis Hernández', 'Finca La Esperanza, Valle del Cauca', 'cooperativaagricola@correo.com', '7777777777', '2024-01-15 11:30:00'),
('Frutas Exóticas S.A.', 'Sofía Ramírez', 'Zona Franca, Bodega 5', 'frutasexoticas@correo.com', '2222222222', '2023-12-10 16:45:00'),
('Agroindustria del Norte S.A.', 'Carlos López', 'Carretera Panamericana Km 20, Norte', 'agroindustridelnorte@correo.com', '8888888888', '2024-02-05 08:00:00'),
('Pulpas Andinas S.A.', 'Laura Silva', 'Sierra Nevada, Sector Industrial', 'pulpasandinas@correo.com', '4444444444', '2023-11-18 13:15:00'),
('Frutas Selectas S.A.', 'Diego Morales', 'Mercado Central, Locales 2-3', 'frutasselectas@correo.com', '6666666666', '2024-03-10 10:30:00'),
('Agropecuaria El Dorado S.A.', 'Camila Vega', 'Finca La Fortuna, Llanos Orientales', 'agropecuariaeldorado@correo.com', '9999999999', '2023-12-25 12:00:00')
;
DELIMITER //
CREATE PROCEDURE acciones_proveedor(
    IN p_proveedor_id INT,
    IN p_nombre_empresa VARCHAR(255),
    IN p_representante VARCHAR(255),
    IN p_direccion VARCHAR(255),
    IN p_correo VARCHAR(255),
    IN p_telefono VARCHAR(50)
)
BEGIN
    DECLARE v_fecha_reg TIMESTAMP;
    IF p_proveedor_id IS NULL THEN
        -- Insertar un nuevo proveedor
        SET v_fecha_reg = CURRENT_TIMESTAMP;
        INSERT INTO proveedores (nombre_empresa, representante, direccion, correo, telefono, fecha_reg)
        VALUES (p_nombre_empresa, p_representante, p_direccion, p_correo, p_telefono, v_fecha_reg);
    ELSE
        -- Actualizar un proveedor existente
        UPDATE proveedores
        SET nombre_empresa = p_nombre_empresa,
            representante = p_representante,
            direccion = p_direccion,
            correo = p_correo,
            telefono = p_telefono
        WHERE proveedor_id = p_proveedor_id;
    END IF;
END //
DELIMITER ;

call fpulpas.acciones_proveedor(null, 'ultima', 'pablo', 'ibarra city', 'jasjbaj@asj', '239239');
call fpulpas.acciones_proveedor(13, 'cambio', 'cambio', 'cambio', 'cambio@gakj', '32938');


DELIMITER //
CREATE PROCEDURE pa_obtener_proveedores()
BEGIN
    SELECT proveedor_id, nombre_empresa, representante, direccion, correo, telefono, fecha_reg FROM proveedores;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE pa_eliminar_proveedor(
    IN p_proveedor_id INT
)
BEGIN
    DELETE FROM proveedores WHERE proveedor_id = p_proveedor_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE pa_obt_prov_id(
    IN p_proveedor_id INT
)
BEGIN
    SELECT proveedor_id, nombre_empresa, representante, direccion, correo, telefono, fecha_reg
    FROM proveedores
    WHERE proveedor_id = p_proveedor_id;
END //
DELIMITER ;


