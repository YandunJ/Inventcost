SELECT * FROM fpulpas.prod_detalle;
-- Tabla que enlaza los insumos y materia prima con la producción
CREATE TABLE prod_detalle (
    pdet_id INT AUTO_INCREMENT PRIMARY KEY,
    pro_id INT NOT NULL,
    id_inv INT NOT NULL ,
    pdet_cantidad_usada DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id) ON DELETE CASCADE,
    FOREIGN KEY (id_inv) REFERENCES inventario(id_inv) ON DELETE CASCADE
);

-- pdet_cantidad_producida DECIMAL(10,2) DEFAULT 0,
-- pdet_cantidad_desperdiciada DECIMAL(10,2) DEFAULT 0,
-- Producción con 50 kg de manzanas usadas, 5 fundas de pulpa producidas, y 2 kg de desperdicio

ALTER TABLE prod_detalle ADD COLUMN inv_lote VARCHAR(50) AFTER inv_id;
