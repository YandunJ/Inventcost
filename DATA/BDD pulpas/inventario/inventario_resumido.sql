SELECT * FROM fpulpas.inventario;

CREATE TABLE `inventario` (
    id_inv INT AUTO_INCREMENT PRIMARY KEY, -- Clave principal
   fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Manejo automático
    cat_id INT NOT NULL, -- Relación con `catalogo`
    proveedor_id INT NOT NULL, -- Relación con `proveedores`

    -- Campos específicos de inventario
    lote VARCHAR(50) NOT NULL,
    presentacion VARCHAR(20) DEFAULT 'KILOGRAMOS', -- Valor predeterminado
    cant_ingresada DECI	MAL(10, 2) NOT NULL,
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

CREATE TRIGGER check_stock
BEFORE UPDATE ON inventario
FOR EACH ROW
BEGIN
    -- Verificar si la cantidad restante es menor que 0
    IF NEW.cant_restante < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se puede consumir más de lo disponible.';
    END IF;

    -- Actualizar estado según la cantidad restante
    IF NEW.cant_restante = 0 THEN
        SET NEW.estado = 'agotado';
    ELSEIF NEW.cant_restante < (NEW.cant_ingresada * 0.2) THEN
        SET NEW.estado = 'stock bajo';
    ELSE
        SET NEW.estado = 'disponible';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `Kardex_entradas`(
    IN p_articuloId INT,
    IN p_fechaInicio DATE,
    IN p_fechaFin DATE
)
BEGIN
    SELECT 
        inv.fecha_hora AS FechaHora,
        inv.lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.cat_nombre AS Articulo,
        inv.presentacion AS Presentacion,
        inv.cant_ingresada AS CantidadInicial,
        inv.cant_restante AS CantidadDisponible,
        inv.p_u AS PrecioUnitario,
        inv.p_t AS PrecioTotal,
        inv.estado AS Estado,
        inv.brix AS Brix,
        inv.observacion AS Observacion,
        'Entrada' AS TipoMovimiento
    FROM 
        inventario AS inv
    INNER JOIN 
        catalogo AS cat ON inv.cat_id = cat.cat_id
    INNER JOIN 
        proveedores AS prov ON inv.proveedor_id = prov.proveedor_id
    WHERE 
        inv.cat_id = p_articuloId
        AND inv.fecha_hora BETWEEN p_fechaInicio AND p_fechaFin
    ORDER BY 
        inv.fecha_hora DESC;
END$$

DELIMITER ;

CALL Kardex_entradas(2, '2024-12-01', '2024-12-31');

	DELIMITER $$

	CREATE PROCEDURE `Kardex_data`(
		IN p_fechaInicio DATE,
		IN p_fechaFin DATE,
		IN p_categoria INT
	)
	BEGIN
		SELECT 
			cat.cat_nombre AS articulo,
			ctg.ctg_nombre AS categoria,
			inv.presentacion,
			'Unidad' AS unidad, -- Ajusta esto si tienes un campo específico para la unidad
			SUM(inv.cant_ingresada) AS entradas,
			SUM(inv.cant_ingresada - inv.cant_restante) AS salidas,
			SUM(inv.cant_restante) AS saldo
		FROM 
			inventario AS inv
		INNER JOIN 
			catalogo AS cat ON inv.cat_id = cat.cat_id
		INNER JOIN 
			categorias AS ctg ON cat.ctg_id = ctg.ctg_id
		WHERE 
			inv.fecha_hora BETWEEN p_fechaInicio AND p_fechaFin
			AND cat.ctg_id = p_categoria
		GROUP BY 
			cat.cat_nombre, ctg.ctg_nombre, inv.presentacion
		ORDER BY 
			cat.cat_nombre;
	END$$

	DELIMITER ;
    
    -- Llamada al procedimiento almacenado Kardex_data
CALL Kardex_data('2024-12-01', '2024-12-31', 2);


DELIMITER $$

CREATE PROCEDURE `Kardex_movimientos`(
    IN p_articuloId INT,
    IN p_fechaInicio DATE,
    IN p_fechaFin DATE,
    IN p_tipoMovimiento VARCHAR(10) -- "Entrada" o "Salida"
)
BEGIN
    IF p_tipoMovimiento = 'Entrada' THEN
        SELECT 
            inv.fecha_hora AS FechaHora,
            inv.lote AS Lote,
            prov.nombre_empresa AS Proveedor,
            cat.cat_nombre AS Articulo,
            inv.presentacion AS Presentacion,
            inv.cant_ingresada AS CantidadInicial,
            inv.cant_restante AS CantidadDisponible,
            inv.p_u AS PrecioUnitario,
            inv.p_t AS PrecioTotal,
            inv.estado AS Estado,
            inv.brix AS Brix,
            inv.observacion AS Observacion
        FROM 
            inventario AS inv
        INNER JOIN 
            catalogo AS cat ON inv.cat_id = cat.cat_id
        INNER JOIN 
            proveedores AS prov ON inv.proveedor_id = prov.proveedor_id
        WHERE 
            inv.cat_id = p_articuloId
            AND inv.fecha_hora BETWEEN p_fechaInicio AND p_fechaFin
        ORDER BY 
            inv.fecha_hora DESC;
    ELSE
        -- Aquí se puede agregar la lógica para salidas si es necesario
        SELECT 'Salida lógica aún no implementada' AS Placeholder;
    END IF;
END$$

DELIMITER ;

CALL Kardex_movimientos(1, '2025-01-01', '2025-01-31', 'Entrada');


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mp_reg`(
    IN p_cat_id INT,
    IN p_proveedor_id INT,
    IN p_lote VARCHAR(50),
    IN p_cant_ingresada DECIMAL(10, 2),
    IN p_p_u DECIMAL(10, 2),
    IN p_p_t DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_observacion TEXT
)
BEGIN
    INSERT INTO inventario (
        cat_id, proveedor_id, lote, presentacion, 
        cant_ingresada, cant_restante, p_u, p_t, estado, 
        brix, fecha_elaboracion, fecha_caducidad, observacion
    )
    VALUES (
        p_cat_id, p_proveedor_id, p_lote, DEFAULT, -- 'DEFAULT' asigna el valor por defecto configurado en la tabla
        p_cant_ingresada, p_cant_ingresada, p_p_u, p_p_t, 'disponible', 
        p_brix, NULL, NULL, p_observacion
    );
END$$
DELIMITER ;


CALL mp_reg(
    4,                     -- cat_id
    5,                     -- proveedor_id
    'MP_2212241',          -- lote
    100.00,                -- cant_ingresada
    10.50,                 -- p_u
    1050.00,               -- p_t
    12.5,                  -- brix
    'Materia prima de alta calidad' -- observacion
);

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
call fpulpas.mp_data();


DELIMITER $$
CREATE PROCEDURE ins_reg(
    IN p_proveedor_id INT,
    IN p_cat_id INT,
    IN p_fecha_elaboracion DATE,
    IN p_fecha_caducidad DATE,
    IN p_lote VARCHAR(50),
    IN p_presentacion VARCHAR(20),
    IN p_cant_ingresada DECIMAL(10, 2),
    IN p_p_u DECIMAL(10, 2),
    IN p_p_t DECIMAL(10, 2)
)
BEGIN
    INSERT INTO inventario (
        fecha_hora,
        proveedor_id,
        cat_id,
        lote,
        presentacion,
        cant_ingresada,
        cant_restante,
        p_u,
        p_t,
        fecha_elaboracion,
        fecha_caducidad
    )
    VALUES (
        NOW(),
        p_proveedor_id,
        p_cat_id,
        p_lote,
        p_presentacion,
        p_cant_ingresada,
        p_cant_ingresada, -- cant_restante es igual a la ingresada inicialmente
        p_p_u,
        p_p_t,
        p_fecha_elaboracion,
        p_fecha_caducidad
    );
END$$
DELIMITER ;
CALL ins_reg(
    1,                     -- ID de proveedor
    5,                     -- ID de categoría (insumo)
    '2024-12-01',          -- Fecha de elaboración
    '2025-12-01',          -- Fecha de caducidad
    'INS_2212241',         -- Número de lote
    'Caja',                -- Presentación
    100,                   -- Cantidad ingresada
    50.00,                 -- Precio unitario
    5000.00                -- Precio total
);



DELIMITER $$
CREATE PROCEDURE ins_act(
    IN p_id_inv INT,
    IN p_proveedor_id INT,
    IN p_cat_id INT,
    IN p_fecha_elaboracion DATE,
    IN p_fecha_caducidad DATE,
    IN p_lote VARCHAR(50),
    IN p_presentacion VARCHAR(20),
    IN p_cant_ingresada DECIMAL(10, 2),
    IN p_p_u DECIMAL(10, 2),
    IN p_p_t DECIMAL(10, 2)
)
BEGIN
    UPDATE inventario
    SET
        proveedor_id = p_proveedor_id,
        cat_id = p_cat_id,
        lote = p_lote,
        presentacion = p_presentacion,
        cant_ingresada = p_cant_ingresada,
        cant_restante = p_cant_ingresada, -- También actualizamos la cantidad restante
        p_u = p_p_u,
        p_t = p_p_t,
        fecha_elaboracion = p_fecha_elaboracion,
        fecha_caducidad = p_fecha_caducidad
    WHERE id_inv = p_id_inv;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE ins_data()
BEGIN
    SELECT
        i.id_inv,
        i.fecha_hora,
        p.nombre_empresa AS proveedor,
        c.cat_nombre AS insumo,
        i.lote,
        i.presentacion,
        i.cant_ingresada,
        i.cant_restante,
        i.p_u,
        i.p_t,
        i.fecha_elaboracion,
        i.fecha_caducidad
    FROM inventario i
    JOIN proveedores p ON i.proveedor_id = p.proveedor_id
    JOIN catalogo c ON i.cat_id = c.cat_id
    WHERE c.ctg_id = 2; -- Suponiendo que "ctg_id = 1" diferencia los insumos
END$$
DELIMITER ;
	

DELIMITER $$
CREATE PROCEDURE ins_data_id(
    IN p_id_inv INT
)
BEGIN
    SELECT
        id_inv,
        fecha_hora,
        proveedor_id,
        cat_id,
        lote,
        presentacion,
        cant_ingresada,
        cant_restante,
        p_u,
        p_t,
        fecha_elaboracion,
        fecha_caducidad
    FROM inventario
    WHERE id_inv = p_id_inv;
END$$

DELIMITER ;

