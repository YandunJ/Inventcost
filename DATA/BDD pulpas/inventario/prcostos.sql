SELECT * FROM fpulpas.prcostos;

CREATE TABLE prcostos (
    cst_id INT AUTO_INCREMENT PRIMARY KEY,        -- ID único de la tabla prcostos
    pro_id INT NOT NULL,                          -- Relación con producción
    cat_id INT NOT NULL,                          -- Relación con catálogo (mano de obra o costos indirectos)
    cst_cant DECIMAL(10,2) DEFAULT NULL,  -- Cantidad de personas o cantidad unitaria para costos indirectos
    cst_presentacion VARCHAR(20) DEFAULT 'UNIDADES',      -- presentacion o unidad de medida
    cst_horas_persona DECIMAL(10,2) DEFAULT NULL,  -- Total de horas por persona (para mano de obra)
    cst_precio_ht DECIMAL(10,2) DEFAULT NULL,          -- Precio por hora o precio unitario para costos indirectos
    cst_total_horas_actividad DECIMAL(10,2) DEFAULT NULL,  -- Total de horas trabajadas (para mano de obra)
    cst_costo_total DECIMAL(10,2) NOT NULL,       -- Costo total calculado
    FOREIGN KEY (pro_id) REFERENCES produccion(pro_id),  -- Relación con producción
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id)    -- Relación con catálogo
    
);

DELIMITER $$

CREATE PROCEDURE `DetallesProd`(
    IN pro_id INT
)
BEGIN
    -- Datos de la producción
    SELECT 
        p.pro_id,
        p.pro_fecha,
        p.pro_cant_producida,
        p.pro_estado,
        p.pro_subtotal_mtpm,
        p.pro_subtotal_ins,
        p.pro_subtotal_mo,
        p.pro_subtotal_ci,
        p.pro_total,
        p.lote_PT
    FROM 
        produccion p
    WHERE 
        p.pro_id = pro_id;

    -- Detalles de la producción
    SELECT 
        pd.pdet_id,
        pd.pro_id,
        pd.id_inv,
        pd.pdet_cantidad_usada
    FROM 
        prod_detalle pd
    WHERE 
        pd.pro_id = pro_id;

    -- Costos de la producción
    SELECT 
        pc.cst_id,
        pc.pro_id,
        pc.cat_id,
        pc.cst_cant,
        pc.cst_presentacion,
        pc.cst_horas_persona,
        pc.cst_precio_ht,
        pc.cst_total_horas_actividad,
        pc.cst_costo_total
    FROM 
        prcostos pc
    WHERE 
        pc.pro_id = pro_id;

    -- Inventario de productos terminados
    SELECT 
        ipt.id_pt,
        ipt.pro_id,
        ipt.presentacion,
        ipt.cant_ingresada,
        ipt.cant_disponible,
        ipt.p_u,
        ipt.p_t,
        ipt.p_v_s,
        ipt.fecha_caducidad,
        ipt.composicion,
        ipt.estado,
        ipt.observacion
    FROM 
        inventario_pt ipt
    WHERE 
        ipt.pro_id = pro_id;
END $$

DELIMITER ;

CALL DetallesProd(32);