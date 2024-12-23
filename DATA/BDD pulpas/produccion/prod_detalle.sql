SELECT * FROM fpulpas.prod_detalle;
-- Tabla que enlaza los insumos y materia prima con la producción
CREATE TABLE prod_detalle (
    id_det_prod INT AUTO_INCREMENT PRIMARY KEY,   -- Clave primaria autoincremental
    id_produccion INT NOT NULL,                  -- Referencia a la producción
    id_inv INT NOT NULL,                         -- Referencia al lote de inventario
    cantidad_usada DECIMAL(10,2) NOT NULL,       -- Cantidad utilizada de este lote
    cantidad_producida DECIMAL(10,2) DEFAULT 0,  -- Cantidad total producida (por defecto 0)
    cantidad_desperdiciada DECIMAL(10,2) DEFAULT 0, -- Cantidad desperdiciada (por defecto 0)
    FOREIGN KEY (id_produccion) REFERENCES produccion(id_produccion) ON DELETE CASCADE,
    FOREIGN KEY (id_inv) REFERENCES inventario(id_inv) ON DELETE CASCADE
);

-- Producción con 50 kg de manzanas usadas, 5 fundas de pulpa producidas, y 2 kg de desperdicio
