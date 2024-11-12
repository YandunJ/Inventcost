SELECT * FROM fpulpas.mano_obra;

CREATE TABLE mano_obra (
    id_mano_obra INT AUTO_INCREMENT PRIMARY KEY,  -- Clave primaria autoincremental
    id_produccion INT,                            -- ID de la producción
    cantidad_personas INT NOT NULL,               -- Cantidad de personas involucradas
    horas_trabajadas DECIMAL(10, 2) NOT NULL,     -- Total de horas trabajadas
    precio_hora DECIMAL(10, 2) NOT NULL,          -- Precio por hora
    costo_total DECIMAL(10, 2) NOT NULL,          -- Costo total (cantidad_personas * horas_trabajadas * precio_hora)
    FOREIGN KEY (id_produccion) REFERENCES produccion(id_produccion) ON DELETE CASCADE
);

-- Registro de mano de obra para una producción específica
INSERT INTO mano_obra (id_produccion, cantidad_personas, horas_trabajadas, precio_hora, costo_total)
VALUES (1, 5, 8.00, 10.00, 400.00); -- 5 personas, 8 horas, $10 por hora

