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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'0402023983','pablo','emilio','0696969','pablo@gmail.com','su casa'),(2,'0402023983','pablo','emilio','0696969','pablo@gmail.com','su casa'),(3,'0402023983','pablo','emilio','0696969','pablo@gmail.com','su casa'),(4,'0402023983','angel','pacheco','0696969','angel@gmail.com','urcu city'),(5,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(6,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(7,'10353873','nuevo','sus','29238','dsj@gmail.com','iabrra'),(8,'10353873','nuevo','sus','29238','dsj@gmail.com','iabrra'),(9,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(10,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra'),(11,'04034938','Ultimo','xd','0983434','ppf@gmail.com','ibarra'),(12,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumos`
--

DROP TABLE IF EXISTS `insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insumos` (
  `insumo_id` int NOT NULL AUTO_INCREMENT,
  `insumo_fecha_hora` datetime DEFAULT NULL,
  `insumo_tipo` varchar(255) DEFAULT NULL,
  `insumo_nombre` varchar(255) DEFAULT NULL,
  `insumo_cantidad` double DEFAULT NULL,
  `insumo_unidad_medida` varchar(50) DEFAULT NULL,
  `insumo_precio_unidad` double DEFAULT NULL,
  `insumo_precio_total` double DEFAULT NULL,
  `proveedor_id` int DEFAULT NULL,
  PRIMARY KEY (`insumo_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `insumos_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`prov_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (1,'2024-07-13 15:00:00','desinfeccion','marscarillas',3,'cajas',5,15,1);
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;
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
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `prov_id` int NOT NULL AUTO_INCREMENT,
  `prov_ruc` varchar(20) DEFAULT NULL,
  `prov_nombre_empresa` varchar(255) DEFAULT NULL,
  `prov_representante` varchar(255) DEFAULT NULL,
  `prov_direccion` varchar(255) DEFAULT NULL,
  `prov_correo` varchar(255) DEFAULT NULL,
  `prov_telefono` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`prov_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'1050478237','franfruit','pepe','su casa','pepe@gamil.com','093393');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Control y acceso a todas las funcionalidades del sistema',1),(2,'Bodeguero Materi Prima','Acceso a el ingreso de materia prima e insumos',2),(3,'Encargado De Produccion','Control de la produccion de pulpa de furta e insumos',3),(4,'Bodeguero Producto Terminado','Control de los productos terminados',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'1050478237','Jeferson','Yandun','0983928','jje@gmail.com','azaya city','j','j',1),(2,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra','p','p',2),(3,'10353873','nuevo','sus','29238','dsj@gmail.com','iabrra','n','n',3),(4,'04034938','Angel','Chapeco','0983434','ppf@gmail.com','ibarra','p','p',4),(5,'04034938','Ultimo','xd','0983434','ppf@gmail.com','ibarra','p','p',2),(6,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca','s','s',1),(7,'0401014766','sus','nar','0939383','sus@gamil.com','alpahcaca','s','s',2);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'fpulpas'
--

--
-- Dumping routines for database 'fpulpas'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualizar_materiaprima` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_materiaprima`(
    IN p_mp_id INT,
    IN p_cantidad_usada DECIMAL(10,2)
)
BEGIN
    DECLARE v_cantidad_actual DECIMAL(10,2);

    -- Obtener la cantidad actual de materia prima
    SELECT mp_cantidad
    INTO v_cantidad_actual
    FROM materiaprima
    WHERE mp_id = p_mp_id;

    -- Verificar si hay suficiente materia prima
    IF v_cantidad_actual >= p_cantidad_usada THEN
        -- Actualizar la cantidad de materia prima
        UPDATE materiaprima
        SET mp_cantidad = v_cantidad_actual - p_cantidad_usada
        WHERE mp_id = p_mp_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad insuficiente de materia prima';
    END IF;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertar_materiaprima` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_materiaprima`(
    IN p_mp_fecha_hora_ingreso DATETIME,
    IN p_mp_lote VARCHAR(50),
    IN p_mp_tipo VARCHAR(255),
    IN p_mp_cantidad DECIMAL(10,2),
    IN p_mp_unidad_medida VARCHAR(50),
    IN p_mp_precio_unitario DECIMAL(10,2),
    IN p_mp_precio_total DECIMAL(10,2),
    IN p_mp_birx DECIMAL(5,2),
    IN p_mp_estado VARCHAR(50),
    IN p_mp_fecha_caducidad DATE,
    IN p_usu_nombre VARCHAR(255),
    IN p_usu_apellido VARCHAR(255),
    IN p_mp_observaciones TEXT,
    IN p_prov_id INT,
    IN p_usu_id INT
)
BEGIN
    INSERT INTO materiaprima (mp_fecha_hora_ingreso, mp_lote, mp_tipo, mp_cantidad, mp_unidad_medida, mp_precio_unitario, mp_precio_total, mp_birx, mp_estado, mp_fecha_caducidad, usu_nombre, usu_apellido, mp_observaciones, prov_id, usu_id)
    VALUES (p_mp_fecha_hora_ingreso, p_mp_lote, p_mp_tipo, p_mp_cantidad, p_mp_unidad_medida, p_mp_precio_unitario, p_mp_precio_total, p_mp_birx, p_mp_estado, p_mp_fecha_caducidad, p_usu_nombre, p_usu_apellido, p_mp_observaciones, p_prov_id, p_usu_id);
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-19  9:43:06
