SELECT * FROM fpulpas.empleados;

DELIMITER //
CREATE PROCEDURE acciones_empleado(
    IN p_emp_id INT,
    IN p_cedula VARCHAR(10),
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(15),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(100)
)
BEGIN
    DECLARE emp_count INT;

    -- Verificar si ya existe un empleado con la misma cédula
    SELECT COUNT(*) INTO emp_count 
    FROM empleados 
    WHERE emp_cedula = p_cedula AND (emp_id != p_emp_id OR p_emp_id IS NULL);

    IF emp_count > 0 THEN
        -- Si ya existe, lanza un error o actualiza el registro en su lugar
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La cédula ya está registrada';
    ELSE
        -- Si p_emp_id es NULL o 0, significa que es una nueva inserción
        IF p_emp_id IS NULL OR p_emp_id = 0 THEN
            INSERT INTO empleados (emp_cedula, emp_nombre, emp_apellido, emp_telefono, emp_correo, emp_direccion)
            VALUES (p_cedula, p_nombre, p_apellido, p_telefono, p_correo, p_direccion);
        ELSE
            -- De lo contrario, se debe actualizar el registro existente
            UPDATE empleados
            SET emp_cedula = p_cedula,
                emp_nombre = p_nombre,
                emp_apellido = p_apellido,
                emp_telefono = p_telefono,
                emp_correo = p_correo,
                emp_direccion = p_direccion
            WHERE emp_id = p_emp_id;
        END IF;
    END IF;
END;
 //
DELIMITER ;


call fpulpas.acciones_empleado(null, '333', 'pablo', 'pablo', '93282', 'ksja@fjsh', 'urcu');
call fpulpas.acciones_empleado(30, '3333', 'sonic', 'erizo', '3838', 'sonic@gmail.com', 'ecuador');



DELIMITER //
CREATE PROCEDURE pa_obt_empleados()
BEGIN
    SELECT * FROM empleados;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE pa_eliminar_empleado(
    IN p_emp_id INT,
    IN p_emp_cedula VARCHAR(20)
)
BEGIN
    DECLARE v_usuario_count INT;

    -- Verificar si el empleado es también un usuario
    SELECT COUNT(*) INTO v_usuario_count
    FROM usuarios
    WHERE usu_cedula = p_emp_cedula;

    -- Si el empleado no es usuario, permitir eliminar
    IF v_usuario_count = 0 THEN
        DELETE FROM empleados WHERE emp_id = p_emp_id;
    ELSE
        -- Si el empleado es usuario, no permitir eliminar
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar un empleado que también es usuario. Dirijase a la seccion de usuarios para eliminar este empleado';
    END IF;
END // 		
DELIMITER ;


call fpulpas.pa_eliminar_empleado(15, '901293791');

-- anterior sp acciones

DELIMITER //
CREATE PROCEDURE acciones_empleado(
    IN p_emp_id INT,
    IN p_emp_cedula VARCHAR(20),
    IN p_emp_nombre VARCHAR(255),
    IN p_emp_apellido VARCHAR(255),
    IN p_emp_telefono VARCHAR(15),
    IN p_emp_correo VARCHAR(255),
    IN p_emp_direccion VARCHAR(255)
)
BEGIN
    DECLARE v_usuario_count INT;
    
    -- Verificar si el empleado es también un usuario
    SELECT COUNT(*) INTO v_usuario_count
    FROM usuarios
    WHERE usu_cedula = p_emp_cedula;

    -- Si el empleado no es usuario, permitir registrar o actualizar
    IF v_usuario_count = 0 THEN
        IF p_emp_id IS NULL THEN
            -- Insertar nuevo empleado
            INSERT INTO empleados (emp_cedula, emp_nombre, emp_apellido, emp_telefono, emp_correo, emp_direccion)
            VALUES (p_emp_cedula, p_emp_nombre, p_emp_apellido, p_emp_telefono, p_emp_correo, p_emp_direccion);
        ELSE
            -- Actualizar empleado existente
            UPDATE empleados
            SET emp_cedula = p_emp_cedula,
                emp_nombre = p_emp_nombre,
                emp_apellido = p_emp_apellido,
                emp_telefono = p_emp_telefono,
                emp_correo = p_emp_correo,
                emp_direccion = p_emp_direccion
            WHERE emp_id = p_emp_id;
        END IF;
    ELSE
        -- Si el empleado es usuario, no permitir registrar o actualizar
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede registrar o actualizar un empleado que también es usuario.';
    END IF;
END //
DELIMITER ;


