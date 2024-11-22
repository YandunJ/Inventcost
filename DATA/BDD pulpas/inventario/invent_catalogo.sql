SELECT * FROM fpulpas.invent_catalogo;

CREATE TABLE invent_catalogo (
    id_articulo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_articulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_categoria INT,
    proveedor_id INT NOT NULL,
    uni_id INT NOT NULL,
    estado ENUM('disponible', 'stock bajo', 'agotado') DEFAULT 'disponible',
    fecha_creacion DATE NOT NULL,
    stock INT DEFAULT 0,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id),
    FOREIGN KEY (uni_id) REFERENCES unidades_medida(uni_id)
);


CREATE TABLE unidades_medida (
    uni_id INT AUTO_INCREMENT PRIMARY KEY,
    uni_nombre VARCHAR(50) NOT NULL UNIQUE,
    uni_abreviacion VARCHAR(10) NOT NULL
);

INSERT INTO unidades_medida (uni_nombre, uni_abreviacion) VALUES
('Kilogramos', 'kg'),
('Gramos', 'g'),
('Litros', 'lt'),
('Mililitros', 'ml'),
('Unidades', 'u');


INSERT INTO unidades_medida (nombre_unidad, descripcion) VALUES
('Kilogramos', 'Medida de peso utilizada para productos sólidos'),
('Litros', 'Medida de volumen utilizada para líquidos'),
('Unidades', 'Cantidad individual de artículos'),
('Gramos', 'Medida de peso más pequeña');



INSERT INTO invent_catalogo (nombre_articulo, descripcion, id_categoria,proveedor_id, uni_id, estado, fecha_creacion, stock)
VALUES
    ('Manzana Roja', 'Manzanas rojas frescas para producción de pulpa', 1, 1, '1', 'disponible', '2024-10-06', 0);
    ('Piña', 'Piñas frescas para producción de pulpa', 1, 'unidades', 'disponible', '2024-10-06', 0),
    ('Banana', 'Bananas maduras para producción de pulpa', 1, 'racimos', 'disponible', '2024-10-06', 0),
    ('Cofia', 'Cofia desechable para personal de producción', 2, 'unidades', 'disponible', '2024-10-06', 0),
    ('Mascarilla', 'Mascarilla quirúrgica', 2, 'unidades', 'stock bajo', '2024-10-06', 0),
    ('Goma Xanthan', 'Espesante para productos', 2, 'kilogramos', 'disponible', '2024-10-06', 0),
    ('Saborizante de Fresa', 'Saborizante artificial de fresa', 2, 'kilogramos', 'disponible', '2024-10-06', 0),
    ('Ácido Cítrico', 'Conservante', 2, 'kilogramos', 'disponible', '2024-10-06', 0),
    ('Antiespumante', 'Agente antiespumante para procesos', 2, 'litros', 'disponible', '2024-10-06', 0),
    ('Funda de 250g', 'Funda plástica para envase de 250g', 2, 'unidades', 'disponible', '2024-10-06', 0)
;

DELIMITER //
CREATE PROCEDURE acc_invent_catalogo(
    IN p_id_articulo INT,
    IN p_nombre_articulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_id_categoria INT,
    IN p_unidad_medida VARCHAR(50),
    IN p_estado VARCHAR(20),
    IN p_stock INT,
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE exit_handler CONDITION FOR SQLEXCEPTION;
    
    DECLARE v_existe_articulo INT;

    SET p_resultado = 0; -- Inicializamos el resultado como fallo

    -- Verificamos si el artículo existe antes de actualizar
    SELECT COUNT(*) INTO v_existe_articulo FROM invent_catalogo WHERE id_articulo = p_id_articulo;

    START TRANSACTION;

    BEGIN
        DECLARE exit_handler:
        BEGIN
            ROLLBACK;
            SET p_mensaje = 'Error al ejecutar la transacción';
        END;

        IF p_id_articulo = 0 THEN
            -- Inserción
            INSERT INTO invent_catalogo (nombre_articulo, descripcion, id_categoria, unidad_medida, estado, fecha_creacion, stock)
            VALUES (p_nombre_articulo, p_descripcion, p_id_categoria, p_unidad_medida, p_estado, CURDATE(), p_stock);
            SET p_mensaje = 'Artículo creado exitosamente';
        ELSE
            -- Actualización
            IF v_existe_articulo = 0 THEN
                SET p_mensaje = 'Artículo no encontrado';
            ELSE
                UPDATE invent_catalogo
                SET nombre_articulo = p_nombre_articulo,
                    descripcion = p_descripcion,
                    id_categoria = p_id_categoria,
                    unidad_medida = p_unidad_medida,
                    estado = p_estado,
                    stock = p_stock
                WHERE id_articulo = p_id_articulo;
                SET p_mensaje = 'Artículo actualizado exitosamente';
            END IF;
        END IF;

        COMMIT;
        SET p_resultado = 1;
    END
//

DELIMITER ;

SELECT id_articulo, nombre_articulo FROM invent_catalogo where id_categoria = 1; 

DESCRIBE invent_catalogo;
DESCRIBE proveedores;
DESCRIBE invent_detalle_MP;


DELIMITER //

CREATE TRIGGER actualizar_stock
AFTER INSERT ON inventario
FOR EACH ROW
BEGIN
    -- Sumar todas las cantidades ingresadas para el artículo correspondiente
    UPDATE invent_catalogo AS cat
    SET cat.stock = (
        SELECT SUM(inv.cantidad_ingresada)
        FROM inventario AS inv
        WHERE inv.id_articulo = NEW.id_articulo
    )
    WHERE cat.id_articulo = NEW.id_articulo;
END //

DELIMITER ;


ALTER TABLE invent_catalogo
ADD COLUMN proveedor_id INT NOT NULL,
ADD CONSTRAINT fk_proveedor_catalogo FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id);

DELIMITER //
CREATE PROCEDURE obt_invCatalogo()
BEGIN
    SELECT 
        ic.id_articulo, 
        ic.nombre_articulo, 
        ic.descripcion, 
        c.nombre_categoria AS categoria, 
        p.nombre_empresa AS proveedor, 
        um.uni_nombre AS unidad_medida, 
        ic.estado, 
        ic.fecha_creacion, 
        ic.stock
    FROM invent_catalogo ic
    INNER JOIN categorias c ON ic.id_categoria = c.id_categoria
    INNER JOIN proveedores p ON ic.proveedor_id = p.proveedor_id
    INNER JOIN unidades_medida um ON ic.uni_id = um.uni_id; -- Cambio aquí
END//
DELIMITER ;

call fpulpas.obt_invCatalogo();


