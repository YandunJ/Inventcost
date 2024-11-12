SELECT * FROM fpulpas.roles;

DELIMITER //

CREATE PROCEDURE acciones_rol(
    IN p_rol_id INT,
    IN p_rol_nombre VARCHAR(45),
    IN p_rol_descripcion VARCHAR(255),
    IN p_permiso_id INT
)
BEGIN
    DECLARE v_fecha_reg DATE;
    IF p_rol_id IS NULL THEN
        -- Insertar un nuevo rol
        SET v_fecha_reg = CURRENT_DATE;
        INSERT INTO roles (rol_nombre, rol_descripcion, permiso_id, fecha_registro)
        VALUES (p_rol_nombre, p_rol_descripcion, p_permiso_id, v_fecha_reg);
    ELSE
        -- Actualizar un rol existente
        UPDATE roles
        SET rol_nombre = p_rol_nombre,
            rol_descripcion = p_rol_descripcion,
            permiso_id = p_permiso_id
        WHERE rol_id = p_rol_id;
    END IF;
END //

DELIMITER ;
	
call fpulpas.acciones_rol(null, 'prueba', 'prueba de que funcion sp', 3);
call fpulpas.acciones_rol(6, 'cambio', 'cambio de rol ', 3);

    
    DELIMITER //

CREATE PROCEDURE pa_obtener_roles()
BEGIN
    SELECT rol_id, rol_nombre, rol_descripcion, permiso_id, fecha_registro
    FROM roles;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE pa_obtener_roles()
BEGIN
    SELECT r.rol_id, 
           r.rol_nombre, 
           r.rol_descripcion, 
           p.permiso_nombre AS permiso_nombre, -- Cambia esto para seleccionar el nombre del permiso
           r.fecha_registro
    FROM roles r
    LEFT JOIN permisos p ON r.permiso_id = p.permiso_id; -- Asegúrate de que se haga un JOIN para obtener el nombre del permiso
END //
DELIMITER ;




DELIMITER //

CREATE PROCEDURE pa_eliminar_rol(
    IN p_rol_id INT
)
BEGIN
    DELETE FROM roles
    WHERE rol_id = p_rol_id;
END //

DELIMITER ;

     
    
ALTER TABLE roles
ADD COLUMN fecha_registro DATE NOT NULL DEFAULT (CURRENT_DATE);

