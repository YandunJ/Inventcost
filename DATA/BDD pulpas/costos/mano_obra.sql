SELECT * FROM fpulpas.mano_obra;

CREATE TABLE mano_obra (
    mo_id INT AUTO_INCREMENT PRIMARY KEY,     -- ID único de mano de obra
    pro_id INT,                               -- Relación con producción
    cat_id INT NOT NULL,
    mo_personas INT NOT NULL,            -- Cantidad de personas involucradas
    mo_precio_hora DECIMAL(10, 2) NOT NULL,   -- Precio por hora
    mo_horas_trabajadas DECIMAL(10, 2) NOT NULL, -- Total de horas trabajadas
    mo_horas_totales DECIMAL(10, 2) DEFAULT 0, -- Horas totales (personas * horas)
    mo_costo_dia DECIMAL(10, 2) DEFAULT 0,   -- Costo por día (horas totales * precio hora)
    mo_costo_total DECIMAL(10, 2) DEFAULT 0, -- Costo total (personas * horas * precio hora)
    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id) ON DELETE RESTRICT
);

CREATE TABLE prcostos (
    cst_id INT AUTO_INCREMENT PRIMARY KEY,        -- ID único de la tabla prcostos
    pro_id INT NOT NULL,                          -- Relación con producción
    cat_id INT NOT NULL,                          -- Relación con catálogo (mano de obra o costos indirectos)
    prs_id INT DEFAULT NULL,                      -- Relación con presentaciones (si aplica)
    cst_cant DECIMAL(10,2) DEFAULT NULL,  -- Cantidad de personas o cantidad unitaria para costos indirectos
    cst_horas_persona DECIMAL(10,2) DEFAULT NULL,  -- Total de horas por persona (para mano de obra)
    cst_precio_ht DECIMAL(10,2) DEFAULT NULL,          -- Precio por hora o precio unitario para costos indirectos
    cst_total_horas_actividad DECIMAL(10,2) DEFAULT NULL,  -- Total de horas trabajadas (para mano de obra)
    cst_costo_total DECIMAL(10,2) NOT NULL,       -- Costo total calculado
    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id),  -- Relación con producción
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id),    -- Relación con catálogo
    FOREIGN KEY (prs_id) REFERENCES presentacion(prs_id) -- Relación con presentaciones
);

-- Registro de mano de obra para una producción específica
INSERT INTO mano_obra (id_produccion, cantidad_personas, horas_trabajadas, precio_hora, costo_total)
VALUES (1, 5, 8.00, 10.00, 400.00); -- 5 personas, 8 horas, $10 por hora


DELIMITER $$

CREATE PROCEDURE PROD_sp(
    IN _cantidad_producida DECIMAL(10,2),
    IN _subtotal_mp DECIMAL(10,2),
    IN _subtotal_ins DECIMAL(10,2),
    IN _subtotal_mo DECIMAL(10,2),
    IN _subtotal_ci DECIMAL(10,2),
    IN _detalles_consumos JSON,
    IN _costos_asociados JSON
)
BEGIN
    DECLARE _pro_id INT;
    DECLARE _detalle JSON;
    DECLARE _costo JSON;

    -- 1. Insertar datos generales en la tabla `produccion`
    INSERT INTO produccion (fecha_hora, cantidad_producida, subtotal_mp, subtotal_ins, subtotal_mo, subtotal_ci)
    VALUES (NOW(), _cantidad_producida, _subtotal_mp, _subtotal_ins, _subtotal_mo, _subtotal_ci);
    SET _pro_id = LAST_INSERT_ID();

    -- 2. Registrar consumos en `prod_detalle`
    WHILE JSON_LENGTH(_detalles_consumos) > 0 DO
        SET _detalle = JSON_EXTRACT(_detalles_consumos, '$[0]');
        INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
        VALUES (_pro_id, 
            JSON_UNQUOTE(JSON_EXTRACT(_detalle, '$.id_inv')), 
            JSON_UNQUOTE(JSON_EXTRACT(_detalle, '$.cantidad'))
        );
        
        -- Actualizar inventario (reducir cantidad restante)
        UPDATE inventario
        SET cant_restante = cant_restante - JSON_UNQUOTE(JSON_EXTRACT(_detalle, '$.cantidad'))
        WHERE id_inv = JSON_UNQUOTE(JSON_EXTRACT(_detalle, '$.id_inv'));
        
        SET _detalles_consumos = JSON_REMOVE(_detalles_consumos, '$[0]');
    END WHILE;

    -- 3. Registrar costos en `costos_asociados`
    WHILE JSON_LENGTH(_costos_asociados) > 0 DO
        SET _costo = JSON_EXTRACT(_costos_asociados, '$[0]');
        INSERT INTO costos_asociados (pro_id, tipo, descripcion, monto)
        VALUES (_pro_id, 
            JSON_UNQUOTE(JSON_EXTRACT(_costo, '$.tipo')), 
            JSON_UNQUOTE(JSON_EXTRACT(_costo, '$.descripcion')), 
            JSON_UNQUOTE(JSON_EXTRACT(_costo, '$.monto'))
        );

        SET _costos_asociados = JSON_REMOVE(_costos_asociados, '$[0]');
    END WHILE;
END$$

DELIMITER ;


CALL PROD_sp(
    50.00,                 -- Cantidad producida
    100.50,                -- Subtotal materia prima
    50.25,                 -- Subtotal insumos
    80.00,                 -- Subtotal mano de obra
    30.00,                 -- Subtotal costos indirectos
    '[{"id_inv":1,"cantidad":5},{"id_inv":2,"cantidad":3},{"id_inv":3,"cantidad":4}]', -- Detalles consumos
    '[{"tipo":"Transporte","descripcion":"Camión de carga","monto":150.00},{"tipo":"Mantenimiento","descripcion":"Máquina X","monto":200.00}]' -- Costos asociados
);

