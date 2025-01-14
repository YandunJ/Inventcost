SELECT * FROM fpulpas.mano_obra;

CREATE TABLE mano_obra (
    mo_id INT AUTO_INCREMENT PRIMARY KEY,     -- ID único de mano de obra
    pro_id INT,                               -- Relación con producción
    cat_id INT NOT NULL,
    mo_cant_personas INT NOT NULL,            -- Cantidad de personas involucradas
    mo_precio_hora DECIMAL(10, 2) NOT NULL,   -- Precio por hora
    mo_horas_trabajadas DECIMAL(10, 2) NOT NULL, -- Total de horas trabajadas
    mo_horas_totales DECIMAL(10, 2) DEFAULT 0, -- Horas totales (personas * horas)
    mo_costo_dia DECIMAL(10, 2) DEFAULT 0,   -- Costo por día (horas totales * precio hora)
    mo_costo_total DECIMAL(10, 2) DEFAULT 0, -- Costo total (personas * horas * precio hora)
    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id) ON DELETE RESTRICT
);


CREATE TABLE mano_obra (
    mo_id INT AUTO_INCREMENT PRIMARY KEY,
    pro_id INT,  								
    mo_cant_personas INT NOT NULL,
    mo_precio_hora DECIMAL(10, 2) NOT NULL,
    mo_horas_trabajadas DECIMAL(10, 2) NOT NULL,
    mo_costo_total DECIMAL(10, 2),

    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id) ON DELETE CASCADE
);

-- Registro de mano de obra para una producción específica
INSERT INTO mano_obra (id_produccion, cantidad_personas, horas_trabajadas, precio_hora, costo_total)
VALUES (1, 5, 8.00, 10.00, 400.00); -- 5 personas, 8 horas, $10 por hora

