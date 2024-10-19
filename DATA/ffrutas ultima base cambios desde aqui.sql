CREATE DATABASE  IF NOT EXISTS `fpulpas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fpulpas`;
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
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `emp_cedula` varchar(20) NOT NULL,
  `emp_nombre` varchar(255) NOT NULL,
  `emp_apellido` varchar(255) NOT NULL,
  `emp_telefono` varchar(15) DEFAULT NULL,
  `emp_correo` varchar(255) DEFAULT NULL,
  `emp_direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frutas`
--

DROP TABLE IF EXISTS `frutas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frutas` (
  `fruta_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`fruta_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frutas`
--

LOCK TABLES `frutas` WRITE;
/*!40000 ALTER TABLE `frutas` DISABLE KEYS */;
INSERT INTO `frutas` VALUES (1,'Manzana','nueva furta'),(2,'Banana','Fruta amarilla, dulce y suave'),(3,'Pera','Fruta verde, dulce y jugosa'),(5,'Fresa','Pequeña fruta roja y jugosa con semillas externas.'),(6,'Mango','nuevo xd'),(7,'Mora','Mora de Caranqui'),(16,'Durazno','Durazno de Guayaquil'),(19,'CEREZAS','BACACO DE QUITO');
/*!40000 ALTER TABLE `frutas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumos`
--

DROP TABLE IF EXISTS `insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insumos` (
  `insumo_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `unidad_medida` varchar(50) NOT NULL,
  `destino` varchar(50) NOT NULL,
  PRIMARY KEY (`insumo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (3,'cofia','para pulpas','unidad','Producción'),(4,'Mascarillas','Mascarillas quirurjicas desechables','unidad','Producción'),(5,'Goma Xanthan','espesante para la producción de pulpas','kilogramos','Producción'),(6,'Saborizante','Saborizante para manzanas ','kilogramos','Producción'),(7,'Antiespumante','Para las pulaps de diferenets frutas','litros','Producción'),(8,'Sunchis','insumos para la protección de higiene en producción','unidad','Producción'),(9,'Cartón','Carton para empacar fundas de pulas de fruta','unidad','Producto Terminado'),(11,'AZUCAR','azcuar blanca','unidad','Producción');
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_insumos`
--

DROP TABLE IF EXISTS `inventario_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_insumos` (
  `inventins_id` int NOT NULL AUTO_INCREMENT,
  `insumo_id` int NOT NULL,
  `proveedor_id` int NOT NULL,
  `fecha_hora_ing` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fecha_cad` date DEFAULT NULL,
  `unidad_medida` varchar(10) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`inventins_id`),
  KEY `insumo_id` (`insumo_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `inventario_insumos_ibfk_1` FOREIGN KEY (`insumo_id`) REFERENCES `insumos` (`insumo_id`),
  CONSTRAINT `inventario_insumos_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_insumos`
--

LOCK TABLES `inventario_insumos` WRITE;
/*!40000 ALTER TABLE `inventario_insumos` DISABLE KEYS */;
INSERT INTO `inventario_insumos` VALUES (1,5,1,'2024-08-13 12:44:16','2023-05-05','kg',12.00,1.00,12.00),(5,5,2,'2024-08-11 14:32:59','2024-08-16','kg',0.00,0.00,0.00),(6,4,1,'2024-08-13 12:57:03','2024-03-02','u',12.00,50.50,606.00),(7,5,3,'2024-08-13 15:53:56','2024-08-31','u',100.00,0.25,25.00),(8,4,2,'2024-09-15 20:47:48','2024-09-15','u',12.00,12.00,144.00);
/*!40000 ALTER TABLE `inventario_insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materia_prima`
--

DROP TABLE IF EXISTS `materia_prima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materia_prima` (
  `mp_id` int NOT NULL AUTO_INCREMENT,
  `fruta_id` int DEFAULT NULL,
  `fecha_hora_ing` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_cad` date DEFAULT NULL,
  `proveedor_id` int DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `precio_unit` decimal(10,2) DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  `birx` decimal(5,2) DEFAULT NULL,
  `presentacion` varchar(50) NOT NULL,
  `estado` enum('en_revision','aprobado','no_aprobado') NOT NULL DEFAULT 'en_revision',
  `observaciones` text,
  PRIMARY KEY (`mp_id`),
  KEY `fruta_id` (`fruta_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `materia_prima_ibfk_1` FOREIGN KEY (`fruta_id`) REFERENCES `frutas` (`fruta_id`),
  CONSTRAINT `materia_prima_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia_prima`
--

LOCK TABLES `materia_prima` WRITE;
/*!40000 ALTER TABLE `materia_prima` DISABLE KEYS */;
INSERT INTO `materia_prima` VALUES (1,2,'2024-07-25 15:00:00','2024-12-23',2,39.00,1.50,11.40,11.00,'cajas','aprobado','ninguna');
/*!40000 ALTER TABLE `materia_prima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos` (
  `mov_id` int NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` int DEFAULT NULL,
  `accion` varchar(255) DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`mov_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `movimientos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos`
--

LOCK TABLES `movimientos` WRITE;
/*!40000 ALTER TABLE `movimientos` DISABLE KEYS */;
INSERT INTO `movimientos` VALUES (1,'2024-07-25 15:00:00',1,'Ingreso de materia prima',100.00,'Lote Lote001 de Manzana'),(2,'2024-07-25 16:00:00',2,'Ingreso de materia prima',150.00,'Lote Lote002 de Banana'),(3,'2024-07-25 15:00:00',1,'Producción realizada',50.00,'Producción de materia prima ID: 7, Insumo ID: 1');
/*!40000 ALTER TABLE `movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisos` (
  `permiso_id` int NOT NULL AUTO_INCREMENT,
  `permiso_nombre` varchar(50) DEFAULT NULL,
  `permiso_descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`permiso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` VALUES (1,'Completo','Acceso completo al sistema'),(2,'Área Materias Primas','Acceso a la sección de materias primas'),(3,'Área de Producción','Acceso a la sección de producción'),(4,'Área de Producto Terminado','Acceso a la sección de producto terminado');
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion`
--

DROP TABLE IF EXISTS `produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produccion` (
  `id_produccion` int NOT NULL AUTO_INCREMENT,
  `fecha_produccion` datetime NOT NULL,
  `lote` varchar(255) NOT NULL,
  `materia_prima_id` int NOT NULL,
  `cantidad_utilizada` decimal(10,2) NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `costo_total` decimal(10,2) GENERATED ALWAYS AS ((`cantidad_utilizada` * `costo_unitario`)) STORED,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id_produccion`),
  KEY `materia_prima_id` (`materia_prima_id`),
  CONSTRAINT `produccion_ibfk_1` FOREIGN KEY (`materia_prima_id`) REFERENCES `materia_prima` (`mp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
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
  `direccion` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Proveedor A','Juan Perez','Dirección 1','contacto@proveedora.com','123456789','2024-07-30 11:19:22'),(2,'Proveedor B','Maria Gomez','Dirección 2','contacto@proveedorb.com','987654321','2024-07-30 11:19:22'),(3,'Proveedor C','Pablo Marmol','Dirección 3','contacto@proveedorb.com','9823432','2024-07-30 11:24:14'),(4,'jesus','nuevo era','ibarra ayer','jad@asi.com','984729666','2024-07-30 14:36:52'),(13,'revision','zi','aaa','sisisj@dka','32938','2024-08-01 23:50:14');
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
  `rol_nombre` varchar(45) DEFAULT NULL,
  `rol_descripcion` varchar(255) DEFAULT NULL,
  `permiso_id` int DEFAULT NULL,
  `fecha_registro` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`rol_id`),
  KEY `permiso_id` (`permiso_id`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`permiso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Control y acceso a todas las funcionalidades del sistema',1,'2024-08-01'),(2,'Bodeguero Materia Prima','Acceso a el ingreso de materia prima e insumos',2,'2024-08-01'),(3,'Encargado De Produccion','Control de la produccion de pulpa de furta e insumos',3,'2024-08-01');
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
  `usu_cedula` varchar(20) DEFAULT NULL,
  `usu_nombre` varchar(255) DEFAULT NULL,
  `usu_apellido` varchar(255) DEFAULT NULL,
  `usu_telefono` varchar(15) DEFAULT NULL,
  `usu_correo` varchar(255) DEFAULT NULL,
  `usu_direccion` varchar(255) DEFAULT NULL,
  `usu_usuario` varchar(50) DEFAULT NULL,
  `usu_contrasenia` varchar(255) DEFAULT NULL,
  `rol_id` int DEFAULT NULL,
  `fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usu_id`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'1050478237','Jeferson','Yandun','0983928','jje@gmail.com','azaya city','j','$2y$10$m61/MGBFyWwM3Dd5BtD2xOzfEDsPEGgIIXqBKJHLf1vaorukxbJtu',1,'2024-08-02 00:41:02'),(2,'102129','Angel','Pacheco','0390390','ibarra','jua@gmail.com','angel','$2y$10$pSFvSv9c3gFnK.L95uDaf.VSn5Yq5XF16CbrIau0Pn86rkMOY5Arq',2,'2024-08-02 00:41:02');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!50003 DROP PROCEDURE IF EXISTS `acciones_insumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `acciones_insumo`(
    IN p_insumo_id INT,
    IN p_nombre VARCHAR(255),
    IN p_descripcion TEXT,
    IN p_unidad_medida VARCHAR(50),
    IN p_destino VARCHAR(50)
)
BEGIN
    IF p_insumo_id IS NULL THEN
        -- Insertar un nuevo insumo
        INSERT INTO insumos (nombre, descripcion, unidad_medida, destino)
        VALUES (p_nombre, p_descripcion, p_unidad_medida, p_destino);
    ELSE
        -- Actualizar un insumo existente
        UPDATE insumos
        SET nombre = p_nombre,
            descripcion = p_descripcion,
            unidad_medida = p_unidad_medida,
            destino = p_destino
        WHERE insumo_id = p_insumo_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `acciones_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `acciones_proveedor`(
    IN p_proveedor_id INT,
    IN p_nombre_empresa VARCHAR(255),
    IN p_representante VARCHAR(255),
    IN p_direccion VARCHAR(255),
    IN p_correo VARCHAR(255),
    IN p_telefono VARCHAR(50)
)
BEGIN
    DECLARE v_fecha_reg TIMESTAMP;
    IF p_proveedor_id IS NULL THEN
        -- Insertar un nuevo proveedor
        SET v_fecha_reg = CURRENT_TIMESTAMP;
        INSERT INTO proveedores (nombre_empresa, representante, direccion, correo, telefono, fecha_reg)
        VALUES (p_nombre_empresa, p_representante, p_direccion, p_correo, p_telefono, v_fecha_reg);
    ELSE
        -- Actualizar un proveedor existente
        UPDATE proveedores
        SET nombre_empresa = p_nombre_empresa,
            representante = p_representante,
            direccion = p_direccion,
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
/*!50003 DROP PROCEDURE IF EXISTS `act_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `act_produccion`(
    IN p_id_produccion INT,
    IN p_fecha_produccion DATETIME,
    IN p_lote VARCHAR(255),
    IN p_cantidad_utilizada DECIMAL(10, 2),
    OUT p_resultado VARCHAR(50)
)
BEGIN
    DECLARE v_materia_prima_id INT;
    DECLARE v_costo_unitario DECIMAL(10, 2);
    DECLARE v_cantidad_actual DECIMAL(10, 2);
    DECLARE v_cantidad_original DECIMAL(10, 2);
    
    -- Obtener la materia prima asociada y la cantidad utilizada original
    SELECT materia_prima_id, cantidad_utilizada, costo_unitario INTO v_materia_prima_id, v_cantidad_original, v_costo_unitario
    FROM produccion
    WHERE id_produccion = p_id_produccion;
    
    -- Validar que la cantidad nueva no exceda el stock disponible + la cantidad original utilizada
    SELECT cantidad INTO v_cantidad_actual
    FROM materia_prima
    WHERE mp_id = v_materia_prima_id;
    
    IF p_cantidad_utilizada > (v_cantidad_actual + v_cantidad_original) THEN
        SET p_resultado = 'Error: Cantidad utilizada excede el stock disponible';
    ELSE
        -- Actualizar el registro de producción
        UPDATE produccion
        SET fecha_produccion = p_fecha_produccion, 
            lote = p_lote, 
            cantidad_utilizada = p_cantidad_utilizada, 
            costo_total = p_cantidad_utilizada * v_costo_unitario
        WHERE id_produccion = p_id_produccion;
        
        -- Actualizar el stock en la tabla de materia prima
        UPDATE materia_prima
        SET cantidad = cantidad - (p_cantidad_utilizada - v_cantidad_original)
        WHERE mp_id = v_materia_prima_id;
        
        SET p_resultado = 'Producción actualizada con éxito';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `estado_materia_prima` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `estado_materia_prima`(
    IN p_mp_id INT,
    IN p_estado INT
)
BEGIN
    UPDATE materia_prima
    SET estado = CASE 
                    WHEN p_estado = 1 THEN 'aprobado' 
                    WHEN p_estado = 2 THEN 'en_revision' 
                    WHEN p_estado = 3 THEN 'no_aprobado' 
                 END
    WHERE mp_id = p_mp_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_produccion`(
    IN p_fecha_produccion DATETIME,
    IN p_lote VARCHAR(255),
    IN p_materia_prima_id INT,
    IN p_cantidad_utilizada DECIMAL(10, 2),
    OUT p_resultado VARCHAR(50)
)
BEGIN
    DECLARE v_costo_unitario DECIMAL(10, 2);
    DECLARE v_stock_actual DECIMAL(10, 2);
    
    -- Obtener el costo unitario de la materia prima seleccionada
    SELECT precio_unit, cantidad INTO v_costo_unitario, v_stock_actual
    FROM materia_prima
    WHERE mp_id = p_materia_prima_id;
    
    -- Validar que la cantidad a utilizar no exceda el stock disponible
    IF p_cantidad_utilizada > v_stock_actual THEN
        SET p_resultado = 'Error: Cantidad utilizada excede el stock disponible';
    ELSE
        -- Insertar el registro de producción
        INSERT INTO produccion (fecha_produccion, lote, materia_prima_id, cantidad_utilizada, costo_unitario, estado)
        VALUES (p_fecha_produccion, p_lote, p_materia_prima_id, p_cantidad_utilizada, v_costo_unitario, 'en proceso');
        
        -- Actualizar el stock en la tabla de materia prima
        UPDATE materia_prima
        SET cantidad = cantidad - p_cantidad_utilizada
        WHERE mp_id = p_materia_prima_id;
        
        SET p_resultado = 'Producción registrada con éxito';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inventario_insumos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `inventario_insumos`(
    IN p_inventins_id INT,
    IN p_insumo_id INT,
    IN p_proveedor_id INT,
    IN p_fecha_cad DATE,
    IN p_unidad_medida VARCHAR(10),
    IN p_cantidad DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_precio_total DECIMAL(10, 2)
)
BEGIN
    IF p_inventins_id IS NULL THEN
        -- Inserción
        INSERT INTO inventario_insumos (
            insumo_id, proveedor_id, fecha_cad, unidad_medida, cantidad, precio_unitario, precio_total
        ) VALUES (
            p_insumo_id, p_proveedor_id, p_fecha_cad, p_unidad_medida, p_cantidad, p_precio_unitario, p_precio_total
        );
    ELSE
        -- Actualización
        UPDATE inventario_insumos
        SET 
            insumo_id = p_insumo_id,
            proveedor_id = p_proveedor_id,
            fecha_cad = p_fecha_cad,
            unidad_medida = p_unidad_medida,
            cantidad = p_cantidad,
            precio_unitario = p_precio_unitario,
            precio_total = p_precio_total
        WHERE inventins_id = p_inventins_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `invent_materia_prima` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `invent_materia_prima`(
    IN p_mp_id INT,
    IN p_fruta_id INT,
    IN p_fecha_cad DATE,
    IN p_proveedor_id INT,
    IN p_cantidad DECIMAL(10,2),
    IN p_precio_unit DECIMAL(10,2),
    IN p_precio_total DECIMAL(10,2),
    IN p_birx DECIMAL(5,2),
    IN p_presentacion VARCHAR(50),
    IN p_observaciones TEXT
)
BEGIN
    DECLARE v_fecha_hora_ing TIMESTAMP;
    DECLARE v_estado ENUM('en_revision', 'aprobado', 'no_aprobado') DEFAULT 'en_revision';

    IF p_mp_id IS NULL THEN
        SET v_fecha_hora_ing = CURRENT_TIMESTAMP;
        INSERT INTO materia_prima (
            fruta_id, fecha_hora_ing, fecha_cad, proveedor_id, cantidad, precio_unit, precio_total, birx, presentacion, estado, observaciones
        ) VALUES (
            p_fruta_id, v_fecha_hora_ing, p_fecha_cad, p_proveedor_id, p_cantidad, p_precio_unit, p_precio_total, p_birx, p_presentacion, v_estado, p_observaciones
        );
    ELSE
        UPDATE materia_prima
        SET
            fruta_id = p_fruta_id,
            fecha_cad = p_fecha_cad,
            proveedor_id = p_proveedor_id,
            cantidad = p_cantidad,
            precio_unit = p_precio_unit,
            precio_total = p_precio_total,
            birx = p_birx,
            presentacion = p_presentacion,
            observaciones = p_observaciones
        WHERE mp_id = p_mp_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MateriaPrimaparaProduccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MateriaPrimaparaProduccion`()
BEGIN
    SELECT 
        mp.mp_id,
        mp.fecha_hora_ing,
        f.nombre AS fruta_nombre,
        p.nombre_empresa AS proveedor_nombre,
        mp.cantidad,
        mp.precio_unit
    FROM 
        materia_prima mp
    JOIN 
        frutas f ON mp.fruta_id = f.fruta_id
    JOIN 
        proveedores p ON mp.proveedor_id = p.proveedor_id
    WHERE 
        mp.estado = 'aprobado'; -- Solo obtener materias primas aprobadas
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_borrar_fruta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_borrar_fruta`(
    IN p_fruta_id INT
)
BEGIN
    DELETE FROM frutas
    WHERE fruta_id = p_fruta_id;
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
/*!50003 DROP PROCEDURE IF EXISTS `pa_eliminar_insumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_insumo`(
    IN p_insumo_id INT
)
BEGIN
    DELETE FROM insumos
    WHERE insumo_id = p_insumo_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_eliminar_materia_prima` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_materia_prima`(
    IN p_mp_id INT
)
BEGIN
    DELETE FROM materia_prima WHERE mp_id = p_mp_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_eliminar_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_produccion`(
    IN p_id_produccion INT,
    OUT p_resultado VARCHAR(50)
)
BEGIN
    DECLARE v_materia_prima_id INT;
    DECLARE v_cantidad_utilizada DECIMAL(10, 2);
    
    -- Obtener la materia prima asociada y la cantidad utilizada
    SELECT materia_prima_id, cantidad_utilizada INTO v_materia_prima_id, v_cantidad_utilizada
    FROM produccion
    WHERE id_produccion = p_id_produccion;
    
    -- Eliminar el registro de producción
    DELETE FROM produccion WHERE id_produccion = p_id_produccion;
    
    -- Devolver la cantidad utilizada al stock de la materia prima
    UPDATE materia_prima
    SET cantidad = cantidad + v_cantidad_utilizada
    WHERE mp_id = v_materia_prima_id;
    
    SET p_resultado = 'Producción eliminada con éxito';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_eliminar_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminar_proveedor`(
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
/*!50003 DROP PROCEDURE IF EXISTS `pa_invent_ins_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_invent_ins_eliminar`(
    IN p_inventins_id INT
)
BEGIN
    DELETE FROM inventario_insumos WHERE inventins_id = p_inventins_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obtener_frutas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obtener_frutas`()
BEGIN
    SELECT fruta_id, nombre, descripcion FROM frutas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obtener_proveedores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obtener_proveedores`()
BEGIN
    SELECT proveedor_id, nombre_empresa, representante, direccion, correo, telefono, fecha_reg FROM proveedores;
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
/*!50003 DROP PROCEDURE IF EXISTS `pa_obt_insumos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obt_insumos`()
BEGIN
    SELECT * FROM insumos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obt_inventInsumos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obt_inventInsumos`()
BEGIN
    SELECT 
        ii.inventins_id, 
        i.nombre AS insumo_nombre,  -- Se reemplaza insumo_id por el nombre del insumo
        p.nombre_empresa AS proveedor_nombre,  -- Se reemplaza proveedor_id por el nombre de la empresa del proveedor
        ii.fecha_hora_ing, 
        ii.fecha_cad, 
        ii.unidad_medida, 
        ii.cantidad, 
        ii.precio_unitario, 
        ii.precio_total
    FROM 
        inventario_insumos ii
    JOIN 
        insumos i ON ii.insumo_id = i.insumo_id  -- Se realiza el JOIN con la tabla insumos
    JOIN 
        proveedores p ON ii.proveedor_id = p.proveedor_id;  -- Se realiza el JOIN con la tabla proveedores
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obt_materia_prima` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obt_materia_prima`()
BEGIN
    SELECT 
        mp.mp_id, 
        f.nombre AS fruta_nombre,  -- Se reemplaza fruta_id por el nombre de la fruta
        mp.fecha_hora_ing, 
        mp.fecha_cad, 
        p.nombre_empresa AS proveedor_nombre,  -- Se reemplaza proveedor_id por el nombre de la empresa del proveedor
        mp.cantidad, 
        mp.precio_unit, 
        mp.precio_total, 
        mp.birx, 
        mp.presentacion, 
        mp.estado, 
        mp.observaciones
    FROM 
        materia_prima mp
    JOIN 
        frutas f ON mp.fruta_id = f.fruta_id  -- Se realiza el JOIN con la tabla frutas
    JOIN 
        proveedores p ON mp.proveedor_id = p.proveedor_id;  -- Se realiza el JOIN con la tabla proveedores
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obt_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obt_produccion`()
BEGIN
    SELECT id_produccion, fecha_produccion, lote, materia_prima_id, cantidad_utilizada, costo_unitario, costo_total, estado
    FROM produccion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_obt_prov_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_obt_prov_id`(
    IN p_proveedor_id INT
)
BEGIN
    SELECT proveedor_id, nombre_empresa, representante, direccion, correo, telefono, fecha_reg
    FROM proveedores
    WHERE proveedor_id = p_proveedor_id;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertar_insumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_insumo`(
    IN p_insumo_fecha_hora DATETIME,
    IN p_insumo_tipo VARCHAR(255),
    IN p_insumo_nombre VARCHAR(255),
    IN p_insumo_cantidad DOUBLE,
    IN p_insumo_unidad_medida VARCHAR(50),
    IN p_insumo_precio_unidad DOUBLE,
    IN p_insumo_precio_total DOUBLE,
    IN p_proveedor_id INT
)
BEGIN
    INSERT INTO insumos (insumo_fecha_hora, insumo_tipo, insumo_nombre, insumo_cantidad, insumo_unidad_medida, insumo_precio_unidad, insumo_precio_total, proveedor_id)
    VALUES (p_insumo_fecha_hora, p_insumo_tipo, p_insumo_nombre, p_insumo_cantidad, p_insumo_unidad_medida, p_insumo_precio_unidad, p_insumo_precio_total, p_proveedor_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertar_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_produccion`(
    IN p_mp_id INT,
    IN p_cantidad_usada DECIMAL(10,2),
    IN p_fecha_produccion DATETIME,
    IN p_cantidad_producida DECIMAL(10,2),
    IN p_unidad_medida VARCHAR(50),
    IN p_usu_id INT,
    IN p_lote VARCHAR(50)
)
BEGIN
    -- Insertar el registro de producción
    INSERT INTO produccion (
        mp_id,
        cantidad_usada,
        fecha_produccion,
        cantidad_producida,
        unidad_medida,
        usu_id,
        lote
    ) VALUES (
        p_mp_id,
        p_cantidad_usada,
        p_fecha_produccion,
        p_cantidad_producida,
        p_unidad_medida,
        p_usu_id,
        p_lote
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_obt_usu__id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obt_usu__id`(IN p_usu_id INT)
BEGIN
    SELECT 
        usu_id, 
        usu_cedula, 
        usu_nombre, 
        usu_apellido, 
        usu_telefono, 
		usu_direccion, 
        usu_correo, 
        usu_usuario, 
        rol_id 
    FROM 
        usuarios 
    WHERE 
        usu_id = p_usu_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_act_fruta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_act_fruta`(
    IN p_opcion INT,
    IN p_fruta_id INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    IF p_opcion = 1 THEN
        -- Inserción
        INSERT INTO frutas (nombre, descripcion)
        VALUES (p_nombre, p_descripcion);
    ELSEIF p_opcion = 2 THEN
        -- Actualización
        UPDATE frutas
        SET nombre = p_nombre, descripcion = p_descripcion
        WHERE fruta_id = p_fruta_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_invn_insumos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_invn_insumos`(
    IN p_insumo_id INT,
    IN p_proveedor_id INT,
    IN p_cantidad DECIMAL(10,0),
    IN p_precio_unitario DECIMAL(10,0)
)
BEGIN
    INSERT INTO inventario_insumos (insumo_id, proveedor_id, fecha_hora_ing, cantidad, precio_unitario, precio_total)
    VALUES (p_insumo_id, p_proveedor_id, CURRENT_TIMESTAMP, p_cantidad, p_precio_unitario, (p_cantidad * p_precio_unitario));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_materia_prima` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_materia_prima`(
    IN p_fruta_id INT,
    IN p_fecha_cad DATE,
    IN p_proveedor_id INT,
    IN p_cantidad DECIMAL(10,2),
    IN p_precio_unit DECIMAL(10,2),
    IN p_birx DECIMAL(5,2),
    IN p_estado ENUM('aprobado','no_aprobado'),
    IN p_usuario_id INT,
    IN p_observaciones TEXT
)
BEGIN
    INSERT INTO materia_prima (fruta_id, fecha_hora_ing, fecha_cad, proveedor_id, cantidad, precio_unit, precio_total, birx, estado, usuario_id, observaciones)
    VALUES (p_fruta_id, CURRENT_TIMESTAMP, p_fecha_cad, p_proveedor_id, p_cantidad, p_precio_unit, (p_cantidad * p_precio_unit), p_birx, p_estado, p_usuario_id, p_observaciones);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_produccion`(
    IN p_mp_id INT,
    IN p_cantidad_utilizada DECIMAL(10,2),
    IN p_cantidad_obtenida DECIMAL(10,2),
    IN p_usuario_id INT
)
BEGIN
    DECLARE v_costo_total DECIMAL(10,2);
    
    -- Calcular costo total (aquí asumimos que se obtiene de otro cálculo o tabla)
    SELECT SUM(cantidad_insumo * costo) INTO v_costo_total 
    FROM produccion_insumos 
    WHERE prod_id = LAST_INSERT_ID(); -- Usar el último ID insertado

    INSERT INTO produccion (mp_id, cantidad_utilizada, cantidad_obtenida, costo_total, estado, usuario_id)
    VALUES (p_mp_id, p_cantidad_utilizada, p_cantidad_obtenida, v_costo_total, 'aprobado', p_usuario_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_produccion_insumos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_produccion_insumos`(
    IN p_prod_id INT,
    IN p_insumo_id INT,
    IN p_cantidad_insumo DECIMAL(10,2),
    IN p_costo DECIMAL(10,2)
)
BEGIN
    INSERT INTO produccion_insumos (prod_id, insumo_id, cantidad_insumo, costo)
    VALUES (p_prod_id, p_insumo_id, p_cantidad_insumo, p_costo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_usu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_usu`(
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
    DECLARE v_rol_nombre VARCHAR(45);

    -- Obtener el nombre del rol
    SELECT rol_nombre INTO v_rol_nombre
    FROM roles
    WHERE rol_id = p_rol_id;

    -- Insertar el usuario en la tabla usuarios
    INSERT INTO usuarios (usu_cedula, usu_nombre, usu_apellido, usu_telefono, usu_correo, usu_direccion, usu_usuario, usu_contrasenia, rol_id, fecha_reg)
    VALUES (p_usu_cedula, p_usu_nombre, p_usu_apellido, p_usu_telefono, p_usu_correo, p_usu_direccion, p_usu_usuario, p_usu_contrasenia, p_rol_id, CURRENT_TIMESTAMP);

    -- Si el rol no es "Administrador", insertar en la tabla empleados
    IF v_rol_nombre <> 'Administrador' THEN
        INSERT INTO empleados (emp_cedula, emp_nombre, emp_apellido, emp_telefono, emp_correo, emp_direccion)
        VALUES (p_usu_cedula, p_usu_nombre, p_usu_apellido, p_usu_telefono, p_usu_correo, p_usu_direccion);
    END IF;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-19  9:29:16
