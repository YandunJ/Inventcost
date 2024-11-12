SELECT * FROM fpulpas.produccion;

CREATE TABLE produccion (
    id_produccion INT AUTO_INCREMENT PRIMARY KEY,  -- Clave única para el registro de producción
    fecha_produccion DATE NOT NULL,                -- Fecha en que se realiza la producción
    cantidad_producida DECIMAL(10, 2) NOT NULL,    -- Cantidad total producida (por ejemplo, en bolsas, botellas, etc.)
    estado VARCHAR(20) DEFAULT 'en proceso'        -- Estado de la producción (en proceso, completado)
);

-- Registro de producción
INSERT INTO produccion (fecha_produccion, cantidad_producida, estado)
VALUES ('2024-10-20', 500.00, 'en proceso');

INSERT INTO produccion (fecha_produccion, cantidad_producida, estado)
VALUES ('2024-10-20', 500.00, 'en proceso'); -- Esta producción está produciendo 500 unidades


