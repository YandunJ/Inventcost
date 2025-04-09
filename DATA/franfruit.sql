-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: fpulpas
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `catalogo`
--

DROP TABLE IF EXISTS `catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo`
--

LOCK TABLES `catalogo` WRITE;
/*!40000 ALTER TABLE `catalogo` DISABLE KEYS */;
INSERT INTO `catalogo` VALUES (15,'Maracuyá',1,1,'disponible','2025-03-08',0),(16,'Tomate de árbol',1,1,'disponible','2025-03-08',0),(17,'Funda de 1Kg',2,10,'disponible','2025-03-08',0),(18,'Fundas 150g',2,10,'disponible','2025-03-08',0),(19,'Funda de 100g',2,10,'disponible','2025-03-08',0),(20,'Fundas de Basura',2,10,'disponible','2025-03-08',0),(21,'Papel Absor.',2,17,'disponible','2025-03-08',0),(22,'Despulpado',4,1,'habilitado','2025-03-08',0),(23,'AGUA',5,1,'habilitado','2025-03-08',0),(24,'COCCIÓN',4,1,'habilitado','2025-03-10',0),(25,'ELECTRICIDAD',5,10,'habilitado','2025-03-10',0);
/*!40000 ALTER TABLE `catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `ctg_id` int NOT NULL AUTO_INCREMENT,
  `ctg_nombre` varchar(100) NOT NULL,
  `ctg_descripcion` text,
  PRIMARY KEY (`ctg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Materia Prima','Frutas para almacenamiento y uso en producción'),(2,'Insumos','Materiales utilizados en la producción'),(3,'Productos Terminado','Paquetes de Pulpa Procesada'),(4,'Mano de Obra','Actividades relacionadas con el trabajo realizado por empleados'),(5,'Costos Indirectos','Descripción de costos relacionados con la producción');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `despacho_pt`
--

DROP TABLE IF EXISTS `despacho_pt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despacho_pt` (
  `id_despacho` int NOT NULL AUTO_INCREMENT,
  `n_comprobante` varchar(20) NOT NULL,
  `fecha_despacho` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('activo','anulado') DEFAULT 'activo',
  `cantidad_total` decimal(10,2) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_despacho`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despacho_pt`
--

LOCK TABLES `despacho_pt` WRITE;
/*!40000 ALTER TABLE `despacho_pt` DISABLE KEYS */;
/*!40000 ALTER TABLE `despacho_pt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `det_despacho`
--

DROP TABLE IF EXISTS `det_despacho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `det_despacho`
--

LOCK TABLES `det_despacho` WRITE;
/*!40000 ALTER TABLE `det_despacho` DISABLE KEYS */;
/*!40000 ALTER TABLE `det_despacho` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pt_kar2` AFTER INSERT ON `det_despacho` FOR EACH ROW BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);
    DECLARE comprobante VARCHAR(20);

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex_PT
    WHERE id_pt = NEW.id_pt
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Obtener el número de comprobante de despacho
    SELECT n_comprobante INTO comprobante
    FROM despacho_pt
    WHERE id_despacho = NEW.id_despacho;

    -- Insertar registro en kardex_PT
    INSERT INTO kardex_PT (fecha_hora, id_pt, presentacion, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento, comprobante_despacho)
    VALUES (
        NOW(),  -- Fecha y hora actual
        NEW.id_pt,
        (SELECT presentacion FROM inventario_pt WHERE id_pt = NEW.id_pt),
        (SELECT pro_id FROM inventario_pt WHERE id_pt = NEW.id_pt),  -- Guardamos el pro_id en lugar del lote
        NEW.cantidad_despachada,
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) - NEW.cantidad_despachada,
        'salida',  -- Tipo de movimiento: salida
        comprobante  -- Número de comprobante de despacho
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (17,'2025-03-11 11:48:14',15,7,'MP_1103251','KILOGRAMOS',30.00,20.00,0.67,20.00,'disponible',8.00,NULL,NULL,''),(18,'2025-03-11 11:49:03',16,8,'MP_1103252','KILOGRAMOS',20.00,10.00,0.90,18.00,'disponible',9.00,NULL,NULL,''),(19,'2025-03-11 11:49:03',18,9,'INS_1103251','Unidades',100.00,98.00,0.22,22.00,'disponible',NULL,'2025-01-31','2025-05-03',NULL),(20,'2025-03-11 11:49:03',19,9,'INS_1103252','Unidades',200.00,194.00,0.07,14.00,'disponible',NULL,'2025-02-07','2025-05-01',NULL),(21,'2025-03-11 11:48:14',20,9,'INS_1103253','Unidades',30.00,28.00,0.20,6.00,'disponible',NULL,'2024-12-06','2025-07-30',NULL);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `kar1` AFTER INSERT ON `inventario` FOR EACH ROW BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex
    WHERE cat_id = NEW.cat_id
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Insertar registro en kardex
    INSERT INTO kardex (fecha_hora, cat_id, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento)
    VALUES (
        NEW.fecha_hora,
        NEW.cat_id,
        NEW.lote,
        NEW.cant_ingresada,
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) + NEW.cant_ingresada,
        'entrada'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `act_estado_inv` BEFORE UPDATE ON `inventario` FOR EACH ROW BEGIN
    -- Verificar si la cantidad restante es menor que 0
    IF NEW.cant_restante < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se puede consumir más de lo disponible.';
    END IF;

    -- Actualizar estado según la cantidad restante
    IF NEW.cant_restante = 0 THEN
        SET NEW.estado = 'agotado';
    ELSE
        SET NEW.estado = 'disponible';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `kar3` AFTER UPDATE ON `inventario` FOR EACH ROW BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);
    DECLARE cantidad_diferencia DECIMAL(10, 2);

    -- Calcular la diferencia en la cantidad
    SET cantidad_diferencia = NEW.cant_ingresada - OLD.cant_ingresada;

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex
    WHERE cat_id = NEW.cat_id
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Insertar registro de ajuste en kardex
    INSERT INTO kardex (fecha_hora, cat_id, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento)
    VALUES (
        NEW.fecha_hora,
        NEW.cat_id,
        NEW.lote,
        cantidad_diferencia,
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) + cantidad_diferencia,
        'ajuste'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `kar4` AFTER DELETE ON `inventario` FOR EACH ROW BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex
    WHERE cat_id = OLD.cat_id
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Insertar registro de ajuste en kardex
    INSERT INTO kardex (fecha_hora, cat_id, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento)
    VALUES (
        NOW(),  -- Fecha y hora actual
        OLD.cat_id,
        OLD.lote,
        -OLD.cant_ingresada,  -- Cantidad eliminada (negativa)
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) - OLD.cant_ingresada,
        'ajuste'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventario_pt`
--

DROP TABLE IF EXISTS `inventario_pt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_pt`
--

LOCK TABLES `inventario_pt` WRITE;
/*!40000 ALTER TABLE `inventario_pt` DISABLE KEYS */;
INSERT INTO `inventario_pt` VALUES (26,37,'Pulpa de Maracuyá 15',20.00,20.00,0.31,6.23,0.37,'2025-04-10','Maracuyá','disponible',NULL),(27,37,'Pulpa de Maracuyá 10',10.00,10.00,0.21,2.08,0.25,'2025-04-10','Maracuyá','disponible',NULL),(28,38,'Pulpa de Tomate 100g',20.00,20.00,0.42,8.37,0.50,'2025-04-10','Tomate de árbol','disponible',NULL),(29,38,'Pulpa de Tomate 150g',10.00,10.00,0.63,6.28,0.76,'2025-04-10','Tomate de árbol','disponible',NULL);
/*!40000 ALTER TABLE `inventario_pt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `composicion_pt` BEFORE INSERT ON `inventario_pt` FOR EACH ROW BEGIN
    DECLARE v_composicion TEXT DEFAULT '';
    DECLARE v_fruta_nombre VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;

    -- Cursor para obtener las frutas utilizadas en la producción
    DECLARE cur CURSOR FOR
        SELECT DISTINCT c.cat_nombre
        FROM prod_detalle pd
        JOIN inventario i ON pd.id_inv = i.id_inv
        JOIN catalogo c ON i.cat_id = c.cat_id
        JOIN categorias ct ON c.ctg_id = ct.ctg_id
        WHERE pd.pro_id = NEW.pro_id 
          AND ct.ctg_nombre = 'Materia Prima';

    -- Manejador para el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Determinar la composición de frutas
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_fruta_nombre;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Concatenar las frutas sin repetir
        IF v_composicion NOT LIKE CONCAT('%', v_fruta_nombre, '%') THEN
            SET v_composicion = CONCAT_WS(', ', v_composicion, v_fruta_nombre);
        END IF;
    END LOOP;
    CLOSE cur;

    -- Asignar la composición a NEW.composicion
    SET NEW.composicion = TRIM(LEADING ', ' FROM v_composicion);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pt_kar1` AFTER INSERT ON `inventario_pt` FOR EACH ROW BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);

    -- Obtener el saldo anterior (si existe)
    SELECT stock_actual INTO saldo_anterior
    FROM kardex_PT
    WHERE id_pt = NEW.id_pt
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Si no hay saldo anterior, establecerlo en 0
    IF saldo_anterior IS NULL THEN
        SET saldo_anterior = 0;
    END IF;

    -- Insertar registro en kardex_PT
    INSERT INTO kardex_PT (fecha_hora, id_pt, presentacion, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento, comprobante_despacho)
    VALUES (
        NOW(),  -- Fecha y hora actual
        NEW.id_pt,
        NEW.presentacion,
        NEW.pro_id,  -- Guardamos el pro_id en lugar del lote
        NEW.cant_ingresada,
        saldo_anterior,  -- Stock anterior
        saldo_anterior + NEW.cant_ingresada,  -- Stock actual
        'entrada',  -- Tipo de movimiento: entrada
        NULL  -- Comprobante de despacho (solo para salidas)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kardex`
--

DROP TABLE IF EXISTS `kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kardex`
--

LOCK TABLES `kardex` WRITE;
/*!40000 ALTER TABLE `kardex` DISABLE KEYS */;
INSERT INTO `kardex` VALUES (261,'2025-03-11 11:10:28',18,'INS_0803251',-1000.00,0.00,-1000.00,'ajuste'),(262,'2025-03-11 11:10:28',16,'MP_0803252',-46.00,0.00,-46.00,'ajuste'),(263,'2025-03-11 11:10:28',17,'INS_0803252',-200.00,0.00,-200.00,'ajuste'),(264,'2025-03-11 11:10:28',20,'INS_0803253',-30.00,0.00,-30.00,'ajuste'),(265,'2025-03-11 11:10:28',21,'INS_0803254',-1.00,0.00,-1.00,'ajuste'),(266,'2025-03-11 11:10:28',15,'MP_1103251',-10.00,0.00,-10.00,'ajuste'),(267,'2025-03-11 11:10:28',15,'MP_1103252',-10.00,-10.00,-20.00,'ajuste'),(268,'2025-03-11 11:15:23',15,'MP_1103251',30.00,-10.00,20.00,'entrada'),(269,'2025-03-11 11:18:36',16,'MP_1103252',20.00,-46.00,-26.00,'entrada'),(270,'2025-03-11 11:19:33',18,'INS_1103251',100.00,-1000.00,-900.00,'entrada'),(271,'2025-03-11 11:21:41',19,'INS_1103252',200.00,0.00,200.00,'entrada'),(272,'2025-03-11 11:23:54',20,'INS_1103253',30.00,-30.00,0.00,'entrada'),(273,'2025-03-11 11:15:23',15,'MP_1103251',10.00,20.00,10.00,'salida'),(274,'2025-03-11 11:48:14',15,'MP_1103251',0.00,10.00,10.00,'ajuste'),(275,'2025-03-11 11:21:41',19,'INS_1103252',3.00,200.00,197.00,'salida'),(276,'2025-03-11 11:48:14',19,'INS_1103252',0.00,200.00,200.00,'ajuste'),(277,'2025-03-11 11:23:54',20,'INS_1103253',2.00,0.00,-2.00,'salida'),(278,'2025-03-11 11:48:14',20,'INS_1103253',0.00,0.00,0.00,'ajuste'),(279,'2025-03-11 11:18:36',16,'MP_1103252',10.00,-26.00,-36.00,'salida'),(280,'2025-03-11 11:49:03',16,'MP_1103252',0.00,-26.00,-26.00,'ajuste'),(281,'2025-03-11 11:19:33',18,'INS_1103251',2.00,-900.00,-902.00,'salida'),(282,'2025-03-11 11:49:03',18,'INS_1103251',0.00,-900.00,-900.00,'ajuste'),(283,'2025-03-11 11:48:14',19,'INS_1103252',3.00,200.00,197.00,'salida'),(284,'2025-03-11 11:49:03',19,'INS_1103252',0.00,197.00,197.00,'ajuste');
/*!40000 ALTER TABLE `kardex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kardex_pt`
--

DROP TABLE IF EXISTS `kardex_pt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kardex_pt` (
  `id_pt_kardex` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime NOT NULL,
  `id_pt` int NOT NULL,
  `presentacion` varchar(20) NOT NULL,
  `lote` varchar(50) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `stock_anterior` decimal(10,2) NOT NULL,
  `stock_actual` decimal(10,2) NOT NULL,
  `tipo_movimiento` enum('entrada','salida','ajuste') NOT NULL,
  `comprobante_despacho` varchar(50) DEFAULT NULL,
  `observacion` text,
  PRIMARY KEY (`id_pt_kardex`),
  KEY `id_pt` (`id_pt`),
  CONSTRAINT `kardex_pt_ibfk_1` FOREIGN KEY (`id_pt`) REFERENCES `inventario_pt` (`id_pt`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kardex_pt`
--

LOCK TABLES `kardex_pt` WRITE;
/*!40000 ALTER TABLE `kardex_pt` DISABLE KEYS */;
INSERT INTO `kardex_pt` VALUES (11,'2025-03-11 11:48:14',26,'Pulpa de Maracuyá 15','37',20.00,0.00,20.00,'entrada',NULL,NULL),(12,'2025-03-11 11:48:14',27,'Pulpa de Maracuyá 10','37',10.00,0.00,10.00,'entrada',NULL,NULL),(13,'2025-03-11 11:49:03',28,'Pulpa de Tomate 100g','38',20.00,0.00,20.00,'entrada',NULL,NULL),(14,'2025-03-11 11:49:03',29,'Pulpa de Tomate 150g','38',10.00,0.00,10.00,'entrada',NULL,NULL);
/*!40000 ALTER TABLE `kardex_pt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prcostos`
--

DROP TABLE IF EXISTS `prcostos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prcostos`
--

LOCK TABLES `prcostos` WRITE;
/*!40000 ALTER TABLE `prcostos` DISABLE KEYS */;
INSERT INTO `prcostos` VALUES (79,37,22,1.00,'UNIDADES',0.50,0.50,0.50,0.25),(80,37,24,1.00,'UNIDADES',0.50,0.50,0.50,0.25),(81,37,23,1.00,'KILOGRAMOS',NULL,0.50,NULL,0.50),(82,37,25,1.00,'Unidades',NULL,0.00,NULL,0.00),(83,38,22,2.00,'UNIDADES',1.00,0.50,2.00,1.00),(84,38,24,2.00,'UNIDADES',1.00,1.00,2.00,2.00),(85,38,23,2.00,'KILOGRAMOS',NULL,0.50,NULL,1.00),(86,38,25,2.00,'Unidades',NULL,0.50,NULL,1.00);
/*!40000 ALTER TABLE `prcostos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentacion`
--

DROP TABLE IF EXISTS `presentacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentacion`
--

LOCK TABLES `presentacion` WRITE;
/*!40000 ALTER TABLE `presentacion` DISABLE KEYS */;
INSERT INTO `presentacion` VALUES (1,'KILOGRAMOS','kg','vigente',NULL,NULL),(10,'Unidades','und','vigente',2,NULL),(11,'Pulpa de Maracuyá 100g','','vigente',3,100),(12,'Pulpa de Maracuyá 150g','','vigente',3,150),(13,'Pulpa de Maracuyá 1000g','','vigente',3,1000),(14,'Pulpa de Tomate 100g','','vigente',3,100),(15,'Pulpa de Tomate 150g','','vigente',3,150),(16,'Pulpa de Tomate 1000g','','vigente',3,1000),(17,'Paquete','Pq','vigente',2,NULL);
/*!40000 ALTER TABLE `presentacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_detalle`
--

DROP TABLE IF EXISTS `prod_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_detalle`
--

LOCK TABLES `prod_detalle` WRITE;
/*!40000 ALTER TABLE `prod_detalle` DISABLE KEYS */;
INSERT INTO `prod_detalle` VALUES (89,37,17,10.00),(90,37,20,3.00),(91,37,21,2.00),(92,38,18,10.00),(93,38,19,2.00),(94,38,20,3.00);
/*!40000 ALTER TABLE `prod_detalle` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `kar2` AFTER INSERT ON `prod_detalle` FOR EACH ROW BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);

    -- Obtener el saldo anterior
    SELECT stock_actual INTO saldo_anterior
    FROM kardex
    WHERE cat_id = (SELECT cat_id FROM inventario WHERE id_inv = NEW.id_inv)
    ORDER BY fecha_hora DESC
    LIMIT 1;

    -- Insertar registro en kardex
    INSERT INTO kardex (fecha_hora, cat_id, lote, cantidad, stock_anterior, stock_actual, tipo_movimiento)
    VALUES (
        (SELECT fecha_hora FROM inventario WHERE id_inv = NEW.id_inv),
        (SELECT cat_id FROM inventario WHERE id_inv = NEW.id_inv),
        (SELECT lote FROM inventario WHERE id_inv = NEW.id_inv),
        NEW.pdet_cantidad_usada,  -- Registrar la salida como un valor positivo
        COALESCE(saldo_anterior, 0),
        COALESCE(saldo_anterior, 0) - NEW.pdet_cantidad_usada,  -- Ajustar el stock restando la cantidad usada
        'salida'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produccion`
--

DROP TABLE IF EXISTS `produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
INSERT INTO `produccion` VALUES (37,'2025-03-11 11:48:14',4000.00,'en proceso',0.00,0.00,0.00,0.00,0.00,'PT_1103251'),(38,'2025-03-11 11:49:03',3500.00,'en proceso',0.00,0.00,0.00,0.00,0.00,'PT_1103252');
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `proveedor_id` int NOT NULL AUTO_INCREMENT,
  `nombre_empresa` varchar(255) DEFAULT NULL,
  `representante` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (7,'Hoscar Garzón','Hoscar Garzón','franfruitss@gmail.com','0997760429','2025-03-08 21:22:03'),(8,'Johana Defaz','Johana Defaz','franfruitss@gmail.com','0988751443','2025-03-08 21:22:51'),(9,'Milanplastic','Marilyn Ramis','mramos@milanplastic.com.ec','0984189983','2025-03-08 21:23:39'),(10,'Frutas Luna','Luna','lnortiz@gmail.com','0982372372','2025-03-09 13:17:01');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(45) NOT NULL,
  `rol_descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Tiene acceso completo al sistema'),(2,'Bodeguero Materia Prima','Gestiona la materia prima en el inventario'),(3,'Encargado De Produccion','Encargado de la producción de productos');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (5,'1050478237','jefferson','yandun','9998080','Jefferson','$2y$10$NYKGNQz7SnU2Phzrat7uUeI2s6LsoghIDp94hYY9dwB1iuAgFKKdS',1,'2025-02-03 12:49:22','habilitado','jeffersonyandun01@gmail.com'),(9,'23423','Pablo','Marmol','34532','aaa','$2y$10$7nIhMkpeRGfmZHPYgYCgku/.IOhoJ6XW1qJ/aSEDfIhT4RWUbtjNC',1,'2025-02-04 12:21:13','habilitado','wylajaga@mailinator.com'),(10,'2384672','said','suarez','982379','pablo','$2y$10$tsGMceVOwtSKWNsSXHOW/.qvvNhgqw.81r3K.mkFemDdoQKDWsRDG',2,'2025-02-04 16:20:40','habilitado','hjsdbhjs@fksj'),(11,'92837423','Pepe','Perez','09493','aaa','$2y$10$ZtPaj4b.xITtK1t2q0MHe.qFCVu3VAPCc/M7DwXG7/FUQIMOqWYRO',3,'2025-02-04 16:21:42','habilitado','jizoli@mailinator.com'),(12,'347887734','pepe','perez','9384938','julio','$2y$10$ClZqh77ckTUSoTV2v6dRbuEPKSJwedoeLZoFm1kVxNBTjWZOc9ygm',3,'2025-02-04 16:35:19','habilitado','kjsdfjk@fksjd');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'fpulpas'
--

--
-- Dumping routines for database 'fpulpas'
--
/*!50003 DROP PROCEDURE IF EXISTS `acciones_empleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `acciones_empleado`(
    IN p_emp_id INT,
    IN p_cedula VARCHAR(10),
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(15),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(100)
)
BEGIN
    DECLARE emp_count INT;

    -- Verificar si ya existe un empleado con la misma cédula
    SELECT COUNT(*) INTO emp_count 
    FROM empleados 
    WHERE emp_cedula = p_cedula AND (emp_id != p_emp_id OR p_emp_id IS NULL);

    IF emp_count > 0 THEN
        -- Si ya existe, lanza un error o actualiza el registro en su lugar
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La cédula ya está registrada';
    ELSE
        -- Si p_emp_id es NULL o 0, significa que es una nueva inserción
        IF p_emp_id IS NULL OR p_emp_id = 0 THEN
            INSERT INTO empleados (emp_cedula, emp_nombre, emp_apellido, emp_telefono, emp_correo, emp_direccion)
            VALUES (p_cedula, p_nombre, p_apellido, p_telefono, p_correo, p_direccion);
        ELSE
            -- De lo contrario, se debe actualizar el registro existente
            UPDATE empleados
            SET emp_cedula = p_cedula,
                emp_nombre = p_nombre,
                emp_apellido = p_apellido,
                emp_telefono = p_telefono,
                emp_correo = p_correo,
                emp_direccion = p_direccion
            WHERE emp_id = p_emp_id;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `acciones_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `acciones_rol`(
    IN p_rol_id INT,
    IN p_rol_nombre VARCHAR(45),
    IN p_rol_descripcion VARCHAR(255),
    IN p_permiso_id INT
)
BEGIN
    DECLARE v_fecha_reg DATE;
    IF p_rol_id IS NULL THEN
        -- Insertar un nuevo rol
        SET v_fecha_reg = CURRENT_DATE;
        INSERT INTO roles (rol_nombre, rol_descripcion, permiso_id, fecha_registro)
        VALUES (p_rol_nombre, p_rol_descripcion, p_permiso_id, v_fecha_reg);
    ELSE
        -- Actualizar un rol existente
        UPDATE roles
        SET rol_nombre = p_rol_nombre,
            rol_descripcion = p_rol_descripcion,
            permiso_id = p_permiso_id
        WHERE rol_id = p_rol_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `acc_Invent_MP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `acc_Invent_MP`(
    IN p_id_inv INT,                -- Para identificar si se registra o actualiza
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_unidad_medida VARCHAR(20),             -- Unidad de medida (será 'kg' si no se proporciona)
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_cantidad_restante DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_estado ENUM('disponible', 'stock bajo', 'agotado'), -- Estado inicial (será 'disponible' si no se proporciona)
    IN p_bultos_o_canastas INT,                 -- Campos específicos de invent_detalle_MP
    IN p_peso_unitario DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_observacion TEXT,
    IN p_decision ENUM('aprobado', 'no aprobado') -- Estado de aprobación inicial (será 'no aprobado' si no se proporciona)
)
BEGIN
    DECLARE v_id_inv INT;

    -- Asignación de valores predeterminados para los campos opcionales
    SET p_unidad_medida = IFNULL(p_unidad_medida, 'kg');
    SET p_estado = IFNULL(p_estado, 'disponible');
    SET p_decision = IFNULL(p_decision, 'no aprobado');

    IF p_id_inv IS NULL THEN
        -- Inserción en la tabla inventario
        INSERT INTO inventario (
            fecha, hora, id_articulo, proveedor_id, numero_lote, 
            unidad_medida, cantidad_ingresada, cantidad_restante, 
            precio_unitario, presentacion, estado
        ) VALUES (
            p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote, 
            p_unidad_medida, p_cantidad_ingresada, p_cantidad_restante, 
            p_precio_unitario, p_presentacion, p_estado
        );

        -- Capturar el id generado
        SET v_id_inv = LAST_INSERT_ID();

        -- Inserción en la tabla invent_detalle_MP
        INSERT INTO invent_detalle_MP (
            id_inv, bultos_o_canastas, peso_unitario, brix, observacion, decision
        ) VALUES (
            v_id_inv, p_bultos_o_canastas, p_peso_unitario, p_brix, p_observacion, p_decision
        );

    ELSE
        -- Actualización en la tabla inventario
        UPDATE inventario
        SET
            fecha = p_fecha,
            hora = p_hora,
            id_articulo = p_id_articulo,
            proveedor_id = p_proveedor_id,
            numero_lote = p_numero_lote,
            unidad_medida = p_unidad_medida,
            cantidad_ingresada = p_cantidad_ingresada,
            cantidad_restante = p_cantidad_restante,
            precio_unitario = p_precio_unitario,
            presentacion = p_presentacion,
            estado = p_estado
        WHERE id_inv = p_id_inv;

        -- Actualización en la tabla invent_detalle_MP
        UPDATE invent_detalle_MP
        SET
            bultos_o_canastas = p_bultos_o_canastas,
            peso_unitario = p_peso_unitario,
            brix = p_brix,
            observacion = p_observacion,
            decision = p_decision
        WHERE id_inv = p_id_inv;

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarINS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarINS`(
    IN p_id_inv INT, -- ID del inventario a actualizar
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_unidad_medida VARCHAR(20)
)
BEGIN
    -- Actualización de un registro existente
    UPDATE inventario
    SET 
        fecha = p_fecha,
        hora = p_hora,
        id_articulo = p_id_articulo,
        proveedor_id = p_proveedor_id,
        numero_lote = p_numero_lote,
        unidad_medida = p_unidad_medida,
        cantidad_ingresada = p_cantidad_ingresada,
        cantidad_restante = p_cantidad_ingresada,
        precio_unitario = p_precio_unitario,
        precio_total = p_cantidad_ingresada * p_precio_unitario,
        presentacion = p_presentacion
    WHERE id_inv = p_id_inv;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarMP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarMP`(
    IN p_id_inv INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10,2),
    IN p_precio_unitario DECIMAL(10,2),
    IN p_presentacion VARCHAR(50),
    IN p_brix DECIMAL(5,2),
    IN p_bultos_o_canastas INT,
    IN p_peso_unitario DECIMAL(10,2),
    IN p_observacion TEXT
)
BEGIN
    -- Actualizar tabla inventario con los campos en el mismo orden del formulario
    UPDATE inventario
    SET 
        fecha = p_fecha,
        hora = p_hora,
        id_articulo = p_id_articulo,
        proveedor_id = p_proveedor_id,
        numero_lote = p_numero_lote,
        cantidad_ingresada = p_cantidad_ingresada,
        precio_unitario = p_precio_unitario,
        presentacion = p_presentacion
    WHERE id_inv = p_id_inv;
    
    -- Actualizar tabla invent_detalle_mp con los campos en el mismo orden del formulario
    UPDATE invent_detalle_mp
    SET 
        brix = p_brix,
        bultos_o_canastas = p_bultos_o_canastas,
        peso_unitario = p_peso_unitario,
        observacion = p_observacion
    WHERE id_inv = p_id_inv;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ac_InsertarINS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ac_InsertarINS`(
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_unidad_medida VARCHAR(20)
)
BEGIN
    -- Inserción de un nuevo registro
    INSERT INTO inventario (
        fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida,
        cantidad_ingresada, cantidad_restante, precio_unitario, presentacion, estado
    )
    VALUES (
        p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote, p_unidad_medida,
        p_cantidad_ingresada, p_cantidad_ingresada, p_precio_unitario, p_presentacion, 'disponible'
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ac_InsertarMP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ac_InsertarMP`(
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_bultos_o_canastas INT,
    IN p_peso_unitario DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_observacion TEXT
)
BEGIN
    DECLARE v_id_inv INT;

    -- Inicio de la transacción
    START TRANSACTION;

    -- Inserción en la tabla inventario (sin `precio_total` ya que es una columna generada)
    INSERT INTO inventario (
        fecha, hora, id_articulo, proveedor_id, numero_lote,
        cantidad_ingresada, cantidad_restante, 
        precio_unitario, presentacion
    ) VALUES (
        p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote,
        p_cantidad_ingresada, p_cantidad_ingresada, -- `cantidad_restante` inicial
        p_precio_unitario, p_presentacion
    );

    -- Obtener el último ID insertado en inventario
    SET v_id_inv = LAST_INSERT_ID();

    -- Inserción en la tabla invent_detalle_MP
    INSERT INTO invent_detalle_MP (
        id_inv, bultos_o_canastas, peso_unitario, 
        brix, observacion
    ) VALUES (
        v_id_inv, p_bultos_o_canastas, p_peso_unitario, 
        p_brix, p_observacion
    );

    -- Confirmación de la transacción
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Akardex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Akardex`(
    IN p_categoria_id INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    -- Obtener las entradas y salidas del mes actual y el saldo inicial por producto
    SELECT 
        c.cat_id,
        c.cat_nombre AS Producto,
        p.prs_nombre AS Presentación,
        COALESCE((
            SELECT stock_actual
            FROM kardex k2
            WHERE k2.cat_id = c.cat_id
            AND k2.fecha_hora < p_fecha_inicio
            ORDER BY k2.fecha_hora DESC
            LIMIT 1
        ), 0) AS Saldo_Inicial,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0) AS Entradas,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0) AS Salidas,
        (
            COALESCE((SELECT stock_actual FROM kardex k2 WHERE k2.cat_id = c.cat_id AND k2.fecha_hora < p_fecha_inicio ORDER BY k2.fecha_hora DESC LIMIT 1), 0)
            + COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0)
            - COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0)
        ) AS Saldo_Final
    FROM 
        catalogo c
    LEFT JOIN 
        kardex k ON c.cat_id = k.cat_id AND k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    LEFT JOIN 
        presentacion p ON c.prs_id = p.prs_id
    WHERE 
        c.ctg_id = p_categoria_id
    GROUP BY 
        c.cat_id, c.cat_nombre, p.prs_nombre
    HAVING 
        Saldo_Inicial > 0 OR Entradas > 0 OR Salidas > 0 OR Saldo_Final > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Catalogo_CRUD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Catalogo_CRUD`(
    IN p_opcion INT,
    IN p_cat_id INT,
    IN p_cat_nombre VARCHAR(100),
    IN p_ctg_id INT,
    IN p_prs_id INT
)
BEGIN
    DECLARE articulo_existente INT;

    IF p_opcion = 1 THEN
        SELECT COUNT(*) INTO articulo_existente
        FROM catalogo
        WHERE cat_nombre = p_cat_nombre AND prs_id = p_prs_id;

        IF articulo_existente > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El artículo ya está registrado con esta presentación.';
        ELSE
            INSERT INTO catalogo (cat_nombre, ctg_id, prs_id, cat_fecha_creacion)
            VALUES (p_cat_nombre, p_ctg_id, p_prs_id, CURDATE());
        END IF;

    ELSEIF p_opcion = 2 THEN
        UPDATE catalogo
        SET cat_nombre = p_cat_nombre,
            ctg_id = p_ctg_id,
            prs_id = p_prs_id
        WHERE cat_id = p_cat_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Catalogo_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Catalogo_data`()
BEGIN
    SELECT 
        cat.cat_id,
        cat.cat_nombre,
        cat.cat_estado,
        cat.cat_fecha_creacion,
        cat.cat_stock,
        c.ctg_nombre AS categoria,
        p.prs_nombre AS presentacion
    FROM catalogo cat
    INNER JOIN categorias c ON cat.ctg_id = c.ctg_id
    INNER JOIN presentacion p ON cat.prs_id = p.prs_id
    WHERE cat.ctg_id IN (1, 2, 3);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Catalogo_data_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Catalogo_data_id`(IN p_cat_id INT)
BEGIN
    SELECT 
        c.cat_id, 
        c.cat_nombre, 
        c.ctg_id, 
        c.prs_id 
    FROM catalogo c
    WHERE c.cat_id = p_cat_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Consumo_inv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Consumo_inv`(
    IN p_lote VARCHAR(255),
    IN p_cant_producida DECIMAL(10,2),
    IN p_estado VARCHAR(20),
    IN p_subtotal_mtpm DECIMAL(10,2),
    IN p_subtotal_ins DECIMAL(10,2),
    IN p_subtotal_mo DECIMAL(10,2),
    IN p_subtotal_ci DECIMAL(10,2),
    IN p_total DECIMAL(10,2),
    IN p_detalle JSON,
    IN p_mano_obra JSON,
    IN p_costos_indirectos JSON
)
BEGIN
    DECLARE last_pro_id INT;

    -- Insertar en la tabla produccion
    INSERT INTO produccion (pro_lote, pro_cant_producida, pro_estado, pro_subtotal_mtpm, pro_subtotal_ins, pro_subtotal_mo, pro_subtotal_ci, pro_total)
    VALUES (p_lote, p_cant_producida, p_estado, p_subtotal_mtpm, p_subtotal_ins, p_subtotal_mo, p_subtotal_ci, p_total);

    SET last_pro_id = LAST_INSERT_ID();

    -- Insertar en la tabla prod_detalle
    INSERT INTO prod_detalle (pro_id, inv_id, inv_lote, pdet_cantidad_usada, pdet_cantidad_producida, pdet_cantidad_desperdiciada)
    SELECT last_pro_id, JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.inv_id')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.inv_lote')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.pdet_cantidad_usada')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.pdet_cantidad_producida')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.pdet_cantidad_desperdiciada'))
    FROM JSON_TABLE(p_detalle, '$[*]' COLUMNS (value JSON PATH '$')) AS j;

    -- Insertar en la tabla mano_obra
    INSERT INTO mano_obra (pro_id, cat_id, mo_cant_personas, mo_precio_hora, mo_horas_trabajadas, mo_horas_totales, mo_costo_dia, mo_costo_total)
    SELECT last_pro_id, JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cat_id')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_cant_personas')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_precio_hora')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_horas_trabajadas')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_horas_totales')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_costo_dia')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.mo_costo_total'))
    FROM JSON_TABLE(p_mano_obra, '$[*]' COLUMNS (value JSON PATH '$')) AS j;

    -- Insertar en la tabla costos_indirectos
    INSERT INTO costos_indirectos (pro_id, cat_id, cost_cant, cost_unit, cost_total)
    SELECT last_pro_id, JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cat_id')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cost_cant')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cost_unit')), JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cost_total'))
    FROM JSON_TABLE(p_costos_indirectos, '$[*]' COLUMNS (value JSON PATH '$')) AS j;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Costos_CRUD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Costos_CRUD`(
    IN p_opcion INT,
    IN p_cat_id INT,
    IN p_cat_nombre VARCHAR(100),
    IN p_ctg_id INT,
    IN p_prs_id INT, -- Nuevo parámetro para presentación
    IN p_cat_estado ENUM('habilitado','deshabilitado')
)
BEGIN
    IF p_opcion = 1 THEN
        -- Registrar
        INSERT INTO catalogo (cat_nombre, ctg_id, prs_id, cat_estado, cat_fecha_creacion)
        VALUES (p_cat_nombre, p_ctg_id, IFNULL(p_prs_id, 1), p_cat_estado, CURDATE());
    ELSEIF p_opcion = 2 THEN
        -- Actualizar
        UPDATE catalogo
        SET cat_nombre = p_cat_nombre,
            ctg_id = p_ctg_id,
            prs_id = IFNULL(p_prs_id, prs_id), -- Mantener prs_id actual si no se proporciona uno nuevo
            cat_estado = p_cat_estado
        WHERE cat_id = p_cat_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Costos_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Costos_data`()
BEGIN
    SELECT 
        cat.cat_id,
        cat.cat_nombre,
        cat.cat_estado,
        p.prs_nombre, -- Agregar el nombre de la presentación
        cat.cat_fecha_creacion,
        c.ctg_nombre AS categoria
    FROM catalogo cat
    INNER JOIN categorias c ON cat.ctg_id = c.ctg_id
    LEFT JOIN presentacion p ON cat.prs_id = p.prs_id -- Unir con la tabla de presentaciones
    WHERE cat.ctg_id IN (4, 5);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Costos_data_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Costos_data_id`(IN p_cat_id INT)
BEGIN
    SELECT 
        c.cat_id, 
        c.cat_nombre, 
        c.ctg_id,
        c.cat_estado,
        c.prs_id ,
        cat.ctg_nombre AS categoria
    FROM catalogo c
    INNER JOIN categorias cat ON c.ctg_id = cat.ctg_id
    WHERE c.cat_id = p_cat_id AND c.ctg_id IN (4, 5);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DetalleKardex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleKardex`(
    IN p_cat_id INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        k.id_kardex,
        k.fecha_hora,
        k.cat_id,
        k.lote,
        k.cantidad,
        i.p_u AS precio_unitario,
        i.p_t AS precio_total,
        i.proveedor_id AS proveedor,
        CASE 
            WHEN c.ctg_id = 1 THEN i.brix
            ELSE NULL
        END AS brix,
        CASE 
            WHEN c.ctg_id = 1 THEN i.observacion
            ELSE NULL
        END AS observacion,
        CASE 
            WHEN c.ctg_id = 2 THEN i.fecha_elaboracion
            ELSE NULL
        END AS fecha_elaboracion,
        CASE 
            WHEN c.ctg_id = 2 THEN i.fecha_caducidad
            ELSE NULL
        END AS fecha_caducidad,
        k.tipo_movimiento
    FROM 
        kardex k
    JOIN 
        inventario i ON k.lote = i.lote
    JOIN 
        catalogo c ON k.cat_id = c.cat_id
    WHERE 
        k.cat_id = p_cat_id
        AND k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY 
        k.fecha_hora;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DetallesProd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetallesProd`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `elim_invCatalogo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `elim_invCatalogo`(IN p_id_articulo INT)
BEGIN
    DELETE FROM invent_catalogo WHERE id_articulo = p_id_articulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ESTCostosInd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ESTCostosInd`()
BEGIN
    SELECT COUNT(*) AS cantidad_costos_indirectos
    FROM catalogo
    WHERE ctg_id = 5;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ESTFrutas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ESTFrutas`()
BEGIN
    SELECT cat_nombre AS fruta, SUM(cant_restante) AS cantidad
    FROM inventario
    JOIN catalogo ON inventario.cat_id = catalogo.cat_id
    WHERE catalogo.ctg_id = 1
    GROUP BY cat_nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ESTManoObra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ESTManoObra`()
BEGIN
    SELECT COUNT(*) AS cantidad_mano_obra
    FROM catalogo
    WHERE ctg_id = 4;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ESTPresent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ESTPresent`()
BEGIN
    SELECT COUNT(*) AS cantidad_presentaciones
    FROM presentacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ESTProv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ESTProv`()
BEGIN
    SELECT COUNT(*) AS cantidad_proveedores
    FROM proveedores;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generar_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generar_lote`(
    IN id_categoria INT, -- ID de la categoría (1, 2, 3)
    OUT numero_lote VARCHAR(20)
)
BEGIN
    DECLARE prefijo VARCHAR(5);
    DECLARE fecha VARCHAR(6);
    DECLARE consecutivo INT;

    -- Determinar el prefijo según el ID de categoría
    CASE id_categoria
        WHEN 1 THEN SET prefijo = 'MP_';
        WHEN 2 THEN SET prefijo = 'INS_';
        WHEN 3 THEN SET prefijo = 'PT_';
        ELSE SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ID de categoría no válido';
    END CASE;

    -- Fecha en formato DDMMAA
    SET fecha = DATE_FORMAT(NOW(), '%d%m%y');

    -- Obtener el número consecutivo más alto para esa fecha y prefijo
    SELECT COALESCE(MAX(CAST(SUBSTRING(numero_lote, 8) AS UNSIGNED)), 0) + 1
    INTO consecutivo
    FROM inventario
    WHERE numero_lote LIKE CONCAT(prefijo, fecha, '%');

    -- Construir el número de lote
    SET numero_lote = CONCAT(prefijo, fecha, consecutivo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gestion_inventarioMP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `gestion_inventarioMP`(
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_articulo INT,
    IN p_proveedor_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_unidad_medida VARCHAR(50),
    IN p_cantidad_ingresada DECIMAL(10, 2),
    IN p_cantidad_restante DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_precio_total DECIMAL(10, 2),
    IN p_presentacion VARCHAR(50),
    IN p_estado ENUM('disponible', 'stock bajo', 'agotado'),
    IN p_observacion TEXT,
    IN p_peso DECIMAL(10, 2),
    IN p_brix DECIMAL(5, 2),
    IN p_id_inv INT  -- Para identificar si es actualización
)
BEGIN
    -- Comprobar si existe un registro con el ID dado
    IF EXISTS (SELECT 1 FROM inventario WHERE id_inv = p_id_inv) THEN
        -- Actualización en inventario
        UPDATE inventario
        SET 
            fecha = p_fecha,
            hora = p_hora,
            id_articulo = p_id_articulo,
            proveedor_id = p_proveedor_id,
            numero_lote = p_numero_lote,
            unidad_medida = p_unidad_medida,
            cantidad_ingresada = p_cantidad_ingresada,
            cantidad_restante = p_cantidad_restante,
            precio_unitario = p_precio_unitario,
            precio_total = p_precio_total,
            presentacion = p_presentacion,
            estado = p_estado
        WHERE id_inv = p_id_inv;

        -- Actualización en invent_detalle_MP
        UPDATE invent_detalle_MP
        SET 
            observacion = p_observacion,
            peso = p_peso,
            brix = p_brix
        WHERE id_inv = p_id_inv;
        
    ELSE
        -- Inserción en inventario
        INSERT INTO inventario (
            fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida,
            cantidad_ingresada, cantidad_restante, precio_unitario, precio_total,
            presentacion, estado
        ) VALUES (
            p_fecha, p_hora, p_id_articulo, p_proveedor_id, p_numero_lote, p_unidad_medida,
            p_cantidad_ingresada, p_cantidad_restante, p_precio_unitario, p_precio_total,
            p_presentacion, p_estado
        );

        -- Obtener el último id_inv generado
        SET @last_id_inv = LAST_INSERT_ID();

        -- Inserción en invent_detalle_MP usando el último ID de inventario
        INSERT INTO invent_detalle_MP (
            id_inv, observacion, peso, brix
        ) VALUES (
            @last_id_inv, p_observacion, p_peso, p_brix
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ins_act` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ins_act`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ins_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ins_data`()
BEGIN
    SELECT 
        i.id_inv AS ID,
        i.fecha_hora AS FechaHora,
        i.lote AS Lote,
        p.nombre_empresa AS Proveedor,
        c.cat_nombre AS Insumo,
        i.presentacion AS UnidadMedida,
        i.cant_ingresada AS CantidadIngresada,
        i.cant_restante AS CantidadRestante,
        i.p_u AS PrecioUnitario,
        i.p_t AS PrecioTotal,
        i.estado AS Estado,
        i.fecha_elaboracion AS FechaElaboracion,
        i.fecha_caducidad AS FechaCaducidad,
        i.observacion AS Observacion
    FROM inventario i
    INNER JOIN catalogo c ON i.cat_id = c.cat_id
    INNER JOIN proveedores p ON i.proveedor_id = p.proveedor_id
    WHERE c.ctg_id = 2; -- Filtra solo los registros de insumos
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ins_data_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ins_data_id`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ins_reg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ins_reg`(
    IN p_proveedor_id INT,
    IN p_cat_id INT,
    IN p_fecha_elaboracion DATE,
    IN p_fecha_caducidad DATE,
    IN p_lote VARCHAR(50),
    IN p_cant_ingresada DECIMAL(10, 2),
    IN p_p_u DECIMAL(10, 2),
    IN p_p_t DECIMAL(10, 2)
    )
BEGIN
    DECLARE v_presentacion VARCHAR(20);

    -- Obtener la presentación asociada al insumo (cat_id) desde la tabla catalogo
    SELECT prs_nombre INTO v_presentacion
    FROM catalogo
    JOIN presentacion ON catalogo.prs_id = presentacion.prs_id
    WHERE catalogo.cat_id = p_cat_id;

    -- Insertar el registro en la tabla inventario
    INSERT INTO inventario (
        fecha_hora, proveedor_id, cat_id, lote, presentacion, cant_ingresada, cant_restante, p_u, p_t, fecha_elaboracion, fecha_caducidad
    ) VALUES (
        NOW(), p_proveedor_id, p_cat_id, p_lote, v_presentacion, p_cant_ingresada, p_cant_ingresada, -- cant_restante es igual a la ingresada inicialmente
        p_p_u, p_p_t, p_fecha_elaboracion, p_fecha_caducidad
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `KardexGeneralPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `KardexGeneralPT`(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    -- Obtener las entradas y salidas del rango de fechas y el saldo inicial por presentación
    SELECT 
        k.presentacion AS Presentacion,
        COALESCE((
            SELECT stock_actual
            FROM kardex_PT k2
            WHERE k2.presentacion = k.presentacion
            AND k2.fecha_hora < p_fecha_inicio
            ORDER BY k2.fecha_hora DESC
            LIMIT 1
        ), 0) AS Saldo_Inicial,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0) AS Entradas,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0) AS Salidas,
        (
            COALESCE((SELECT stock_actual FROM kardex_PT k2 WHERE k2.presentacion = k.presentacion AND k2.fecha_hora < p_fecha_inicio ORDER BY k2.fecha_hora DESC LIMIT 1), 0)
            + COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0)
            - COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0)
        ) AS Saldo_Final
    FROM 
        kardex_PT k
    WHERE 
        k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY 
        k.presentacion
    HAVING 
        Saldo_Inicial > 0 OR Entradas > 0 OR Salidas > 0 OR Saldo_Final > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Kardex_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Kardex_data`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `kardex_det` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `kardex_det`(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_categoria_id INT,
    IN p_articulo_id INT
)
BEGIN
    SELECT 
        i.fecha_hora AS `Fecha y Hora`,
        i.lote AS Lote,
        pr.nombre_empresa AS Proveedor,
        ca.cat_nombre AS Artículo,
        p.prs_nombre AS Presentación,
        i.cant_ingresada AS Cantidad,
        i.p_u AS `Precio Unitario`,
        i.p_t AS `Precio Total`,
        'Entrada' AS `Tipo de Movimiento`
    FROM inventario i
    LEFT JOIN catalogo ca ON i.cat_id = ca.cat_id
    LEFT JOIN presentacion p ON ca.prs_id = p.prs_id
    LEFT JOIN proveedores pr ON i.proveedor_id = pr.proveedor_id
    WHERE (i.fecha_hora BETWEEN p_fecha_inicio AND DATE_ADD(p_fecha_fin, INTERVAL 1 DAY))
      AND (ca.ctg_id = p_categoria_id OR p_categoria_id = 0)
      AND (ca.cat_id = p_articulo_id OR p_articulo_id = 0)
    
    UNION ALL
    
    SELECT 
        i.fecha_hora AS `Fecha y Hora`,
        i.lote AS Lote,
        NULL AS Proveedor,
        ca.cat_nombre AS Artículo,
        p.prs_nombre AS Presentación,
        pd.pdet_cantidad_usada AS Cantidad,
        i.p_u AS `Precio Unitario`,
        (pd.pdet_cantidad_usada * i.p_u) AS `Precio Total`,
        'Salida' AS `Tipo de Movimiento`
    FROM prod_detalle pd
    INNER JOIN inventario i ON pd.id_inv = i.id_inv
    LEFT JOIN catalogo ca ON i.cat_id = ca.cat_id
    LEFT JOIN presentacion p ON ca.prs_id = p.prs_id
    WHERE (i.fecha_hora BETWEEN p_fecha_inicio AND DATE_ADD(p_fecha_fin, INTERVAL 1 DAY))
      AND (ca.ctg_id = p_categoria_id OR p_categoria_id = 0)
      AND (ca.cat_id = p_articulo_id OR p_articulo_id = 0)
    
    ORDER BY `Fecha y Hora`, `Tipo de Movimiento`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Kardex_entradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Kardex_entradas`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `kardex_G` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `kardex_G`(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_categoria_id INT
)
BEGIN
    SELECT 
        i.cat_id AS ID,
        ca.cat_nombre AS Artículo,
        p.prs_nombre AS Presentación,
        SUM(i.cant_ingresada) AS Entradas,
        IFNULL(SUM(pd.pdet_cantidad_usada), 0) AS Salidas,
        SUM(i.cant_ingresada) - IFNULL(SUM(pd.pdet_cantidad_usada), 0) AS Saldo
    FROM inventario i
    JOIN catalogo ca ON i.cat_id = ca.cat_id
    LEFT JOIN presentacion p ON ca.prs_id = p.prs_id
    LEFT JOIN prod_detalle pd ON i.id_inv = pd.id_inv
    WHERE i.fecha_hora BETWEEN p_fecha_inicio AND DATE_ADD(p_fecha_fin, INTERVAL 1 DAY)
      AND (ca.ctg_id = p_categoria_id OR p_categoria_id = 0)
    GROUP BY i.cat_id, ca.cat_nombre, p.prs_nombre
    ORDER BY ca.cat_nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Kardex_movimientos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Kardex_movimientos`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mp_act` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mp_act`(
    IN p_id_inv INT,
    IN p_cat_id INT,
    IN p_proveedor_id INT,
    IN p_cant_ingresada DECIMAL(10,2),
    IN p_precio_total DECIMAL(10,2),
    IN p_precio_unitario DECIMAL(10,2),
    IN p_brix DECIMAL(5,2),
    IN p_observacion TEXT
)
BEGIN
    UPDATE inventario
    SET 
        cat_id = p_cat_id,
        proveedor_id = p_proveedor_id,
        cant_ingresada = p_cant_ingresada,
        p_t = p_precio_total,
        p_u = p_precio_unitario,
        brix = p_brix,
        observacion = p_observacion,
        fecha_hora = NOW()
    WHERE id_inv = p_id_inv;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mp_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mp_data`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mp_data_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mp_data_id`(
    IN p_id_inv INT
)
BEGIN
    -- Verificar si se ha hecho algún consumo de este lote en producción
    IF (SELECT COUNT(*) FROM prod_detalle WHERE id_inv = p_id_inv) > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede editar este lote porque ya se ha hecho un consumo en producción.';
    ELSE
        SELECT 
            i.id_inv,
            i.fecha_hora AS fecha,
            i.fecha_hora AS hora,
            i.cat_id AS id_articulo,
            i.proveedor_id,
            i.lote AS numero_lote,
            i.cant_ingresada AS cantidad_ingresada,
            i.p_t AS precio_total,
            i.presentacion,
            i.brix,
            i.observacion
        FROM inventario i
        WHERE i.id_inv = p_id_inv;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mp_elm` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mp_elm`(
    IN p_id_inv INT
)
BEGIN
    -- Verificar si se ha hecho algún consumo de este lote en producción
    IF (SELECT COUNT(*) FROM prod_detalle WHERE id_inv = p_id_inv) > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar este lote porque ya se ha hecho un consumo en producción.';
    ELSE
        DELETE FROM inventario WHERE id_inv = p_id_inv;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mp_reg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtInvenRES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtInvenRES`()
BEGIN
    SELECT 
        i.id_inv AS ID,
        i.fecha AS Fecha,
        i.hora AS Hora,
        i.numero_lote AS Lote,
        p.nombre_empresa AS Proveedor,
        a.nombre_articulo AS Articulo,
        i.cantidad_restante AS CantidadDisponible,
        i.estado AS Estado,
        i.precio_total AS PrecioTotal
    FROM 
        inventario AS i
    JOIN 
        proveedores AS p ON i.proveedor_id = p.id_proveedor
    JOIN 
        invent_catalogo AS a ON i.id_articulo = a.id_articulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Obt_INS_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Obt_INS_por_id`(IN p_inventins_id INT)
BEGIN
    SELECT 
        id_inv, 
        fecha, 
        hora, 
        id_articulo, 
        proveedor_id, 
        numero_lote, 
        unidad_medida, 
        cantidad_ingresada, 
        presentacion, 
        unidad_medida,
        precio_unitario, 
        precio_total
    FROM 
        inventario
    WHERE 
        id_inv = p_inventins_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obt_inventario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obt_inventario`()
BEGIN
    SELECT id_inv, fecha, hora, id_articulo, proveedor_id, numero_lote, unidad_medida, cantidad_ingresada, cantidad_restante, 
			precio_unitario, precio_total, presentacion, estado 
    FROM inventario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_eliminar_empleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_empleado`(
    IN p_emp_id INT,
    IN p_emp_cedula VARCHAR(20)
)
BEGIN
    DECLARE v_usuario_count INT;

    -- Verificar si el empleado es también un usuario
    SELECT COUNT(*) INTO v_usuario_count
    FROM usuarios
    WHERE usu_cedula = p_emp_cedula;

    -- Si el empleado no es usuario, permitir eliminar
    IF v_usuario_count = 0 THEN
        DELETE FROM empleados WHERE emp_id = p_emp_id;
    ELSE
        -- Si el empleado es usuario, no permitir eliminar
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar un empleado que también es usuario.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_eliminar_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_rol`(
    IN p_rol_id INT
)
BEGIN
    DELETE FROM roles
    WHERE rol_id = p_rol_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_eliminar_usu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_usu`(
    IN p_usu_id INT
)
BEGIN
    DECLARE v_usu_cedula VARCHAR(20);

    -- Obtener la cédula del usuario a eliminar
    SELECT usu_cedula INTO v_usu_cedula
    FROM usuarios
    WHERE usu_id = p_usu_id;

    -- Eliminar el registro del usuario
    DELETE FROM usuarios WHERE usu_id = p_usu_id;

    -- Eliminar el registro del empleado asociado
    DELETE FROM empleados WHERE emp_cedula = v_usu_cedula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obtener_roles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obtener_roles`()
BEGIN
    SELECT r.rol_id, 
           r.rol_nombre, 
           r.rol_descripcion, 
           p.permiso_nombre AS permiso_nombre, -- Cambia esto para seleccionar el nombre del permiso
           r.fecha_registro
    FROM roles r
    LEFT JOIN permisos p ON r.permiso_id = p.permiso_id; -- Asegúrate de que se haga un JOIN para obtener el nombre del permiso
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obtener_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obtener_usuarios`()
BEGIN
    SELECT usu_id, usu_cedula, usu_nombre, usu_apellido, usu_telefono, usu_correo, usu_direccion, usu_usuario, rol_id, fecha_reg
    FROM usuarios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obt_empleados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obt_empleados`()
BEGIN
    SELECT * FROM empleados;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROD_data_G` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROD_data_G`()
BEGIN
    -- Calcular subtotales de materia prima e insumos
    SELECT 
        p.pro_id,
        p.pro_fecha,
        p.pro_cant_producida,
        p.lote_PT,
        -- Subtotal de materia prima
        ROUND(
            IFNULL((
                SELECT SUM(pd.pdet_cantidad_usada * i.p_u)
                FROM prod_detalle pd
                LEFT JOIN inventario i ON pd.id_inv = i.id_inv
                WHERE pd.pro_id = p.pro_id AND i.lote LIKE 'MP%'
            ), 0), 2
        ) AS pro_subtotal_mtpm,
        
        -- Subtotal de insumos
        ROUND(
            IFNULL((
                SELECT SUM(pd.pdet_cantidad_usada * i.p_u)
                FROM prod_detalle pd
                LEFT JOIN inventario i ON pd.id_inv = i.id_inv
                WHERE pd.pro_id = p.pro_id AND i.lote LIKE 'INS%'
            ), 0), 2
        ) AS pro_subtotal_ins,
        
        -- Subtotal de mano de obra
        ROUND(
            IFNULL((
                SELECT SUM(pc.cst_costo_total)
                FROM prcostos pc
                WHERE pc.pro_id = p.pro_id AND pc.cst_presentacion = 'UNIDADES'
            ), 0), 2
        ) AS pro_subtotal_mo,
        
        -- Subtotal de costos indirectos
        ROUND(
            IFNULL((
                SELECT SUM(pc.cst_costo_total)
                FROM prcostos pc
                WHERE pc.pro_id = p.pro_id AND pc.cst_presentacion != 'UNIDADES'
            ), 0), 2
        ) AS pro_subtotal_ci,
        
        -- Total de producción
        ROUND(
            IFNULL((
                SELECT SUM(pd.pdet_cantidad_usada * i.p_u)
                FROM prod_detalle pd
                LEFT JOIN inventario i ON pd.id_inv = i.id_inv
                WHERE pd.pro_id = p.pro_id AND i.lote LIKE 'MP%'
            ), 0) + 
            IFNULL((
                SELECT SUM(pd.pdet_cantidad_usada * i.p_u)
                FROM prod_detalle pd
                LEFT JOIN inventario i ON pd.id_inv = i.id_inv
                WHERE pd.pro_id = p.pro_id AND i.lote LIKE 'INS%'
            ), 0) + 
            IFNULL((
                SELECT SUM(pc.cst_costo_total)
                FROM prcostos pc
                WHERE pc.pro_id = p.pro_id AND pc.cst_presentacion = 'UNIDADES'
            ), 0) + 
            IFNULL((
                SELECT SUM(pc.cst_costo_total)
                FROM prcostos pc
                WHERE pc.pro_id = p.pro_id AND pc.cst_presentacion != 'UNIDADES'
            ), 0), 
        2
        ) AS pro_total
    FROM produccion p
    GROUP BY p.pro_id, p.pro_fecha, p.pro_cant_producida, p.lote_PT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROD_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROD_detalle`(IN pro_id INT)
BEGIN
    -- Seleccionar los detalles de la producción
    SELECT 
        p.pro_fecha,
        p.pro_cant_producida,
        p.pro_estado,
        p.pro_subtotal_mtpm,
        p.pro_subtotal_ins,
        p.pro_subtotal_mo,
        p.pro_subtotal_ci,
        p.pro_total
    FROM 
        produccion p
    WHERE 
        p.pro_id = pro_id;

    -- Seleccionar los lotes consumidos en la producción
    SELECT 
        pd.id_inv,
        pd.pdet_cantidad_usada
    FROM 
        prod_detalle pd
    WHERE 
        pd.pro_id = pro_id;

    -- Seleccionar los costos asociados a la producción
    SELECT 
        c.cst_id,
        c.cat_id,
        c.cst_cant,
        c.cst_presentacion,
        c.cst_horas_persona,
        c.cst_precio_ht,
        c.cst_total_horas_actividad,
        c.cst_costo_total
    FROM 
        prcostos c
    WHERE 
        c.pro_id = pro_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROD_sp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROD_sp`(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON,
    IN mano_obra JSON,
    IN costos_indirectos JSON -- Entrada para costos indirectos
)
BEGIN
    DECLARE pro_id INT;
    DECLARE i INT DEFAULT 0;
    DECLARE inv_id INT;
    DECLARE cant DECIMAL(10, 2);
    DECLARE horas_persona DECIMAL(10, 2);
    DECLARE precio_ht DECIMAL(10, 2);
    DECLARE costo_total DECIMAL(10, 2);
    DECLARE total_horas DECIMAL(10, 2); -- Variable para el total de horas trabajadas por actividad
    DECLARE cant_restante DECIMAL(10, 2); -- Variable para almacenar la cantidad restante en inventario
    DECLARE mensaje_error VARCHAR(255);
    DECLARE cat_id INT; -- Agregado para declarar la variable cat_id

    -- Insertar en producción
    INSERT INTO produccion (pro_cant_producida)
    VALUES (cant_producida);
    SET pro_id = LAST_INSERT_ID();

    -- Procesar lotes de materia prima
    IF JSON_LENGTH(lotes_mp) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(lotes_mp) DO
            SET inv_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].id_inv')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].cantidad')));

            -- Verificar la cantidad restante en inventario
            SELECT cant_restante INTO cant_restante
            FROM inventario
            WHERE id_inv = inv_id;

            -- Si la cantidad restante es insuficiente, abortar el proceso
            IF cant_restante < cant THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente cantidad en inventario para el lote ', inv_id);
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
            ELSE
                -- Actualizar inventario (restar la cantidad utilizada)
                UPDATE inventario
                SET cant_restante = cant_restante - cant
                WHERE id_inv = inv_id AND cant_restante >= cant;

                -- Insertar en detalle de producción
                INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
                VALUES (pro_id, inv_id, cant);
            END IF;

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar lotes de insumos
    IF JSON_LENGTH(lotes_ins) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(lotes_ins) DO
            SET inv_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].id_inv')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].cantidad')));

            -- Verificar la cantidad restante en inventario
            SELECT cant_restante INTO cant_restante
            FROM inventario
            WHERE id_inv = inv_id;

            -- Si la cantidad restante es insuficiente, abortar el proceso
            IF cant_restante < cant THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente cantidad en inventario para el lote ', inv_id);
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
            ELSE
                -- Actualizar inventario (restar la cantidad utilizada)
                UPDATE inventario
                SET cant_restante = cant_restante - cant
                WHERE id_inv = inv_id AND cant_restante >= cant;

                -- Insertar en detalle de producción
                INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
                VALUES (pro_id, inv_id, cant);
            END IF;

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar mano de obra
    IF JSON_LENGTH(mano_obra) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(mano_obra) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].cat_id')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_cant_personas')));
            SET horas_persona = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_horas_trabajadas')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_precio_hora')));
            SET total_horas = cant * horas_persona; -- Total de horas de trabajo para la actividad
            SET costo_total = total_horas * precio_ht; -- Costo total

            -- Insertar en costos
            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_horas_persona, cst_precio_ht, cst_total_horas_actividad, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cant, 'UNIDADES', horas_persona, precio_ht, total_horas, costo_total
            );

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar costos indirectos
    IF JSON_LENGTH(costos_indirectos) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(costos_indirectos) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cat_id')));
            SET cant = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_cant')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_precio_ht')));
            SET costo_total = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_costo_total')));

            -- Calcular el costo total si no se pasa el valor, usando cantidad y precio unitario
            IF costo_total IS NULL THEN
                SET costo_total = cant * precio_ht;
            END IF;

            -- Insertar en costos
            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_precio_ht, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cant, 'UNIDADES', precio_ht, costo_total
            );

            SET i = i + 1;
        END WHILE;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prov_CRUD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prov_CRUD`(
    IN p_accion INT, -- 1: Registrar, 2: Actualizar
    IN p_proveedor_id INT,
    IN p_nombre_empresa VARCHAR(255),
    IN p_representante VARCHAR(255),
    IN p_correo VARCHAR(255),
    IN p_telefono VARCHAR(50)
)
BEGIN
    DECLARE v_fecha_reg TIMESTAMP;

    IF p_accion = 1 THEN
        -- Registrar un nuevo proveedor
        SET v_fecha_reg = CURRENT_TIMESTAMP;
        INSERT INTO proveedores (nombre_empresa, representante, correo, telefono, fecha_reg)
        VALUES (p_nombre_empresa, p_representante, p_correo, p_telefono, v_fecha_reg);
    ELSEIF p_accion = 2 THEN
        -- Actualizar un proveedor existente
        UPDATE proveedores
        SET nombre_empresa = p_nombre_empresa,
            representante = p_representante,
            correo = p_correo,
            telefono = p_telefono
        WHERE proveedor_id = p_proveedor_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prov_datos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prov_datos`()
BEGIN
    SELECT proveedor_id, nombre_empresa, representante, correo, telefono, fecha_reg
    FROM proveedores;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prov_datos_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prov_datos_id`(
    IN p_proveedor_id INT
)
BEGIN
    SELECT proveedor_id, nombre_empresa, representante, correo, telefono, fecha_reg
    FROM proveedores
    WHERE proveedor_id = p_proveedor_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prov_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prov_eliminar`(
    IN p_proveedor_id INT
)
BEGIN
    DELETE FROM proveedores WHERE proveedor_id = p_proveedor_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PR_cancelar_prod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_cancelar_prod`(
    IN p_pro_id INT -- ID de la producción a cancelar
)
BEGIN
    DECLARE v_lote_id INT;
    DECLARE v_cantidad DECIMAL(10,2);
    DECLARE v_despachos INT;
    DECLARE done INT DEFAULT FALSE;

    -- Cursor para recorrer los consumos de la producción
    DECLARE cur CURSOR FOR
        SELECT id_inv, pdet_cantidad_usada
        FROM prod_detalle
        WHERE pro_id = p_pro_id;

    -- Manejador para cuando no haya más registros en el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Validar que no se hayan realizado despachos de las presentaciones del lote de PT
    SELECT COUNT(*) INTO v_despachos
    FROM det_despacho dd
    INNER JOIN inventario_pt ipt ON dd.id_pt = ipt.id_pt
    WHERE ipt.pro_id = p_pro_id;

    IF v_despachos > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede cancelar la producción porque se han realizado despachos de las presentaciones del lote de PT.';
    END IF;

    -- Iniciar la reversión de los consumos
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_lote_id, v_cantidad;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Revertir el consumo: aumentar la cantidad disponible en el lote
        UPDATE inventario
        SET cant_restante = cant_restante + v_cantidad
        WHERE id_inv = v_lote_id;
    END LOOP;
    CLOSE cur;

    -- Eliminar los lotes de PT asociados a la producción
    DELETE FROM inventario_pt WHERE pro_id = p_pro_id;

    -- Eliminar los costos asociados a la producción
    DELETE FROM prcostos WHERE pro_id = p_pro_id;

    -- Eliminar los consumos de la producción
    DELETE FROM prod_detalle WHERE pro_id = p_pro_id;

    -- Eliminar la producción
    DELETE FROM produccion WHERE pro_id = p_pro_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PR_consumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PR_consumo`(
    IN cant_producida DECIMAL(10, 2),
    IN lotes_mp JSON,
    IN lotes_ins JSON,
    IN mano_obra JSON,
    IN costos_indirectos JSON,
    IN lote_pt VARCHAR(50),
    OUT pro_id INT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE lote_id INT;
    DECLARE cantidad DECIMAL(10, 2);
    DECLARE precio DECIMAL(10, 2);
    DECLARE stock_actual DECIMAL(10, 2);
    DECLARE mensaje_error VARCHAR(255);
    DECLARE prev_safe_updates INT;
    DECLARE cat_id INT;
    DECLARE horas_persona DECIMAL(10, 2);
    DECLARE precio_ht DECIMAL(10, 2);
    DECLARE costo_total DECIMAL(10, 2);
    DECLARE total_horas DECIMAL(10, 2);
    DECLARE presentacion VARCHAR(20);

    -- Guardar estado original de SQL_SAFE_UPDATES
    SET prev_safe_updates = @@SQL_SAFE_UPDATES;
    SET SQL_SAFE_UPDATES = 0;

    -- Insertar en producción
    INSERT INTO produccion (pro_cant_producida, lote_PT)
    VALUES (cant_producida, lote_pt);
    SET pro_id = LAST_INSERT_ID(); -- Obtener el ID de la producción recién insertada

    -- Procesar lotes de materia prima
    IF JSON_LENGTH(lotes_mp) > 0 THEN
        WHILE i < JSON_LENGTH(lotes_mp) DO
            SET lote_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].id_inv')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(lotes_mp, CONCAT('$[', i, '].cantidad')));

            SELECT cant_restante INTO stock_actual
            FROM inventario
            WHERE id_inv = lote_id;

            IF stock_actual < cantidad THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente stock en el lote ', lote_id, '. Stock disponible: ', stock_actual);
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = mensaje_error;
            END IF;

            SELECT p_u INTO precio FROM inventario WHERE id_inv = lote_id;

            INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
            VALUES (pro_id, lote_id, cantidad);

            UPDATE inventario
            SET cant_restante = cant_restante - cantidad
            WHERE id_inv = lote_id;

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar lotes de insumos
    SET i = 0;
    IF JSON_LENGTH(lotes_ins) > 0 THEN
        WHILE i < JSON_LENGTH(lotes_ins) DO
            SET lote_id = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].id_inv')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(lotes_ins, CONCAT('$[', i, '].cantidad')));

            SELECT cant_restante INTO stock_actual
            FROM inventario
            WHERE id_inv = lote_id;

            IF stock_actual < cantidad THEN
                SET mensaje_error = CONCAT('Error: No hay suficiente stock en el lote ', lote_id, '. Stock disponible: ', stock_actual);
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = mensaje_error;
            END IF;

            SELECT p_u INTO precio FROM inventario WHERE id_inv = lote_id;

            INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
            VALUES (pro_id, lote_id, cantidad);

            UPDATE inventario
            SET cant_restante = cant_restante - cantidad
            WHERE id_inv = lote_id;

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar mano de obra
    IF JSON_LENGTH(mano_obra) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(mano_obra) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].cat_id')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_cant_personas')));
            SET horas_persona = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_horas_trabajadas')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(mano_obra, CONCAT('$[', i, '].mo_precio_hora')));
            SET total_horas = cantidad * horas_persona;
            SET costo_total = total_horas * precio_ht;

            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_horas_persona, cst_precio_ht, cst_total_horas_actividad, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cantidad, 'UNIDADES', horas_persona, precio_ht, total_horas, costo_total
            );

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Procesar costos indirectos
    IF JSON_LENGTH(costos_indirectos) > 0 THEN
        SET i = 0;
        WHILE i < JSON_LENGTH(costos_indirectos) DO
            SET cat_id = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cat_id')));
            SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_cant')));
            SET presentacion = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_presentacion')));
            SET precio_ht = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_precio_ht')));
            SET costo_total = JSON_UNQUOTE(JSON_EXTRACT(costos_indirectos, CONCAT('$[', i, '].cst_costo_total')));

            IF costo_total IS NULL THEN
                SET costo_total = cantidad * precio_ht;
            END IF;

            INSERT INTO prcostos (
                pro_id, cat_id, cst_cant, cst_presentacion, cst_precio_ht, cst_costo_total
            ) VALUES (
                pro_id, cat_id, cantidad, presentacion, precio_ht, costo_total
            );

            SET i = i + 1;
        END WHILE;
    END IF;

    -- Restaurar estado original de SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = prev_safe_updates;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_produccion`(
    IN p_fecha DATE,
    IN p_cantidad DECIMAL(10, 2),
    IN p_estado VARCHAR(20),
    IN p_mano_obra JSON, -- Datos de mano de obra
    IN p_costos_indirectos JSON, -- Datos de costos indirectos
    IN p_consumos JSON -- Detalle de insumos y materia prima consumidos
)
BEGIN
    DECLARE v_pro_id INT;

    -- Insertar el registro en la tabla `produccion`
    INSERT INTO produccion (pro_fecha, pro_cantidad, pro_estado)
    VALUES (p_fecha, p_cantidad, p_estado);

    SET v_pro_id = LAST_INSERT_ID();

    -- Registrar consumos en `prod_detalle`
    IF JSON_LENGTH(p_consumos) > 0 THEN
        INSERT INTO prod_detalle (pro_id, id_inv, pdet_cantidad_usada)
        SELECT 
            v_pro_id,
            JSON_UNQUOTE(JSON_EXTRACT(consumo, '$.id_inv')),
            JSON_UNQUOTE(JSON_EXTRACT(consumo, '$.cantidad_usada'))
        FROM JSON_TABLE(p_consumos, '$[*]' COLUMNS (
            id_inv INT PATH '$.id_inv',
            cantidad_usada DECIMAL(10,2) PATH '$.cantidad_usada'
        )) AS consumo;
    END IF;

    -- Registrar mano de obra en `prcostos`
    IF JSON_LENGTH(p_mano_obra) > 0 THEN
        INSERT INTO prcostos (pro_id, cat_id, cst_cant, cst_horas_persona, cst_precio_ht, cst_total_horas_actividad, cst_costo_total)
        SELECT 
            v_pro_id,
            JSON_UNQUOTE(JSON_EXTRACT(mano_obra, '$.cat_id')),
            JSON_UNQUOTE(JSON_EXTRACT(mano_obra, '$.cst_cant')),
            JSON_UNQUOTE(JSON_EXTRACT(mano_obra, '$.cst_horas_persona')),
            JSON_UNQUOTE(JSON_EXTRACT(mano_obra, '$.cst_precio_ht')),
            JSON_UNQUOTE(JSON_EXTRACT(mano_obra, '$.cst_total_horas_actividad')),
            JSON_UNQUOTE(JSON_EXTRACT(mano_obra, '$.cst_costo_total'))
        FROM JSON_TABLE(p_mano_obra, '$[*]' COLUMNS (
            cat_id INT PATH '$.cat_id',
            cst_cant DECIMAL(10,2) PATH '$.cst_cant',
            cst_horas_persona DECIMAL(10,2) PATH '$.cst_horas_persona',
            cst_precio_ht DECIMAL(10,2) PATH '$.cst_precio_ht',
            cst_total_horas_actividad DECIMAL(10,2) PATH '$.cst_total_horas_actividad',
            cst_costo_total DECIMAL(10,2) PATH '$.cst_costo_total'
        )) AS mano_obra;
    END IF;

    -- Registrar costos indirectos en `prcostos`
    IF JSON_LENGTH(p_costos_indirectos) > 0 THEN
        INSERT INTO prcostos (pro_id, cat_id, cst_cant, cst_presentacion, cst_precio_ht, cst_costo_total)
        SELECT 
            v_pro_id,
            JSON_UNQUOTE(JSON_EXTRACT(costos, '$.cat_id')),
            JSON_UNQUOTE(JSON_EXTRACT(costos, '$.cst_cant')),
            JSON_UNQUOTE(JSON_EXTRACT(costos, '$.cst_presentacion')),
            JSON_UNQUOTE(JSON_EXTRACT(costos, '$.cst_precio_ht')),
            JSON_UNQUOTE(JSON_EXTRACT(costos, '$.cst_costo_total'))
        FROM JSON_TABLE(p_costos_indirectos, '$[*]' COLUMNS (
            cat_id INT PATH '$.cat_id',
            cst_cant DECIMAL(10,2) PATH '$.cst_cant',
            cst_presentacion VARCHAR(20) PATH '$.cst_presentacion',
            cst_precio_ht DECIMAL(10,2) PATH '$.cst_precio_ht',
            cst_costo_total DECIMAL(10,2) PATH '$.cst_costo_total'
        )) AS costos;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_act_usu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_act_usu`(
    IN p_usu_id INT,
    IN p_usu_cedula VARCHAR(20),
    IN p_usu_nombre VARCHAR(255),
    IN p_usu_apellido VARCHAR(255),
    IN p_usu_telefono VARCHAR(15),
    IN p_usu_correo VARCHAR(255),
    IN p_usu_direccion VARCHAR(255),
    IN p_usu_usuario VARCHAR(50),
    IN p_usu_contrasenia VARCHAR(255),
    IN p_rol_id INT
)
BEGIN
    -- Desactivar el modo seguro
    SET SQL_SAFE_UPDATES = 0;

    -- Actualizar el usuario en la tabla usuarios
    UPDATE usuarios
    SET usu_cedula = p_usu_cedula,
        usu_nombre = p_usu_nombre,
        usu_apellido = p_usu_apellido,
        usu_telefono = p_usu_telefono,
        usu_correo = p_usu_correo,
        usu_direccion = p_usu_direccion,
        usu_usuario = p_usu_usuario,
        usu_contrasenia = p_usu_contrasenia,
        rol_id = p_rol_id
    WHERE usu_id = p_usu_id;

    -- Actualizar el empleado en la tabla empleados utilizando la cédula
    UPDATE empleados
    SET emp_cedula = p_usu_cedula,
        emp_nombre = p_usu_nombre,
        emp_apellido = p_usu_apellido,
        emp_telefono = p_usu_telefono,
        emp_correo = p_usu_correo,
        emp_direccion = p_usu_direccion
    WHERE emp_cedula = p_usu_cedula;

    -- Volver a activar el modo seguro
    SET SQL_SAFE_UPDATES = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_ESTAD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ESTAD`()
BEGIN
    -- Cantidad de frutas en catálogo (categoría 1)
    SELECT COUNT(*) AS cantidad_frutas
    FROM catalogo
    WHERE ctg_id = 1;

    -- Cantidad de insumos en catálogo (categoría 2)
    SELECT COUNT(*) AS cantidad_insumos
    FROM catalogo
    WHERE ctg_id = 2;

    -- Cantidad de proveedores
    SELECT COUNT(*) AS cantidad_proveedores
    FROM proveedores;

    -- Cantidad de presentaciones de insumos
    SELECT COUNT(*) AS cantidad_presentaciones_insumos
    FROM presentacion
    WHERE ctg_id = 2;

    -- Cantidad de presentaciones de producto terminado
    SELECT COUNT(*) AS cantidad_presentaciones_pt
    FROM presentacion
    WHERE ctg_id = 3;

    -- Cantidad de lotes de materia prima
    SELECT COUNT(*) AS cantidad_lotes_mp
    FROM inventario
    WHERE cat_id IN (SELECT cat_id FROM catalogo WHERE ctg_id = 1);

    -- Cantidad de lotes de insumos
    SELECT COUNT(*) AS cantidad_lotes_insumos
    FROM inventario
    WHERE cat_id IN (SELECT cat_id FROM catalogo WHERE ctg_id = 2);

    -- Cantidad de lotes de producto terminado
    SELECT COUNT(*) AS cantidad_lotes_pt
    FROM inventario_pt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Obt_inven_INS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Obt_inven_INS`()
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.fecha AS Fecha,
        inv.hora AS Hora,
        inv.numero_lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Insumo,
        inv.unidad_medida AS Unidad_Medida,
        inv.cantidad_ingresada AS Cantidad,
        inv.cantidad_restante AS Cantidad_Restante,
        inv.precio_unitario AS Precio_Unitario,
        inv.precio_total AS Precio_Total,
        inv.presentacion AS Presentacion,
        inv.estado AS Estado
    FROM 
        inventario inv
    JOIN 
        proveedores prov ON inv.proveedor_id = prov.proveedor_id
    JOIN 
        invent_catalogo cat ON inv.id_articulo = cat.id_articulo
    WHERE 
        cat.id_categoria = 2; -- Filtra solo los registros de Insumos
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Obt_inven_MP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Obt_inven_MP`()
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.numero_lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Artículo,
        inv.unidad_medida AS unidad_medida,
        inv.cantidad_ingresada AS cantidad_ingresada, 
        inv.cantidad_restante AS Cantidad_Disponible,
        inv.precio_unitario AS precio_unitario,
        inv.precio_total AS Precio_Total,
        inv.estado AS Estado
         -- o inv.precio_unitario si prefieres
    FROM 
        inventario inv
    JOIN 
        proveedores prov ON inv.proveedor_id = prov.proveedor_id
    JOIN 
        invent_catalogo cat ON inv.id_articulo = cat.id_articulo
    WHERE 
        cat.id_categoria = 1; -- Filtra solo los registros de Materia Prima
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_verificar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verificar_usuario`(
    IN p_usuario VARCHAR(50),
    IN p_contrasenia VARCHAR(255)
)
BEGIN
    SELECT u.usu_id, u.usu_nombre, u.usu_apellido, u.usu_contrasenia, p.permiso_id
    FROM usuarios u
    JOIN roles r ON u.rol_id = r.rol_id
    JOIN permisos p ON r.permiso_id = p.permiso_id
    WHERE u.usu_usuario = p_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_cancelar_salida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_cancelar_salida`(
    IN p_id_despacho INT -- Solo un parámetro de entrada
)
BEGIN
    DECLARE v_id_pt INT;
    DECLARE v_lote VARCHAR(50);
    DECLARE v_cantidad_despachada DECIMAL(10,2);
    DECLARE mensaje_error VARCHAR(255);
    DECLARE prev_safe_updates INT;
    DECLARE done INT DEFAULT 0;

    -- Declarar cursor
    DECLARE cur CURSOR FOR 
        SELECT id_pt, lote, cantidad_despachada 
        FROM det_despacho 
        WHERE id_despacho = p_id_despacho;

    -- Declarar manejador de excepciones
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Iniciar transacción
    START TRANSACTION;

    -- Guardar estado original de SQL_SAFE_UPDATES
    SET prev_safe_updates = @@SQL_SAFE_UPDATES;
    SET SQL_SAFE_UPDATES = 0;

    -- Verificar si el despacho existe y está activo
    IF NOT EXISTS (SELECT 1 FROM despacho_pt WHERE id_despacho = p_id_despacho AND estado = 'activo') THEN
        SET mensaje_error = CONCAT('Error: El despacho con id_despacho ', p_id_despacho, ' no existe o ya está anulado.');
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
    END IF;

    -- Abrir cursor
    OPEN cur;

    -- Procesar los detalles del despacho
    read_loop: LOOP
        FETCH cur INTO v_id_pt, v_lote, v_cantidad_despachada;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Actualizar inventario
        UPDATE inventario_pt 
        SET cant_disponible = cant_disponible + v_cantidad_despachada
        WHERE id_pt = v_id_pt;
    END LOOP;

    -- Cerrar cursor
    CLOSE cur;

    -- Eliminar detalles del despacho
    DELETE FROM det_despacho 
    WHERE id_despacho = p_id_despacho;

    -- Eliminar el despacho
    DELETE FROM despacho_pt 
    WHERE id_despacho = p_id_despacho;

    -- Confirmar transacción
    COMMIT;

    -- Restaurar estado original de SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = prev_safe_updates;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Tp_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Tp_data`()
BEGIN
    SELECT 
        p.lote_PT AS lote,
        p.pro_fecha AS fecha_produccion,
        SUM(pt.cant_disponible) AS total_disponible,
        SUM(pt.p_t) AS precio_total
    FROM 
        produccion p
    JOIN 
        inventario_pt pt ON p.pro_id = pt.pro_id
    GROUP BY 
        p.lote_PT, p.pro_fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_data_s` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_data_s`()
BEGIN
    SELECT 
        ip.id_pt,
        ip.presentacion,
        ip.composicion AS pulpa,
        ip.cant_disponible AS cantidad_disponible,
        ip.p_u AS costo_unitario,
        ip.p_v_s AS precio_venta_sugerido,
        p.lote_PT AS lote
    FROM 
        inventario_pt ip
    JOIN 
        produccion p ON ip.pro_id = p.pro_id
    WHERE 
        ip.estado = 'disponible';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_DetalleKardexPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_DetalleKardexPT`(
    IN p_presentacion VARCHAR(20),
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        k.fecha_hora,
        k.presentacion,
        k.lote,
        k.cantidad,
        k.tipo_movimiento,
        k.comprobante_despacho
    FROM 
        kardex_PT k
    WHERE 
        k.presentacion = p_presentacion
        AND k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY 
        k.fecha_hora;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Tp_detalles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Tp_detalles`(IN lote_PT VARCHAR(50))
BEGIN
    SELECT 
        pt.id_pt,
        pt.presentacion,
        pt.cant_ingresada,
        pt.cant_disponible,
        pt.p_u,
        pt.p_t,
        pt.p_v_s,
        pt.fecha_caducidad,
        pt.composicion,
        pt.estado,
        pt.observacion
    FROM 
        inventario_pt pt
    JOIN 
        produccion p ON pt.pro_id = p.pro_id
    WHERE 
        p.lote_PT = lote_PT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_historial_1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_historial_1`()
BEGIN
    SELECT 
        d.id_despacho,
        d.fecha_despacho,
        d.n_comprobante,
        d.cantidad_total,
        d.precio_total
    FROM 
        despacho_pt d
    ORDER BY 
        d.fecha_despacho DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_historial_2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_historial_2`(IN despacho_id INT)
BEGIN
    SELECT 
        dp.id_despacho,
        dp.n_comprobante,
        dp.fecha_despacho,
        dp.estado AS estado_despacho,
        dp.cantidad_total,
        dp.precio_total,
        ddp.id_detalle,
        ddp.id_pt,
        ddp.lote,
        ddp.cantidad_despachada,
        ddp.precio_venta,
        ipt.presentacion,
        ipt.p_u AS precio_unitario,
        ipt.p_v_s AS precio_venta_sugerido,
        ipt.fecha_caducidad,
        ipt.composicion,
        ipt.estado AS estado_producto
    FROM 
        despacho_pt dp
    INNER JOIN 
        det_despacho ddp ON dp.id_despacho = ddp.id_despacho
    INNER JOIN 
        inventario_pt ipt ON ddp.id_pt = ipt.id_pt
    WHERE 
        dp.id_despacho = despacho_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_KardexGeneral` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_KardexGeneral`(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    -- Obtener las entradas y salidas del rango de fechas y el saldo inicial por presentación
    SELECT 
        ipt.presentacion AS Presentacion,
        COALESCE((
            SELECT stock_actual
            FROM kardex_PT k2
            WHERE k2.id_pt = ipt.id_pt
            AND k2.fecha_hora < p_fecha_inicio
            ORDER BY k2.fecha_hora DESC
            LIMIT 1
        ), 0) AS Saldo_Inicial,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0) AS Entradas,
        COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0) AS Salidas,
        (
            COALESCE((SELECT stock_actual FROM kardex_PT k2 WHERE k2.id_pt = ipt.id_pt AND k2.fecha_hora < p_fecha_inicio ORDER BY k2.fecha_hora DESC LIMIT 1), 0)
            + COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'entrada' THEN k.cantidad ELSE 0 END), 0)
            - COALESCE(SUM(CASE WHEN k.tipo_movimiento = 'salida' THEN k.cantidad ELSE 0 END), 0)
        ) AS Saldo_Final
    FROM 
        inventario_pt ipt
    LEFT JOIN 
        kardex_PT k ON ipt.id_pt = k.id_pt AND k.fecha_hora BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY 
        ipt.presentacion, ipt.id_pt  -- Agregar ipt.id_pt al GROUP BY
    HAVING 
        Saldo_Inicial > 0 OR Entradas > 0 OR Salidas > 0 OR Saldo_Final > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_reg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_reg`(
    IN p_pro_id INT, -- ID de la producción
    IN p_fecha_elaboracion DATE, -- Fecha de elaboración
    IN p_presentaciones JSON -- JSON con las presentaciones, cantidades y costos
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE v_presentacion VARCHAR(99); -- Asegúrate de que coincida con el tamaño de la columna
    DECLARE v_cant_ingresada DECIMAL(10,2);
    DECLARE v_cant_disponible DECIMAL(10,2);
    DECLARE v_p_u DECIMAL(10,2);
    DECLARE v_p_t DECIMAL(10,2);
    DECLARE v_precio_venta_sugerido DECIMAL(10,2);
    DECLARE v_fecha_caducidad DATE;
    DECLARE v_composicion TEXT;
    DECLARE v_estado ENUM('disponible', 'stock bajo', 'agotado') DEFAULT 'disponible';
    DECLARE v_observacion TEXT DEFAULT NULL;

    -- Recorrer el JSON de presentaciones
    WHILE i < JSON_LENGTH(p_presentaciones) DO
        -- Obtener los valores de cada presentación
        SET v_presentacion = LEFT(JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].presentacion'))), 20); -- Truncar a 20 caracteres
        SET v_cant_ingresada = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].cant_disponible')));
        SET v_cant_disponible = v_cant_ingresada;
        SET v_p_u = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].p_u')));
        SET v_p_t = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].p_t')));
        SET v_composicion = JSON_UNQUOTE(JSON_EXTRACT(p_presentaciones, CONCAT('$[', i, '].composicion')));

        -- Calcular el precio de venta sugerido (costo unitario + 20%)
        SET v_precio_venta_sugerido = v_p_u * 1.20;

        -- Calcular la fecha de caducidad (fecha de elaboración + 30 días)
        SET v_fecha_caducidad = DATE_ADD(p_fecha_elaboracion, INTERVAL 30 DAY);

        -- Insertar el registro en la tabla inventario_pt
        INSERT INTO inventario_pt (
            pro_id, presentacion, cant_ingresada, cant_disponible, p_u, p_t,
            p_v_s, fecha_caducidad, composicion, estado, observacion
        ) VALUES (
            p_pro_id, v_presentacion, v_cant_ingresada, v_cant_disponible, v_p_u, v_p_t,
            v_precio_venta_sugerido, v_fecha_caducidad, v_composicion, v_estado, v_observacion
        );

        -- Incrementar el contador
        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TP_salida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TP_salida`(
    IN p_despacho JSON,
    IN p_precio_total DECIMAL(10,2)
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE v_id_despacho INT;
    DECLARE v_id_pt INT;
    DECLARE v_lote VARCHAR(50);
    DECLARE v_cantidad_despachada DECIMAL(10,2);
    DECLARE v_precio_venta DECIMAL(10,2);
    DECLARE v_cantidad_total DECIMAL(10,2) DEFAULT 0;
    DECLARE v_cantidad_disponible DECIMAL(10,2);
    DECLARE mensaje_error VARCHAR(255);
    DECLARE prev_safe_updates INT;
    DECLARE v_n_comprobante VARCHAR(20);
    DECLARE v_ultimo_comprobante INT;

    -- Iniciar transacción
    START TRANSACTION;

    -- Guardar estado original de SQL_SAFE_UPDATES
    SET prev_safe_updates = @@SQL_SAFE_UPDATES;
    SET SQL_SAFE_UPDATES = 0;

    -- Depuración: Verificar los datos recibidos
    SELECT CONCAT('Datos recibidos - p_despacho: ', p_despacho) AS debug;
    SELECT CONCAT('Datos recibidos - p_precio_total: ', p_precio_total) AS debug;

    -- Generar número de comprobante
    SELECT IFNULL(MAX(CAST(SUBSTRING(n_comprobante, 8) AS UNSIGNED)), 0) + 1 INTO v_ultimo_comprobante FROM despacho_pt;
    SET v_n_comprobante = CONCAT('D-', YEAR(CURDATE()), '-', LPAD(v_ultimo_comprobante, 3, '0'));

    -- Insertar el despacho en la tabla despacho_pt
    INSERT INTO despacho_pt (fecha_despacho, estado, cantidad_total, precio_total, n_comprobante)
    VALUES (NOW(), 'activo', 0, p_precio_total, v_n_comprobante);
    SET v_id_despacho = LAST_INSERT_ID();

    -- Procesar los detalles del despacho
    WHILE i < JSON_LENGTH(p_despacho) DO
        -- Extraer valores del JSON (convertir a tipos correctos)
        SET v_id_pt = CAST(JSON_UNQUOTE(JSON_EXTRACT(p_despacho, CONCAT('$[', i, '].id_pt'))) AS UNSIGNED);
        SET v_lote = JSON_UNQUOTE(JSON_EXTRACT(p_despacho, CONCAT('$[', i, '].lote')));
        SET v_cantidad_despachada = CAST(JSON_UNQUOTE(JSON_EXTRACT(p_despacho, CONCAT('$[', i, '].cantidad_despachada'))) AS DECIMAL(10,2));
        SET v_precio_venta = CAST(JSON_UNQUOTE(JSON_EXTRACT(p_despacho, CONCAT('$[', i, '].precio_venta'))) AS DECIMAL(10,2));

        -- Depuración: Verificar los valores extraídos
        SELECT CONCAT('Procesando - id_pt: ', v_id_pt, ', lote: ', v_lote, ', cantidad_despachada: ', v_cantidad_despachada, ', precio_venta: ', v_precio_venta) AS debug;

        -- Validar que el id_pt exista en inventario_pt
        IF NOT EXISTS (SELECT 1 FROM inventario_pt WHERE id_pt = v_id_pt) THEN
            SET mensaje_error = CONCAT('Error: El producto con id_pt ', v_id_pt, ' no existe.');
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
        END IF;

        -- Obtener cantidad disponible
        SELECT cant_disponible 
        INTO v_cantidad_disponible
        FROM inventario_pt 
        WHERE id_pt = v_id_pt;

        -- Validar stock
        IF v_cantidad_disponible < v_cantidad_despachada THEN
            SET mensaje_error = CONCAT('Error: Stock insuficiente para id_pt ', v_id_pt, '. Disponible: ', v_cantidad_disponible);
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
        END IF;

        -- Insertar detalle del despacho
        INSERT INTO det_despacho (id_despacho, id_pt, lote, cantidad_despachada, precio_venta)
        VALUES (v_id_despacho, v_id_pt, v_lote, v_cantidad_despachada, v_precio_venta);

        -- Actualizar inventario
        UPDATE inventario_pt 
        SET cant_disponible = cant_disponible - v_cantidad_despachada
        WHERE id_pt = v_id_pt;

        -- Acumular totales
        SET v_cantidad_total = v_cantidad_total + v_cantidad_despachada;

        SET i = i + 1;
    END WHILE;

    -- Actualizar totales en despacho_pt
    UPDATE despacho_pt 
    SET cantidad_total = v_cantidad_total
    WHERE id_despacho = v_id_despacho;

    -- Confirmar transacción
    COMMIT;

    -- Restaurar estado original de SQL_SAFE_UPDATES
    SET SQL_SAFE_UPDATES = prev_safe_updates;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UM_CRUD_ins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UM_CRUD_ins`(
    IN `p_opcion` INT,
    IN `p_prs_id` INT,
    IN `p_prs_nombre` VARCHAR(50),
    IN `p_prs_abreviacion` VARCHAR(10)
)
BEGIN
    IF p_opcion = 1 THEN
        -- Insertar nueva presentación de insumo
        INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado, ctg_id)
        VALUES (p_prs_nombre, p_prs_abreviacion, 'vigente', 2);
    ELSEIF p_opcion = 2 THEN
        -- Actualizar presentación de insumo existente
        UPDATE presentacion
        SET prs_nombre = p_prs_nombre,
            prs_abreviacion = p_prs_abreviacion
        WHERE prs_id = p_prs_id AND ctg_id = 2;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UM_CRUD_pt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UM_CRUD_pt`(
    IN `p_opcion` INT,
    IN `p_prs_id` INT,
    IN `p_prs_nombre` VARCHAR(50),
    IN `p_equivalencia` INT
)
BEGIN
    IF p_opcion = 1 THEN
        -- Insertar nueva presentación de producto terminado
        INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia)
        VALUES (p_prs_nombre, '', 'vigente', 3, p_equivalencia);
    ELSEIF p_opcion = 2 THEN
        -- Actualizar presentación de producto terminado existente
        UPDATE presentacion
        SET prs_nombre = p_prs_nombre,
            equivalencia = p_equivalencia
        WHERE prs_id = p_prs_id AND ctg_id = 3;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UM_data_id_ins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UM_data_id_ins`(
    IN `p_prs_id` INT
)
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion
    FROM presentacion
    WHERE prs_id = p_prs_id AND ctg_id = 2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UM_data_id_pt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UM_data_id_pt`(
    IN `p_prs_id` INT
)
BEGIN
    SELECT prs_id, prs_nombre, equivalencia
    FROM presentacion
    WHERE prs_id = p_prs_id AND ctg_id = 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UM_data_ins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UM_data_ins`()
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia
    FROM presentacion
    WHERE ctg_id = 2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UM_data_pt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UM_data_pt`()
BEGIN
    SELECT prs_id, prs_nombre, prs_abreviacion, prs_estado, ctg_id, equivalencia
    FROM presentacion
    WHERE ctg_id = 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usu_CRUD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usu_CRUD`(
    IN p_opcion INT,
    IN p_usu_id INT,
    IN p_usu_cedula VARCHAR(20),
    IN p_usu_nombre VARCHAR(255),
    IN p_usu_apellido VARCHAR(255),
    IN p_usu_telefono VARCHAR(15),
    IN p_usu_usuario VARCHAR(50),
    IN p_usu_contrasenia VARCHAR(255),
    IN p_rol_id INT,
    IN p_correo VARCHAR(255)
)
BEGIN
    IF p_opcion = 1 THEN
        -- Registrar usuario
        INSERT INTO usuarios (
            usu_cedula,
            usu_nombre,
            usu_apellido,
            usu_telefono,
            usu_usuario,
            usu_contrasenia,
            rol_id,
            correo,
            fecha_reg
        ) VALUES (
            p_usu_cedula,
            p_usu_nombre,
            p_usu_apellido,
            p_usu_telefono,
            p_usu_usuario,
            p_usu_contrasenia,
            p_rol_id,
            p_correo,
            CURRENT_TIMESTAMP
        );
    ELSEIF p_opcion = 2 THEN
        -- Actualizar usuario
        UPDATE usuarios
        SET
            usu_cedula = p_usu_cedula,
            usu_nombre = p_usu_nombre,
            usu_apellido = p_usu_apellido,
            usu_telefono = p_usu_telefono,
            usu_usuario = p_usu_usuario,
            rol_id = p_rol_id,
            correo = p_correo,
            usu_contrasenia = IF(p_usu_contrasenia IS NOT NULL, p_usu_contrasenia, usu_contrasenia)
        WHERE usu_id = p_usu_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usu_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usu_data`()
BEGIN
    SELECT u.usu_id, u.usu_cedula, u.usu_nombre, u.usu_apellido, u.usu_telefono, u.usu_usuario, r.rol_nombre AS rol_nombre, u.estado, u.correo, u.fecha_reg
    FROM usuarios u
    JOIN roles r ON u.rol_id = r.rol_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usu_data_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usu_data_id`(
    IN p_usu_id INT
)
BEGIN
    SELECT
        usu_id,
        usu_cedula,
        usu_nombre,
        usu_apellido,
        usu_telefono,
        usu_usuario,
        rol_id,
        correo,
        fecha_reg
    FROM usuarios
    WHERE usu_id = p_usu_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Zentradas_cat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Zentradas_cat`(IN mes INT, IN anio INT)
BEGIN
    SELECT c.ctg_nombre, SUM(i.cant_ingresada) AS cantidad
    FROM inventario i
    JOIN catalogo cat ON i.cat_id = cat.cat_id
    JOIN categorias c ON cat.ctg_id = c.ctg_id
    WHERE MONTH(i.fecha_hora) = mes AND YEAR(i.fecha_hora) = anio
    GROUP BY c.ctg_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-07 13:22:09
