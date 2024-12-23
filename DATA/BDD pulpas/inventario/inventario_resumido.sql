SELECT * FROM fpulpas.inventario;

CREATE TABLE `inventario` (
    id_inv INT AUTO_INCREMENT PRIMARY KEY, -- Clave principal
   fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Manejo automático
    cat_id INT NOT NULL, -- Relación con `catalogo`
    proveedor_id INT NOT NULL, -- Relación con `proveedores`

    -- Campos específicos de inventario
    lote VARCHAR(50) NOT NULL,
    presentacion VARCHAR(20) DEFAULT 'KILOGRAMOS', -- Valor predeterminado
    cant_ingresada DECIMAL(10, 2) NOT NULL,
    cant_restante DECIMAL(10, 2) NOT NULL,
    p_u DECIMAL(10, 2) NOT NULL, -- Precio unitario
    p_t DECIMAL(10, 2) NOT NULL, -- Precio total
    estado ENUM('disponible', 'stock bajo', 'agotado') DEFAULT 'disponible',

    -- Campos específicos según el tipo de producto
    brix DECIMAL(5, 2) DEFAULT NULL, -- Solo para materia prima
    fecha_elaboracion DATE DEFAULT NULL, -- Solo para insumos
    fecha_caducidad DATE DEFAULT NULL, -- Solo para insumos

    -- Observaciones y notas
    observacion TEXT DEFAULT NULL, 

    -- Claves foráneas
    FOREIGN KEY (cat_id) REFERENCES catalogo(cat_id),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id)
);

DELIMITER $$

CREATE PROCEDURE `mp_reg`(
    IN p_cat_id INT,
    IN p_proveedor_id INT,
    IN p_lote VARCHAR(50),
    IN p_presentacion VARCHAR(20),
    IN p_cant_ingresada DECIMAL(10, 2),
    IN p_p_u DECIMAL(10, 2),
    IN p_p_t DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_observacion TEXT
)
BEGIN
    -- Asignar 'KILOGRAMOS' si p_presentacion es NULL o vacío
    IF p_presentacion IS NULL OR p_presentacion = '' THEN
        SET p_presentacion = 'KILOGRAMOS';
    END IF;

    INSERT INTO inventario (
        cat_id, proveedor_id, lote, presentacion, 
        cant_ingresada, cant_restante, p_u, p_t, estado, 
        brix, fecha_elaboracion, fecha_caducidad, observacion
    )
    VALUES (
        p_cat_id, p_proveedor_id, p_lote, p_presentacion, 
        p_cant_ingresada, p_cant_ingresada, p_p_u, p_p_t, 'disponible', 
        p_brix, NULL, NULL, p_observacion
    );
END$$

DELIMITER ;

CALL mp_reg(
    2,                     -- cat_id
    5,                     -- proveedor_id
    'MP_2212241',          -- lote
    '',                    -- presentacion (vacío, se asignará 'KILOGRAMOS')
    100.00,                -- cant_ingresada
    10.50,                 -- p_u
    1050.00,               -- p_t
    12.5,                  -- brix
    'Materia prima de alta calidad' -- observacion
);



DELIMITER $$
CREATE PROCEDURE `mp_act`(
    IN p_id_inv INT,
    IN p_cat_id INT,
    IN p_proveedor_id INT,
    IN p_lote VARCHAR(50),
    IN p_presentacion VARCHAR(20),
    IN p_cant_ingresada DECIMAL(10, 2),
    IN p_cant_restante DECIMAL(10, 2),
    IN p_p_u DECIMAL(10, 2),
    IN p_p_t DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_observacion TEXT
)
BEGIN
    UPDATE inventario
    SET 
        cat_id = p_cat_id,
        proveedor_id = p_proveedor_id,
        lote = p_lote,
        presentacion = p_presentacion,
        cant_ingresada = p_cant_ingresada,
        cant_restante = p_cant_restante,
        p_u = p_p_u,
        p_t = p_p_t,
        brix = p_brix,
        observacion = p_observacion,
        fecha_elaboracion = NULL,
        fecha_caducidad = NULL
    WHERE id_inv = p_id_inv;
END$$
DELIMITER ;


CALL mp_act(
    1,                     -- id_inv
    
    1,                     -- cat_id
    3,                     -- proveedor_id
    'MP_2012241',          -- lote
    'kg',                  -- presentacion
    90.00,                 -- cant_ingresada
    90.00,                 -- cant_restante
    10.50,                 -- p_u
    945.00,                -- p_t
    12.5,                  -- brix
    'Actualización del registro de materia prima' -- observacion
);


DELIMITER $$

CREATE PROCEDURE `mp_data`()
BEGIN
    SELECT 
        i.id_inv AS ID,
        i.fecha_hora AS FechaHora,
        i.lote AS Lote,
        p.nombre_empresa AS Proveedor,
        c.cat_nombre AS Articulo,
        i.presentacion AS UnidadMedida,
        i.cant_ingresada AS CantidadIngresada,
        i.cant_restante AS CantidadDisponible,
        i.p_u AS PrecioUnitario,
        i.p_t AS PrecioTotal,
        i.estado AS Estado,
        i.brix AS Brix,
        i.observacion AS Observacion
    FROM inventario i
    INNER JOIN catalogo c ON i.cat_id = c.cat_id
    INNER JOIN proveedores p ON i.proveedor_id = p.proveedor_id
    WHERE i.brix IS NOT NULL; -- Filtra solo los registros de materia prima
END$$

DELIMITER ;

call fpulpas.mp_data();

