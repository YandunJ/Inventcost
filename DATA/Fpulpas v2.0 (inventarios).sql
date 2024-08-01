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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'0402023983','pablo','emilio','0696969','pablo@gmail.com','su casa'),(2,'0402023983','pablo','emilio','0696969','pablo@gmail.com','su casa'),(3,'0402023983','pablo','emilio','0696969','pablo@gmail.com','su casa'),(4,'0402023983','angel','pacheco','0696969','angel@gmail.com','urcu city'),(5,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(6,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(7,'10353873','nuevo','sus','29238','dsj@gmail.com','iabrra'),(8,'10353873','nuevo','sus','29238','dsj@gmail.com','iabrra'),(9,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(10,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(11,'04034938','Ultimo','xd','0983434','ppf@gmail.com','ibarra'),(12,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca'),(13,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca'),(14,'23423','Non et facilis id m','Voluptatem aut qui ','23242','sobyvuqad@mailinator.com','Veniam velit cillu'),(15,'901293791','said','pineda','92837428','ajksa@gamial.com','urcuqui'),(16,'90823667','nuevo','pablo','98238723','aksjdhka@gmail','akjdbjasadkj'),(17,'1047382617','Maicol','Suarez','92748392','maicol@gmail.com','Imbabura- Urcuqui');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frutas`
--

LOCK TABLES `frutas` WRITE;
/*!40000 ALTER TABLE `frutas` DISABLE KEYS */;
INSERT INTO `frutas` VALUES (1,'Manzana','Fruta roja, dulce y crujiente'),(2,'Banana','Fruta amarilla, dulce y suave'),(3,'Pera','Fruta verde, dulce y jugosa'),(4,'Mango','Fruta tropical dulce y jugosa.'),(5,'Fresa','Pequeña fruta roja y jugosa con semillas externas.'),(6,'Mango','nuevo xd');
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
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `unidad_medida` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`insumo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (1,'Azúcar','Azúcar refinada para endulzar.','kg'),(2,'Envases','Envases de plástico para pulpas.','unidad'),(3,'Saborizante','Saborizante natural.','litro'),(4,'Azúcar','Azúcar blanco refinado','kg'),(5,'Saborizante','Saborizante artificial','ml'),(6,'Ácido Cítrico','Conservante natural','g');
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
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`registroinsumo_id`),
  KEY `insumo_id` (`insumo_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `inventario_insumos_ibfk_1` FOREIGN KEY (`insumo_id`) REFERENCES `insumos` (`insumo_id`),
  CONSTRAINT `inventario_insumos_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_insumos`
--

LOCK TABLES `inventario_insumos` WRITE;
/*!40000 ALTER TABLE `inventario_insumos` DISABLE KEYS */;
INSERT INTO `inventario_insumos` VALUES (1,1,2,'2024-07-25 15:00:00',50,2.00,100.00),(2,2,2,'2024-07-25 16:00:00',30,5.00,150.00),(3,3,1,'2024-07-25 17:00:00',25,1.00,13.00),(4,1,2,'2024-07-25 15:00:00',50,2.00,100.00),(5,2,2,'2024-07-25 16:00:00',30,5.00,150.00),(6,3,1,'2024-07-25 17:00:00',25,1.00,13.00),(7,1,2,'2024-07-25 15:00:00',50,2.00,100.00),(8,2,2,'2024-07-25 16:00:00',30,5.00,150.00),(9,3,1,'2024-07-25 17:00:00',25,0.50,12.50);
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
  `estado` enum('aprobado','no_aprobado') DEFAULT 'no_aprobado',
  `usuario_id` int DEFAULT NULL,
  `observaciones` text,
  PRIMARY KEY (`mp_id`),
  KEY `fruta_id` (`fruta_id`),
  KEY `proveedor_id` (`proveedor_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `materia_prima_ibfk_1` FOREIGN KEY (`fruta_id`) REFERENCES `frutas` (`fruta_id`),
  CONSTRAINT `materia_prima_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`),
  CONSTRAINT `materia_prima_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia_prima`
--

LOCK TABLES `materia_prima` WRITE;
/*!40000 ALTER TABLE `materia_prima` DISABLE KEYS */;
INSERT INTO `materia_prima` VALUES (1,1,'2024-07-25 15:00:00','2024-12-25',1,100.00,1.50,150.00,12.50,'aprobado',1,'Lote de buena calidad.'),(2,2,'2024-07-25 16:00:00','2024-12-30',2,80.00,1.80,144.00,15.00,'aprobado',1,'Lote fresco de peras.'),(3,6,'2024-07-26 18:10:09','2024-07-30',1,50.00,1.50,75.00,12.20,'aprobado',2,'ninguna');
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
-- Table structure for table `produccion_insumos`
--

DROP TABLE IF EXISTS `produccion_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produccion_insumos` (
  `pi_id` int NOT NULL AUTO_INCREMENT,
  `prod_id` int DEFAULT NULL,
  `insumo_id` int DEFAULT NULL,
  `cantidad_insumo` decimal(10,2) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`pi_id`),
  KEY `prod_id` (`prod_id`),
  KEY `insumo_id` (`insumo_id`),
  CONSTRAINT `produccion_insumos_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produccion` (`prod_id`),
  CONSTRAINT `produccion_insumos_ibfk_2` FOREIGN KEY (`insumo_id`) REFERENCES `insumos` (`insumo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion_insumos`
--

LOCK TABLES `produccion_insumos` WRITE;
/*!40000 ALTER TABLE `produccion_insumos` DISABLE KEYS */;
INSERT INTO `produccion_insumos` VALUES (1,1,1,10.00,20.00),(2,1,2,5.00,25.00),(3,1,3,2.00,1.00);
/*!40000 ALTER TABLE `produccion_insumos` ENABLE KEYS */;
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
  PRIMARY KEY (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Proveedor A','Juan Perez','Dirección 1','contacto@proveedora.com','123456789'),(2,'Proveedor B','Maria Gomez','Dirección 2','contacto@proveedorb.com','987654321');
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
  PRIMARY KEY (`rol_id`),
  KEY `permiso_id` (`permiso_id`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`permiso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Control y acceso a todas las funcionalidades del sistema',1),(2,'Bodeguero Materi Prima','Acceso a el ingreso de materia prima e insumos',2),(3,'Encargado De Produccion','Control de la produccion de pulpa de furta e insumos',3),(4,'Bodeguero Producto Terminado','Control de los productos terminados',4),(5,'among us','nuevo nose',2),(6,'asa','sa',1),(8,'Facere dolores sit ','Sunt est eum quae of',4),(9,'prueba','prueba roles',3),(10,'asa','as',3),(11,'asa','as',3),(12,'nuevo','nuyevo rol xd',2),(13,'nuevo rol','rol nuevo',3),(14,'sus','sus',3),(15,'asa','asa',2),(16,'nuevo','sus',2);
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
  PRIMARY KEY (`usu_id`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'1050478237','Jeferson','Yandun','0983928','jje@gmail.com','azaya city','j','j',1),(2,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra','p','p',2),(3,'10353873','nuevo','sus','29238','dsj@gmail.com','iabrra','n','n',3),(4,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra','p','p',4),(5,'04034938','Ultimo','xd','0983434','ppf@gmail.com','ibarra','p','p',2),(6,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca','s','s',1),(7,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca','s','s',2),(8,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca','s','s',2),(9,'23423','Non et facilis id m','Voluptatem aut qui ','23242','sobyvuqad@mailinator.com','Veniam velit cillu','a','a',6),(10,'901293791','said','pineda','92837428','ajksa@gamial.com','urcuqui','a','a',3),(11,'928137','ajhdbqwjw','sdjfsj','928347','sdkfuuh@fjhsj','sjfdchj','p','p',1),(12,'90823667','nuevo','pablo','98238723','aksjdhka@gmail','akjdbjasadkj','usu','usu',2),(13,'1047382617','Maicol','Suarez','92748392','maicol@gmail.com','Imbabura- Urcuqui','administrador','administrador',2);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'fpulpas'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualizar_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_rol`(IN p_rol_id INT, IN p_rol_nombre VARCHAR(45), IN p_rol_descripcion VARCHAR(255), IN p_permiso_id INT)
BEGIN
    UPDATE roles
    SET rol_nombre = p_rol_nombre, rol_descripcion = p_rol_descripcion, permiso_id = p_permiso_id
    WHERE rol_id = p_rol_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_eliminar_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_rol`(IN p_rol_id INT)
BEGIN
    DELETE FROM roles WHERE rol_id = p_rol_id;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertar_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_proveedor`(
    IN p_prov_ruc VARCHAR(20),
    IN p_prov_nombre_empresa VARCHAR(255),
    IN p_prov_representante VARCHAR(255),
    IN p_prov_direccion VARCHAR(255),
    IN p_prov_correo VARCHAR(255),
    IN p_prov_telefono VARCHAR(15)
)
BEGIN
    INSERT INTO proveedores (prov_ruc, prov_nombre_empresa, prov_representante, prov_direccion, prov_correo, prov_telefono)
    VALUES (p_prov_ruc, p_prov_nombre_empresa, p_prov_representante, p_prov_direccion, p_prov_correo, p_prov_telefono);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_obtener_roles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_roles`()
BEGIN
    SELECT * FROM roles;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_rol`(
    IN p_rol_nombre VARCHAR(45),
    IN p_rol_descripcion VARCHAR(255),
    IN p_permiso_id INT
)
BEGIN
    INSERT INTO roles (rol_nombre, rol_descripcion, permiso_id)
    VALUES (p_rol_nombre, p_rol_descripcion, p_permiso_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_usuario`(
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
    INSERT INTO usuarios (usu_cedula, usu_nombre, usu_apellido, usu_telefono, usu_correo, usu_direccion, usu_usuario, usu_contrasenia, rol_id)
    VALUES (p_usu_cedula, p_usu_nombre, p_usu_apellido, p_usu_telefono, p_usu_correo, p_usu_direccion, p_usu_usuario, p_usu_contrasenia, p_rol_id);

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
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_fruta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_fruta`(
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    INSERT INTO frutas (nombre, descripcion)
    VALUES (p_nombre, p_descripcion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reg_insumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_insumo`(
    IN p_nombre VARCHAR(255),
    IN p_descripcion TEXT,
    IN p_unidad_medida VARCHAR(50)
)
BEGIN
    INSERT INTO insumos (nombre, descripcion, unidad_medida)
    VALUES (p_nombre, p_descripcion, p_unidad_medida);
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-26 17:47:57
