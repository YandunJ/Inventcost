CREATE TABLE `categorias` (
  `ctg_id` int NOT NULL AUTO_INCREMENT,
  `ctg_nombre` varchar(100) NOT NULL,
  `ctg_descripcion` text,
  PRIMARY KEY (`ctg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `presentacion` (
  `prs_id` int NOT NULL AUTO_INCREMENT,
  `prs_nombre` varchar(50) NOT NULL,
  `prs_abreviacion` varchar(10) DEFAULT NULL,
  `prs_estado` enum('vigente','descontinuado') NOT NULL DEFAULT 'vigente',
  `ctg_id` int DEFAULT NULL,
  `equivalencia` int DEFAULT NULL,
  PRIMARY KEY (`prs_id`),
  KEY `fk_categoria` (`ctg_id`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`ctg_id`) REFERENCES `categorias` (`ctg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `proveedores` (
  `proveedor_id` int NOT NULL AUTO_INCREMENT,
  `nombre_empresa` varchar(255) DEFAULT NULL,
  `representante` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `catalogo` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `cat_nombre` varchar(100) NOT NULL,
  `ctg_id` int NOT NULL,
  `prs_id` int NOT NULL,
  `cat_estado` enum('disponible','stock bajo','agotado','habilitado','deshabilitado') DEFAULT 'disponible',
  `cat_fecha_creacion` date NOT NULL,
  `cat_stock` int DEFAULT '0',
  PRIMARY KEY (`cat_id`),
  KEY `ctg_id` (`ctg_id`),
  KEY `prs_id` (`prs_id`),
  CONSTRAINT `catalogo_ibfk_1` FOREIGN KEY (`ctg_id`) REFERENCES `categorias` (`ctg_id`),
  CONSTRAINT `catalogo_ibfk_2` FOREIGN KEY (`prs_id`) REFERENCES `presentacion` (`prs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `inventario` (
  `id_inv` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cat_id` int NOT NULL,
  `proveedor_id` int NOT NULL,
  `lote` varchar(50) NOT NULL,
  `presentacion` varchar(20) DEFAULT 'KILOGRAMOS',
  `cant_ingresada` decimal(10,2) NOT NULL,
  `cant_restante` decimal(10,2) NOT NULL,
  `p_u` decimal(10,2) NOT NULL,
  `p_t` decimal(10,2) NOT NULL,
  `estado` enum('disponible','stock bajo','agotado') DEFAULT 'disponible',
  `brix` decimal(5,2) DEFAULT NULL,
  `fecha_elaboracion` date DEFAULT NULL,
  `fecha_caducidad` date DEFAULT NULL,
  `observacion` text,
  PRIMARY KEY (`id_inv`),
  KEY `cat_id` (`cat_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `catalogo` (`cat_id`),
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `produccion` (
  `pro_id` int NOT NULL AUTO_INCREMENT,
  `pro_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pro_cant_producida` decimal(10,2) DEFAULT NULL,
  `pro_estado` varchar(20) DEFAULT 'en proceso',
  `pro_subtotal_mtpm` decimal(10,2) DEFAULT '0.00',
  `pro_subtotal_ins` decimal(10,2) DEFAULT '0.00',
  `pro_subtotal_mo` decimal(10,2) DEFAULT '0.00',
  `pro_subtotal_ci` decimal(10,2) DEFAULT '0.00',
  `pro_total` decimal(10,2) DEFAULT '0.00',
  `lote_PT` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pro_id`),
  UNIQUE KEY `lote_PT` (`lote_PT`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `prod_detalle` (
  `pdet_id` int NOT NULL AUTO_INCREMENT,
  `pro_id` int NOT NULL,
  `id_inv` int NOT NULL,
  `pdet_cantidad_usada` decimal(10,2) NOT NULL,
  PRIMARY KEY (`pdet_id`),
  KEY `pro_id` (`pro_id`),
  KEY `id_inv` (`id_inv`),
  CONSTRAINT `prod_detalle_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `produccion` (`pro_id`) ON DELETE CASCADE,
  CONSTRAINT `prod_detalle_ibfk_2` FOREIGN KEY (`id_inv`) REFERENCES `inventario` (`id_inv`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `prcostos` (
  `cst_id` int NOT NULL AUTO_INCREMENT,
  `pro_id` int NOT NULL,
  `cat_id` int NOT NULL,
  `cst_cant` decimal(10,2) DEFAULT NULL,
  `cst_presentacion` varchar(20) DEFAULT 'UNIDADES',
  `cst_horas_persona` decimal(10,2) DEFAULT NULL,
  `cst_precio_ht` decimal(10,2) DEFAULT NULL,
  `cst_total_horas_actividad` decimal(10,2) DEFAULT NULL,
  `cst_costo_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cst_id`),
  KEY `pro_id` (`pro_id`),
  KEY `cat_id` (`cat_id`),
  CONSTRAINT `prcostos_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `produccion` (`pro_id`),
  CONSTRAINT `prcostos_ibfk_2` FOREIGN KEY (`cat_id`) REFERENCES `catalogo` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `kardex` (
  `id_kardex` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime NOT NULL,
  `cat_id` int NOT NULL,
  `lote` varchar(50) DEFAULT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `stock_anterior` decimal(10,2) DEFAULT NULL,
  `stock_actual` decimal(10,2) DEFAULT NULL,
  `tipo_movimiento` enum('entrada','salida','ajuste') NOT NULL,
  PRIMARY KEY (`id_kardex`),
  KEY `cat_id` (`cat_id`),
  CONSTRAINT `kardex_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `catalogo` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `inventario_pt` (
  `id_pt` int NOT NULL AUTO_INCREMENT,
  `pro_id` int NOT NULL,
  `presentacion` varchar(20) NOT NULL,
  `cant_ingresada` decimal(10,2) NOT NULL,
  `cant_disponible` decimal(10,2) NOT NULL,
  `p_u` decimal(10,2) NOT NULL,
  `p_t` decimal(10,2) NOT NULL,
  `p_v_s` decimal(10,2) DEFAULT NULL,
  `fecha_caducidad` date DEFAULT NULL,
  `composicion` text,
  `estado` enum('disponible','stock bajo','agotado') DEFAULT 'disponible',
  `observacion` text,
  PRIMARY KEY (`id_pt`),
  KEY `pro_id` (`pro_id`),
  CONSTRAINT `inventario_pt_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `produccion` (`pro_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `despacho_pt` (
  `id_despacho` int NOT NULL AUTO_INCREMENT,
  `fecha_despacho` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('activo','anulado') DEFAULT 'activo',
  `cantidad_total` decimal(10,2) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_despacho`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `det_despacho` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_despacho` int NOT NULL,
  `id_pt` int NOT NULL,
  `lote` varchar(50) NOT NULL,
  `cantidad_despachada` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_despacho` (`id_despacho`),
  KEY `id_pt` (`id_pt`),
  CONSTRAINT `det_despacho_ibfk_1` FOREIGN KEY (`id_despacho`) REFERENCES `despacho_pt` (`id_despacho`),
  CONSTRAINT `det_despacho_ibfk_2` FOREIGN KEY (`id_pt`) REFERENCES `inventario_pt` (`id_pt`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `kardex_PT` (
    `id_pt_kardex` INT AUTO_INCREMENT PRIMARY KEY,
    `fecha_hora` DATETIME NOT NULL,
    `id_pt` INT NOT NULL,
    `presentacion` VARCHAR(20) NOT NULL,
    `lote` VARCHAR(50) NOT NULL,
    `cantidad` DECIMAL(10, 2) NOT NULL,
    `stock_anterior` DECIMAL(10, 2) NOT NULL,
    `stock_actual` DECIMAL(10, 2) NOT NULL,
    `tipo_movimiento` ENUM('entrada', 'salida', 'ajuste') NOT NULL,
    `comprobante_despacho` VARCHAR(50) DEFAULT NULL,  -- Número de comprobante de despacho (solo para salidas)
    `observacion` TEXT,
    FOREIGN KEY (`id_pt`) REFERENCES `inventario_pt`(`id_pt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `usuarios` (
  `usu_id` int NOT NULL AUTO_INCREMENT,
  `usu_cedula` varchar(20) NOT NULL,
  `usu_nombre` varchar(255) NOT NULL,
  `usu_apellido` varchar(255) NOT NULL,
  `usu_telefono` varchar(15) DEFAULT NULL,
  `usu_usuario` varchar(50) NOT NULL,
  `usu_contrasenia` varchar(255) NOT NULL,
  `rol_id` int DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT NULL,
  `estado` enum('habilitado','deshabilitado') DEFAULT 'habilitado',
  `correo` varchar(255) NOT NULL,
  PRIMARY KEY (`usu_id`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roles` (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(45) NOT NULL,
  `rol_descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

