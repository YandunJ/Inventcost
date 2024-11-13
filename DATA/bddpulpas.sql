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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) NOT NULL,
  `descripcion` text,
  `fecha_registro` date NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Materia Prima','Frutas para almacenamiento y uso en producción','2024-10-05'),(2,'Insumos','Materiales utilizados en la producción','2024-10-05'),(3,'Productos Terminado','Paquetes de Pulpa Procesada','2024-10-05');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Table structure for table `invent_catalogo`
--

DROP TABLE IF EXISTS `invent_catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invent_catalogo` (
  `id_articulo` int NOT NULL AUTO_INCREMENT,
  `nombre_articulo` varchar(100) NOT NULL,
  `descripcion` text,
  `id_categoria` int DEFAULT NULL,
  `unidad_medida` varchar(50) NOT NULL,
  `estado` enum('disponible','stock bajo','agotado') DEFAULT 'disponible',
  `fecha_creacion` date NOT NULL,
  `stock` int DEFAULT '0',
  PRIMARY KEY (`id_articulo`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `invent_catalogo_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invent_catalogo`
--

LOCK TABLES `invent_catalogo` WRITE;
/*!40000 ALTER TABLE `invent_catalogo` DISABLE KEYS */;
INSERT INTO `invent_catalogo` VALUES (1,'Manzana Roja','Manzanas rojas frescas para producción de pulpa',1,'kilogramos','disponible','2024-10-06',0),(2,'Piña','Piñas frescas para producción de pulpa',1,'unidades','disponible','2024-10-06',0),(3,'Banana','Bananas maduras para producción de pulpa',1,'racimos','disponible','2024-10-06',0),(4,'Cofia','Cofia desechable para personal de producción',2,'unidades','disponible','2024-10-06',0),(5,'Mascarilla','Mascarilla quirúrgica',2,'unidades','stock bajo','2024-10-06',0),(6,'Goma Xanthan','Espesante para productos',2,'kilogramos','disponible','2024-10-06',0),(7,'Saborizante de Fresa','Saborizante artificial de fresa',2,'kilogramos','disponible','2024-10-06',0),(8,'Ácido Cítrico','Conservante',2,'kilogramos','disponible','2024-10-06',0),(9,'Antiespumante','Agente antiespumante para procesos',2,'litros','disponible','2024-10-06',0),(10,'Funda de 250g','Funda plástica para envase de 250g',2,'unidades','disponible','2024-10-06',0),(11,'aaaa','aaa',1,'aaaa','disponible','2024-11-06',0);
/*!40000 ALTER TABLE `invent_catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invent_detalle_mp`
--

DROP TABLE IF EXISTS `invent_detalle_mp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invent_detalle_mp` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_inv` int DEFAULT NULL,
  `bultos_o_canastas` int DEFAULT NULL,
  `peso_unitario` decimal(10,2) DEFAULT NULL,
  `brix` decimal(5,2) DEFAULT NULL,
  `observacion` text,
  `decision` enum('aprobado','no aprobado') DEFAULT 'no aprobado',
  PRIMARY KEY (`id_detalle`),
  KEY `id_inv` (`id_inv`),
  CONSTRAINT `invent_detalle_mp_ibfk_1` FOREIGN KEY (`id_inv`) REFERENCES `inventario` (`id_inv`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invent_detalle_mp`
--

LOCK TABLES `invent_detalle_mp` WRITE;
/*!40000 ALTER TABLE `invent_detalle_mp` DISABLE KEYS */;
INSERT INTO `invent_detalle_mp` VALUES (1,1,12,12.00,12.00,'si','aprobado'),(2,2,30,20.00,12.80,'Buen estado, brix adecuado','aprobado'),(3,3,10,1.00,12.50,'Fruta fresca, buen estado','no aprobado'),(4,4,10,1.00,12.50,'Fruta fresca, buen estado','no aprobado'),(5,5,10,5.00,12.50,'Lote fresco, alta calidad','no aprobado'),(6,6,10,1.00,12.50,'Fruta fresca, buen estado','no aprobado'),(7,7,10,1.00,12.50,'Fruta fresca, buen estado','no aprobado'),(8,8,10,1.00,12.50,'Fruta fresca, buen estado','no aprobado'),(9,9,69,70.00,93.00,'Cupidatat odio conse','no aprobado'),(10,10,12,1.20,6.90,'ninguna lote en perfecto estado ya registro aaa','no aprobado');
/*!40000 ALTER TABLE `invent_detalle_mp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_inv` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `id_articulo` int NOT NULL,
  `proveedor_id` int NOT NULL,
  `numero_lote` varchar(50) NOT NULL,
  `unidad_medida` varchar(20) NOT NULL DEFAULT 'kg',
  `cantidad_ingresada` decimal(10,2) NOT NULL,
  `cantidad_restante` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `precio_total` decimal(10,2) GENERATED ALWAYS AS ((`cantidad_restante` * `precio_unitario`)) STORED,
  `presentacion` varchar(50) NOT NULL,
  `estado` enum('disponible','stock bajo','agotado') NOT NULL DEFAULT 'disponible',
  PRIMARY KEY (`id_inv`),
  KEY `id_articulo` (`id_articulo`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `invent_catalogo` (`id_articulo`),
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` (`id_inv`, `fecha`, `hora`, `id_articulo`, `proveedor_id`, `numero_lote`, `unidad_medida`, `cantidad_ingresada`, `cantidad_restante`, `precio_unitario`, `presentacion`, `estado`) VALUES (1,'2023-10-01','09:00:00',1,1,'1111','kg',10.00,300.00,10.00,'bultos','disponible'),(2,'2024-10-02','10:30:00',2,2,'Lote2024B','kg',600.00,300.00,3.00,'Saco','stock bajo'),(3,'2024-11-05','12:30:00',1,2,'L12345','kg',100.00,100.00,1.50,'cajas','disponible'),(4,'2024-11-05','12:30:00',1,2,'L12345','kg',100.00,100.00,1.50,'cajas','disponible'),(5,'2024-11-02','12:30:00',1,2,'LOTE123','kg',100.00,100.00,50.00,'Sacos','disponible'),(6,'2024-11-05','12:30:00',1,2,'L12345','kg',100.00,100.00,1.50,'cajas','disponible'),(7,'2024-11-05','12:30:00',1,2,'L12345','kg',100.00,100.00,1.50,'cajas','disponible'),(8,'2024-11-05','12:30:00',1,2,'L12345','kg',100.00,100.00,1.50,'cajas','disponible'),(9,'1974-02-24','20:18:00',2,6,'555','kg',77.00,77.00,27.00,'cajas','disponible'),(10,'2024-11-06','20:06:00',3,6,'0','kg',69.00,69.00,1.20,'bultos','disponible');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
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
  `fecha_produccion` date NOT NULL,
  `cantidad_producida` decimal(10,2) NOT NULL,
  `estado` varchar(20) DEFAULT 'en proceso',
  PRIMARY KEY (`id_produccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `fecha_reg` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Frutas del Valle S.A.','Juan Pérez','Av. Principal 123, Ciudad Jardín','frutasdelvalle@correo.com','1234567890','2023-11-01 15:00:00'),(2,'Agroindustrias del Sur S.A.','María Rodríguez','Carretera Central Km 5, Pueblo Nuevo','agroindustrias@correo.com','9876543210','2023-10-25 20:30:00'),(3,'Pulpas Naturales S.A.','Pedro Gómez','Zona Industrial, Nave 10','pulpasnaturales@correo.com','5555555555','2023-12-03 14:15:00'),(4,'Exportadora del Pacífico S.A.','Ana Martínez','Puerto Marítimo, Muelle 2','exportadoradelpacifico@correo.com','3333333333','2023-09-20 19:00:00'),(5,'Cooperativa Agrícola El Sol','Luis Hernández','Finca La Esperanza, Valle del Cauca','cooperativaagricola@correo.com','7777777777','2024-01-15 16:30:00'),(6,'Frutas Exóticas S.A.','Sofía Ramírez','Zona Franca, Bodega 5','frutasexoticas@correo.com','2222222222','2023-12-10 21:45:00'),(7,'Agroindustria del Norte S.A.','Carlos López','Carretera Panamericana Km 20, Norte','agroindustridelnorte@correo.com','8888888888','2024-02-05 13:00:00'),(8,'Pulpas Andinas S.A.','Laura Silva','Sierra Nevada, Sector Industrial','pulpasandinas@correo.com','4444444444','2023-11-18 18:15:00'),(9,'Frutas Selectas S.A.','Diego Morales','Mercado Central, Locales 2-3','frutasselectas@correo.com','6666666666','2024-03-10 15:30:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'1050478237','Jeferson','Yandun','0983928','jje@gmail.com','azaya city','j','$2y$10$m61/MGBFyWwM3Dd5BtD2xOzfEDsPEGgIIXqBKJHLf1vaorukxbJtu',1,'2024-08-02 00:41:02'),(2,'102129','Angel','Pacheco','0390390','ibarra','jua@gmail.com','angel','$2y$10$pSFvSv9c3gFnK.L95uDaf.VSn5Yq5XF16CbrIau0Pn86rkMOY5Arq',2,'2024-08-02 00:41:02'),(35,'0401014766','Jhony','Peligro','098','maicol@gmail.com','wyhelaxi@mailinator.com','admin123','$2y$10$AwgwG6UuWds6aFNXQnqlt.3ldMILD/w5Bf4Dnt1B4Ks/XIkAJSRIu',1,'2024-10-24 14:39:02');
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
/*!50003 DROP PROCEDURE IF EXISTS `acc_invent_catalogo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `acc_invent_catalogo`(
    IN p_id_articulo INT,
    IN p_nombre_articulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_id_categoria INT,
    IN p_unidad_medida VARCHAR(50),
    IN p_estado VARCHAR(20),
    IN p_stock INT
)
BEGIN
    IF p_id_articulo = 0 THEN
        -- Si id_articulo es 0, se inserta un nuevo registro
        INSERT INTO invent_catalogo (nombre_articulo, descripcion, id_categoria, unidad_medida, estado, fecha_creacion, stock)
        VALUES (p_nombre_articulo, p_descripcion, p_id_categoria, p_unidad_medida, p_estado, CURDATE(), p_stock);
    ELSE
        -- Si id_articulo no es 0, se actualiza el registro existente
        UPDATE invent_catalogo
        SET nombre_articulo = p_nombre_articulo,
            descripcion = p_descripcion,
            id_categoria = p_id_categoria,
            unidad_medida = p_unidad_medida,
            estado = p_estado,
            stock = p_stock
        WHERE id_articulo = p_id_articulo;
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
/*!50003 DROP PROCEDURE IF EXISTS `obt_invCatalogo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obt_invCatalogo`()
BEGIN
    SELECT id_articulo, nombre_articulo, descripcion, id_categoria, unidad_medida, estado, fecha_creacion,stock
    FROM invent_catalogo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obt_invCatalogo_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obt_invCatalogo_id`(IN p_id_articulo INT)
BEGIN
    SELECT * FROM invent_catalogo WHERE id_articulo = p_id_articulo;
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
/*!50003 DROP PROCEDURE IF EXISTS `Obt_MP_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Obt_MP_por_id`(
    IN p_id_inv INT
)
BEGIN
    SELECT 
        i.id_inv,
        i.fecha,
        i.hora,
        i.id_articulo,
        i.proveedor_id,
        i.numero_lote,
        i.cantidad_ingresada,
        i.precio_unitario,
        i.presentacion,
        d.brix,
        d.bultos_o_canastas,
        d.peso_unitario,
        d.observacion
    FROM inventario i
    JOIN invent_detalle_mp d ON i.id_inv = d.id_inv
    WHERE i.id_inv = p_id_inv;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_DetalleLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DetalleLote`(IN lote_id INT)
BEGIN
    SELECT 
        inv.id_inv AS ID,
        inv.fecha AS Fecha,
        inv.hora AS Hora,
        inv.numero_lote AS Numero_Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Artículo,
        inv.cantidad_ingresada AS Cantidad_Ingresada,
        inv.cantidad_restante AS Cantidad_Restante,
        inv.unidad_medida AS Unidad_Medida,
        inv.presentacion AS Presentación,
        inv.estado AS Estado,
        inv.precio_unitario AS Precio_Unitario,
        inv.precio_total AS Precio_Total,
        det.bultos_o_canastas AS Bultos_Canastas,
        det.peso_unitario AS Peso_Unitario,
        det.brix AS Brix,
        det.observacion AS Observación,
        det.decision AS Aprobación
    FROM 
        inventario inv
    JOIN 
        proveedores prov ON inv.proveedor_id = prov.proveedor_id
    JOIN 
        invent_catalogo cat ON inv.id_articulo = cat.id_articulo
    LEFT JOIN 
        invent_detalle_MP det ON inv.id_inv = det.id_inv
    WHERE 
        inv.id_inv = lote_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EliminarRegistroMP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarRegistroMP`(IN p_id_inv INT)
BEGIN
    -- Primero eliminar el registro relacionado en invent_detalle_MP si existe
    DELETE FROM invent_detalle_MP
    WHERE id_inv = p_id_inv;

    -- Luego eliminar el registro principal en inventario
    DELETE FROM inventario
    WHERE id_inv = p_id_inv;
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
        inv.fecha AS Fecha,
        inv.hora AS Hora,
        inv.numero_lote AS Lote,
        prov.nombre_empresa AS Proveedor,
        cat.nombre_articulo AS Artículo,
        inv.cantidad_restante AS Cantidad_Disponible,
        inv.estado AS Estado,
        inv.precio_total AS Precio_Total  -- o inv.precio_unitario si prefieres
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

-- Dump completed on 2024-11-13  6:46:05
