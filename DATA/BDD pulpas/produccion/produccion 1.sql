SELECT * FROM fpulpas.produccion;

CREATE TABLE `produccion` (
  `id_produccion` int NOT NULL AUTO_INCREMENT,
  `fecha_produccion` date NOT NULL,
  `cantidad_producida` decimal(10,2) NOT NULL,
  `estado` varchar(20) DEFAULT 'en proceso',
  `subt_MtPm` decimal(10,2) DEFAULT '0.00',
  `subt_MnOb` decimal(10,2) DEFAULT '0.00',
  `subt_Ins` decimal(10,2) DEFAULT '0.00',
  `subt_otros_costos` decimal(10,2) DEFAULT '0.00',
  `total_produccion` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_produccion`)
) ;


-- Registro de producción
INSERT INTO produccion (fecha_produccion, cantidad_producida, estado)
VALUES ('2024-10-20', 500.00, 'en proceso');

INSERT INTO produccion (fecha_produccion, cantidad_producida, estado)
VALUES ('2024-10-20', 500.00, 'en proceso'); -- Esta producción está produciendo 500 unidades




ALTER TABLE produccion 
ADD COLUMN subt_MtPm DECIMAL(10, 2) DEFAULT 0.00, -- Subtotal del costo de la materia prima
ADD COLUMN subt_MnOb DECIMAL(10, 2) DEFAULT 0.00,     -- Subtotal del costo de la mano de obra
ADD COLUMN subt_Ins DECIMAL(10, 2) DEFAULT 0.00,       -- Subtotal del costo de insumos adicionales
ADD COLUMN subt_otros_costos DECIMAL(10, 2) DEFAULT 0.00,  -- Subtotal de otros costos (como costos indirectos)
ADD COLUMN total_produccion DECIMAL(10, 2) DEFAULT 0.00;       -- Total general de producción (suma de todos los subtotales)
