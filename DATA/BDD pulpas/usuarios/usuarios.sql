SELECT * FROM fpulpas.usuarios;

DELIMITER //

CREATE PROCEDURE sp_reg_usu (
    IN p_usu_cedula VARCHAR(20),
    IN p_usu_nombre VARCHAR(255),
    IN p_usu_apellido VARCHAR(255),
    IN p_usu_telefono VARCHAR(15),
    IN p_usu_correo VARCHAR(255),
    IN p_usu_direccion VARCHAR(255),
    IN p_usu_usuario VARCHAR(50),
    IN p_usu_contrasenia VARCHAR(255),
    IN p_rol_id INT
)
BEGIN
    DECLARE v_rol_nombre VARCHAR(45);

    -- Obtener el nombre del rol
    SELECT rol_nombre INTO v_rol_nombre
    FROM roles
    WHERE rol_id = p_rol_id;

    -- Insertar el usuario en la tabla usuarios
    INSERT INTO usuarios (usu_cedula, usu_nombre, usu_apellido, usu_telefono, usu_correo, usu_direccion, usu_usuario, usu_contrasenia, rol_id, fecha_reg)
    VALUES (p_usu_cedula, p_usu_nombre, p_usu_apellido, p_usu_telefono, p_usu_correo, p_usu_direccion, p_usu_usuario, p_usu_contrasenia, p_rol_id, CURRENT_TIMESTAMP);

    -- Si el rol no es "Administrador", insertar en la tabla empleados
    IF v_rol_nombre <> 'Administrador' THEN
        INSERT INTO empleados (emp_cedula, emp_nombre, emp_apellido, emp_telefono, emp_correo, emp_direccion)
        VALUES (p_usu_cedula, p_usu_nombre, p_usu_apellido, p_usu_telefono, p_usu_correo, p_usu_direccion);
    END IF;
END //

DELIMITER ;

call fpulpas.sp_reg_usu('232423', 'revision', 'rev', '493498', 'ejnw@fjs', 'cas', 'rev', 'rev', 3);

//nuevo actulizar usuario

DELIMITER //

CREATE PROCEDURE sp_act_usu (
    IN p_usu_id INT,
    IN p_usu_cedula VARCHAR(20),
    IN p_usu_nombre VARCHAR(255),
    IN p_usu_apellido VARCHAR(255),
    IN p_usu_telefono VARCHAR(15),
    IN p_usu_correo VARCHAR(255),
    IN p_usu_direccion VARCHAR(255),
    IN p_usu_usuario VARCHAR(50),
    IN p_usu_contrasenia VARCHAR(255),
    IN p_rol_id INT
)
BEGIN
    -- Desactivar el modo seguro
    SET SQL_SAFE_UPDATES = 0;

    -- Actualizar el usuario en la tabla usuarios
    UPDATE usuarios
    SET usu_cedula = p_usu_cedula,
        usu_nombre = p_usu_nombre,
        usu_apellido = p_usu_apellido,
        usu_telefono = p_usu_telefono,
        usu_correo = p_usu_correo,
        usu_direccion = p_usu_direccion,
        usu_usuario = p_usu_usuario,
        usu_contrasenia = p_usu_contrasenia,
        rol_id = p_rol_id
    WHERE usu_id = p_usu_id;

    -- Actualizar el empleado en la tabla empleados utilizando la cédula
    UPDATE empleados
    SET emp_cedula = p_usu_cedula,
        emp_nombre = p_usu_nombre,
        emp_apellido = p_usu_apellido,
        emp_telefono = p_usu_telefono,
        emp_correo = p_usu_correo,
        emp_direccion = p_usu_direccion
    WHERE emp_cedula = p_usu_cedula;

    -- Volver a activar el modo seguro
    SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;


call fpulpas.sp_act_usu(18, '55555', 'cambio', 'nuevo', 'nuevo', 'nuevocorreo', 'nuevo', 'nuevo', 'nuevo', 3);


DELIMITER //

CREATE PROCEDURE pa_obtener_usuarios ()
BEGIN
    SELECT usu_id, usu_cedula, usu_nombre, usu_apellido, usu_telefono, usu_correo, usu_direccion, usu_usuario, rol_id, fecha_reg
    FROM usuarios;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE pa_eliminar_usu(
    IN p_usu_id INT
)
BEGIN
    DECLARE v_usu_cedula VARCHAR(20);

    -- Obtener la cédula del usuario a eliminar
    SELECT usu_cedula INTO v_usu_cedula
    FROM usuarios
    WHERE usu_id = p_usu_id;

    -- Eliminar el registro del usuario
    DELETE FROM usuarios WHERE usu_id = p_usu_id;

    -- Eliminar el registro del empleado asociado
    DELETE FROM empleados WHERE emp_cedula = v_usu_cedula;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE sp_obt_usu__id(IN p_usu_id INT)
BEGIN
    SELECT 
        usu_id, 
        usu_cedula, 
        usu_nombre, 
        usu_apellido, 
        usu_telefono, 
		usu_direccion, 
        usu_correo, 
        usu_usuario, 
        rol_id 
    FROM 
        usuarios 
    WHERE 
        usu_id = p_usu_id;
END //

DELIMITER ;




DELIMITER //
CREATE PROCEDURE sp_verificar_usuario(
    IN p_usuario VARCHAR(50),
    IN p_contrasenia VARCHAR(255)
)
BEGIN
    SELECT u.usu_id, u.usu_nombre, u.usu_apellido, u.usu_contrasenia, p.permiso_id
    FROM usuarios u
    JOIN roles r ON u.rol_id = r.rol_id
    JOIN permisos p ON r.permiso_id = p.permiso_id
    WHERE u.usu_usuario = p_usuario;
END //
DELIMITER ;



ALTER TABLE usuarios ADD fecha_reg TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

call fpulpas.sp_verificar_usuario('j', 'j');

-- correcion sp anterior si vale --

DELIMITER //

CREATE PROCEDURE sp_obt_usu__id(IN p_usu_id INT)
BEGIN
    SELECT 
        usu_id, 
        usu_cedula, 
        usu_nombre, 
        usu_apellido, 
        usu_telefono, 
        usu_correo, 
        usu_direccion, 
        usu_usuario, 
        rol_id 
    FROM 
        usuarios 
    WHERE 
        usu_id = p_usu_id;
END //

DELIMITER ;


