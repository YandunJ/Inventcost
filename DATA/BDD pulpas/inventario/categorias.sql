SELECT * FROM fpulpas.categorias;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_registro DATE NOT NULL
);

INSERT INTO categorias (nombre_categoria, descripcion, fecha_registro)
VALUES
('Materia Prima', 'Frutas para almacenamiento y uso en producción', '2024-10-05'),
('Insumos', 'Materiales utilizados en la producción', '2024-10-05'),
('Productos Terminado', 'Paquetes de Pulpa Procesada', '2024-10-05');

DELIMITER //


SELECT DISTINCT p.proveedor_id, p.nombre_empresa
FROM proveedores p
JOIN invent_catalogo ic ON p.proveedor_id = ic.proveedor_id
WHERE ic.id_categoria = 1 AND ic.estado = 'disponible';


CREATE PROCEDURE generar_lote (
    IN id_categoria INT, -- ID de la categoría (1, 2, 3)
    OUT numero_lote VARCHAR(20)
)
BEGIN
    DECLARE prefijo VARCHAR(5);
    DECLARE fecha VARCHAR(6);
    DECLARE consecutivo INT;

    -- Determinar el prefijo según el ID de categoría
    CASE id_categoria
        WHEN 1 THEN SET prefijo = 'MP_';
        WHEN 2 THEN SET prefijo = 'INS_';
        WHEN 3 THEN SET prefijo = 'PT_';
        ELSE SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ID de categoría no válido';
    END CASE;

    -- Fecha en formato DDMMAA
    SET fecha = DATE_FORMAT(NOW(), '%d%m%y');

    -- Obtener el número consecutivo más alto para esa fecha y prefijo
    SELECT COALESCE(MAX(CAST(SUBSTRING(numero_lote, 8) AS UNSIGNED)), 0) + 1
    INTO consecutivo
    FROM inventario
    WHERE numero_lote LIKE CONCAT(prefijo, fecha, '%');

    -- Construir el número de lote
    SET numero_lote = CONCAT(prefijo, fecha, consecutivo);
END //

DELIMITER ;

