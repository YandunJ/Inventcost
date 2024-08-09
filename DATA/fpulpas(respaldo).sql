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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (8,'10353873','nuevo','sus','29238','dsj@gmail.com','iabrra'),(18,'2390482309','cristian ','yandun','09328923','hj@gmail.com','iabrra city'),(19,'232423','revision','rev','493498','ejnw@fjs','cas'),(20,'1293729','chat','gpt','666','gpt@gmail.com','google'),(21,'283764783','pruebaPRUEBA ','PRUEBA','2939','pruebasp','sp'),(24,'123213','asdsa','asd','12123','asda','asda@fjha'),(29,'9999','jose','jose','000','skaj@dhja','urcuqui'),(33,'2394723987423874729','dkjwenk1sdkj','sdkjfbwk','23098','sdknks','prueba@gmail'),(34,'101298238','sdjjsg','dsjhf','3454353','jweefg','jsdh@gmail');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frutas`
--

LOCK TABLES `frutas` WRITE;
/*!40000 ALTER TABLE `frutas` DISABLE KEYS */;
INSERT INTO `frutas` VALUES (1,'Manzana','nueva furta'),(2,'Banana','Fruta amarilla, dulce y suave'),(3,'Pera','Fruta verde, dulce y jugosa'),(4,'Mango','Fruta tropical dulce y jugosa.'),(5,'Fresa','Pequeña fruta roja y jugosa con semillas externas.'),(6,'Mango','nuevo xd'),(7,'pablo','cambio de fruta'),(11,'nueva fruta','manzana azul'),(16,'asa','as');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (3,'cofia dos','para pulpas','unidad','Producción');
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_insumos`
--

DROP TABLE IF EXISTS `inventario_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_insumos` (
  `registroinsumo_id` int NOT NULL AUTO_INCREMENT,
  `insumo_id` int DEFAULT NULL,
  `proveedor_id` int DEFAULT NULL,
  `fecha_hora_ing` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad` decimal(10,0) DEFAULT NULL,
  `precio_unitario` decimal(10,0) DEFAULT NULL,
  `precio_total` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`registroinsumo_id`),
  KEY `insumo_id` (`insumo_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `inventario_insumos_ibfk_1` FOREIGN KEY (`insumo_id`) REFERENCES `insumos` (`insumo_id`),
  CONSTRAINT `inventario_insumos_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_insumos`
--

LOCK TABLES `inventario_insumos` WRITE;
/*!40000 ALTER TABLE `inventario_insumos` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia_prima`
--

LOCK TABLES `materia_prima` WRITE;
/*!40000 ALTER TABLE `materia_prima` DISABLE KEYS */;
INSERT INTO `materia_prima` VALUES (1,2,'2024-07-25 15:00:00','2024-12-23',2,50.00,1.50,11.40,11.00,'cajas','no_aprobado','ninguna'),(2,2,'2024-07-25 16:00:00','2024-12-30',2,80.00,1.80,144.00,15.00,'bultos','aprobado','Lote fresco de peras.'),(3,6,'2024-07-26 18:10:09','2024-07-30',1,50.00,1.50,75.00,12.20,'bultos','aprobado','ninguna'),(4,1,'2024-07-29 10:40:08','2024-07-29',1,12.00,12.00,144.00,12.00,'cajas','no_aprobado','naeq'),(18,1,'2024-08-08 10:43:27','2000-06-18',1,26.00,47.00,1222.00,15.00,'cajas','no_aprobado','nuevp utlimo'),(19,2,'2024-08-08 10:49:59','2024-09-07',2,12.00,12.00,12.00,12.00,'cajas','aprobado','camio 2\r\n'),(21,6,'2024-08-08 11:09:54','2017-06-08',7,93.00,88.00,8184.00,21.00,'cajas','no_aprobado','cambiooooo'),(22,16,'2024-08-08 11:21:29','1990-06-21',7,9.00,83.00,747.00,79.00,'cajas','aprobado','Eveniet consequatur'),(28,11,'2024-08-08 17:03:53','2003-11-08',13,58.00,87.00,5046.00,57.00,'cajas','en_revision','Minima autem dolore '),(33,1,'2024-08-08 17:11:31','2024-08-10',4,13.00,12.00,156.00,12.00,'bultos','en_revision','aaa'),(34,11,'2024-08-08 17:13:04','1975-07-22',7,47.00,47.00,2209.00,5.00,'cajas','en_revision','Beatae doloribus tem'),(37,7,'2024-08-08 17:14:54','2016-04-03',7,53.00,90.00,4770.00,63.00,'cajas','en_revision','Ipsa rerum minus ve'),(38,1,'2024-08-08 17:18:48','2024-08-10',2,11.00,11.00,121.00,11.00,'cajas','en_revision','as');
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
  `prod_id` int NOT NULL AUTO_INCREMENT,
  `fecha_produccion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `mp_id` int DEFAULT NULL,
  `cantidad_utilizada` decimal(10,2) DEFAULT NULL,
  `cantidad_obtenida` decimal(10,2) DEFAULT NULL,
  `costo_total` decimal(10,2) DEFAULT NULL,
  `estado` enum('aprobado','no_aprobado') DEFAULT 'no_aprobado',
  `usuario_id` int DEFAULT NULL,
  PRIMARY KEY (`prod_id`),
  KEY `mp_id` (`mp_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `produccion_ibfk_1` FOREIGN KEY (`mp_id`) REFERENCES `materia_prima` (`mp_id`),
  CONSTRAINT `produccion_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
INSERT INTO `produccion` VALUES (1,'2024-07-26 17:50:10',1,50.00,40.00,30.00,'aprobado',1);
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_rest_materia_prima` AFTER INSERT ON `produccion` FOR EACH ROW BEGIN
    UPDATE materia_prima 
    SET cantidad = cantidad - NEW.cantidad_utilizada
    WHERE mp_id = NEW.mp_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Proveedor A','Juan Perez','Dirección 1','contacto@proveedora.com','123456789','2024-07-30 11:19:22'),(2,'Proveedor B','Maria Gomez','Dirección 2','contacto@proveedorb.com','987654321','2024-07-30 11:19:22'),(3,'Proveedor C','Pablo Marmol','Dirección 3','contacto@proveedorb.com','9823432','2024-07-30 11:24:14'),(4,'jesus','nuevo era','ibarra ayer','jad@asi.com','984729666','2024-07-30 14:36:52'),(7,'Quis pariatur Quia ','Aliqua Laudantium ','Est corrupti impedi','fyje@mailinator.com','28374t827','2024-07-30 15:04:52'),(9,'suihiah','suiaahdi','aisjdi','asdnia','3987','2024-07-31 16:27:52'),(10,'cambio','alfredo','ibarra','aksn@fjs.com','3992','2024-07-31 16:37:39'),(12,'zzzz','bbbbb','ccccc','asdsa@asdsa','342423','2024-08-01 23:43:41'),(13,'cambio','cambio','cambio','cambio@gakj','32938','2024-08-01 23:50:14');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Control y acceso a todas las funcionalidades del sistema',1,'2024-08-01'),(2,'Bodeguero Materia Prima','Acceso a el ingreso de materia prima e insumos',2,'2024-08-01'),(3,'Encargado De Produccion','Control de la produccion de pulpa de furta e insumos',3,'2024-08-01'),(4,'Bodeguero Producto Terminado','Control de los productos terminados',4,'2024-08-01'),(5,'correccion','cambio de rol editar',2,'2024-08-01'),(6,'cambio 2','nuevo rol xddd',3,'2024-08-01');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'1050478237','Jeferson','Yandun','0983928','jje@gmail.com','azaya city','j','$2y$10$m61/MGBFyWwM3Dd5BtD2xOzfEDsPEGgIIXqBKJHLf1vaorukxbJtu',1,'2024-08-02 00:41:02'),(2,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra','p','$2y$10$AsLrH2TTdYzl0pvbb9350ui5T0oSqum48bKrhyethF/6Gu38EVyju',2,'2024-08-02 00:41:02'),(10,'901293791','david carrilo','pineda','92837428','urcuqui','ajksa@gamial.com','b','$2y$10$5O4UETZiCDnoQVWgRNbzUObRO2Gnzt0j8Nlyx8Y3XHuI1w6nJQ3zK',3,'2024-08-02 00:41:02'),(20,'2222','ola','ola','00202','ola@gamai','ola','ola','ola',3,'2024-08-02 16:08:51'),(27,'10505478347','Jeferson','Yandun','0982823717','Ibarra- Azaya City','jeffersonyandun01@gmail.com','admin','$2y$10$.7VTYowLG.mr8I2Fl6Ehp.djK/apE2HQyziH9JNIOYar06sbOKotC',1,'2024-08-06 09:39:09'),(28,'2394723987423874729','dkjwenk1sdkj','sdkjfbwk','23098','sdknks','prueba@gmail','prueba','$2y$10$9F7cimKWl5E71J1sHPaTaem83.tmSHAMih6mvHqldddi9H.8NqcfO',2,'2024-08-06 15:45:01'),(29,'101298238','sdjjsg','dsjhf','3454353','jweefg','jsdh@gmail','usu','$2y$10$XiXskpX2R6WTUOEGa6cl4udRNhKi3z628zS8AluH5GTTnCUk02//C',3,'2024-08-06 16:06:44');
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
    IN p_emp_cedula VARCHAR(20),
    IN p_emp_nombre VARCHAR(255),
    IN p_emp_apellido VARCHAR(255),
    IN p_emp_telefono VARCHAR(15),
    IN p_emp_correo VARCHAR(255),
    IN p_emp_direccion VARCHAR(255)
)
BEGIN
    DECLARE v_usuario_count INT;
    
    -- Verificar si el empleado es también un usuario
    SELECT COUNT(*) INTO v_usuario_count
    FROM usuarios
    WHERE usu_cedula = p_emp_cedula;

    -- Si el empleado no es usuario, permitir registrar o actualizar
    IF v_usuario_count = 0 THEN
        IF p_emp_id IS NULL THEN
            -- Insertar nuevo empleado
            INSERT INTO empleados (emp_cedula, emp_nombre, emp_apellido, emp_telefono, emp_correo, emp_direccion)
            VALUES (p_emp_cedula, p_emp_nombre, p_emp_apellido, p_emp_telefono, p_emp_correo, p_emp_direccion);
        ELSE
            -- Actualizar empleado existente
            UPDATE empleados
            SET emp_cedula = p_emp_cedula,
                emp_nombre = p_emp_nombre,
                emp_apellido = p_emp_apellido,
                emp_telefono = p_emp_telefono,
                emp_correo = p_emp_correo,
                emp_direccion = p_emp_direccion
            WHERE emp_id = p_emp_id;
        END IF;
    ELSE
        -- Si el empleado es usuario, no permitir registrar o actualizar
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede registrar o actualizar un empleado que también es usuario.';
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
        mp_id, fruta_id, fecha_hora_ing, fecha_cad, proveedor_id, cantidad, precio_unit, precio_total, birx, presentacion, estado, observaciones
    FROM materia_prima;
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
        usu_correo, 
        usu_direccion, 
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

-- Dump completed on 2024-08-08 12:45:50
