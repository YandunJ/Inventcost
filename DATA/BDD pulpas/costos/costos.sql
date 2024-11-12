SELECT * FROM fpulpas.costos_asociados;

CREATE TABLE costos_asociados (
    id_costo INT AUTO_INCREMENT PRIMARY KEY,      -- Clave primaria autoincremental
    id_produccion INT,                            -- ID de la producción
    descripcion VARCHAR(100) NOT NULL,            -- Descripción del costo (ej. Luz, Agua, Transporte)
    cantidad DECIMAL(10, 2) NOT NULL,             -- Cantidad utilizada (ej. litros, kilovatios, etc.)
    costo_unitario DECIMAL(10, 2) NOT NULL,       -- Costo por unidad
    costo_total DECIMAL(10, 2) NOT NULL,          -- Costo total (cantidad * costo_unitario)
    FOREIGN KEY (id_produccion) REFERENCES produccion(id_produccion) ON DELETE CASCADE
);

-- Registro de costos asociados para una producción específica
INSERT INTO costos_asociados (id_produccion, descripcion, cantidad, costo_unitario, costo_total)
VALUES (1, 'Electricidad', 500, 0.12, 60.00),    -- 500 kWh a $0.12 por kWh
       (1, 'Agua', 1000, 0.05, 50.00);           -- 1000 litros a $0.05 por litro
