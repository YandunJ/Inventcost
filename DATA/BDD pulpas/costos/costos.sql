SELECT * FROM fpulpas.costos_indirectos;

CREATE TABLE costos_indirectos (
    cost_id INT AUTO_INCREMENT PRIMARY KEY,
    pro_id INT NOT NULL,
    cat_id INT NOT NULL,
    cost_cant DECIMAL(10, 2) NOT NULL,
    cost_unit DECIMAL(10, 2) NOT NULL,
    cost_total DECIMAL(10, 2),

    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id) ON DELETE RESTRICT
);



-- Registro de costos asociados para una producción específica
INSERT INTO costos_asociados (id_produccion, descripcion, cantidad, costo_unitario, costo_total)
VALUES (1, 'Electricidad', 500, 0.12, 60.00),    -- 500 kWh a $0.12 por kWh
       (1, 'Agua', 1000, 0.05, 50.00);           -- 1000 litros a $0.05 por litro
