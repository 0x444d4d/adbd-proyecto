USE `cinesDB`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: cinesDB
-- ------------------------------------------------------
-- Server version	5.7.33-0ubuntu0.18.04.1

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
-- Table structure for table `Pedido`
--

DROP TABLE IF EXISTS `Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `precio` int(11) DEFAULT NULL,
  `lugar` int(11) NOT NULL,
  `dni_persona` varchar(9) NOT NULL,
  `cafeteria` int(11) DEFAULT NULL,
  `cine_lugar` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedido_persona_idx` (`dni_persona`),
  KEY `fk_Pedido_lugar_idx` (`lugar`,`cine_lugar`),
  CONSTRAINT `fk_Pedido_lugar` FOREIGN KEY (`lugar`, `cine_lugar`) REFERENCES `lugar` (`id_lugar`, `cine_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_persona` FOREIGN KEY (`dni_persona`) REFERENCES `persona` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
INSERT INTO `Pedido` VALUES (1,8,2,'11111111A',2,'Cine2'),(2,2,2,'11111111A',2,'Cine2');
/*!40000 ALTER TABLE `Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `butaca`
--

DROP TABLE IF EXISTS `butaca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `butaca` (
  `numero` int(11) NOT NULL,
  `numero_sala` int(11) NOT NULL,
  `nombre_cine_sala` varchar(45) NOT NULL,
  PRIMARY KEY (`numero`,`numero_sala`,`nombre_cine_sala`),
  KEY `fk_butaca_sala_idx` (`numero_sala`,`nombre_cine_sala`),
  CONSTRAINT `fk_butaca_sala` FOREIGN KEY (`numero_sala`, `nombre_cine_sala`) REFERENCES `sala` (`numero`, `nombre_cine`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `butaca`
--

LOCK TABLES `butaca` WRITE;
/*!40000 ALTER TABLE `butaca` DISABLE KEYS */;
INSERT INTO `butaca` VALUES (1,1,'Cine1'),(2,1,'Cine1'),(3,1,'Cine1'),(4,1,'Cine1'),(5,1,'Cine1'),(6,1,'Cine1'),(7,1,'Cine1'),(8,1,'Cine1'),(9,1,'Cine1'),(10,1,'Cine1'),(1,4,'Yelmo'),(2,4,'Yelmo'),(3,4,'Yelmo'),(4,4,'Yelmo'),(5,4,'Yelmo'),(6,4,'Yelmo'),(7,4,'Yelmo'),(8,4,'Yelmo'),(9,4,'Yelmo'),(10,4,'Yelmo'),(11,4,'Yelmo'),(12,4,'Yelmo'),(13,4,'Yelmo'),(14,4,'Yelmo'),(15,4,'Yelmo'),(16,4,'Yelmo'),(17,4,'Yelmo'),(18,4,'Yelmo'),(19,4,'Yelmo'),(20,4,'Yelmo'),(21,4,'Yelmo'),(22,4,'Yelmo'),(23,4,'Yelmo'),(24,4,'Yelmo'),(25,4,'Yelmo'),(26,4,'Yelmo'),(27,4,'Yelmo'),(28,4,'Yelmo'),(29,4,'Yelmo'),(30,4,'Yelmo');
/*!40000 ALTER TABLE `butaca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cafeteria`
--

DROP TABLE IF EXISTS `cafeteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafeteria` (
  `id_lugar` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `aforo` int(11) NOT NULL,
  `apertura` time DEFAULT NULL,
  `cierre` time DEFAULT NULL,
  `nombre_cine` varchar(45) NOT NULL,
  PRIMARY KEY (`id_lugar`,`nombre_cine`),
  KEY `fk_cafeteria_cine_idx` (`nombre_cine`),
  CONSTRAINT `fk_cafeteria_1` FOREIGN KEY (`nombre_cine`) REFERENCES `lugar` (`cine_lugar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cafeteria_cine` FOREIGN KEY (`nombre_cine`) REFERENCES `cine` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafeteria`
--

LOCK TABLES `cafeteria` WRITE;
/*!40000 ALTER TABLE `cafeteria` DISABLE KEYS */;
INSERT INTO `cafeteria` VALUES (2,'Principal',20,'12:00:00','18:00:00','Cine2'),(3,'Mexicano',10,'18:00:00','23:00:00','Cine2');
/*!40000 ALTER TABLE `cafeteria` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuario`@`%`*/ /*!50003 TRIGGER `cinesDB`.`cafeteria_BEFORE_INSERT` BEFORE INSERT ON `cafeteria` FOR EACH ROW
BEGIN
	insert into lugar(`id_lugar`, `cine_lugar`) values (NEW.id_lugar, NEW.nombre_cine); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cafeteria_oferta_comida`
--

DROP TABLE IF EXISTS `cafeteria_oferta_comida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafeteria_oferta_comida` (
  `idcomida` int(11) NOT NULL,
  `idcafeteria` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcomida`,`idcafeteria`),
  KEY `fk_oferta_cafeteria_idx` (`idcafeteria`),
  CONSTRAINT `fk_oferta_cafeteria` FOREIGN KEY (`idcafeteria`) REFERENCES `cafeteria` (`id_lugar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_oferta_comida` FOREIGN KEY (`idcomida`) REFERENCES `comida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafeteria_oferta_comida`
--

LOCK TABLES `cafeteria_oferta_comida` WRITE;
/*!40000 ALTER TABLE `cafeteria_oferta_comida` DISABLE KEYS */;
INSERT INTO `cafeteria_oferta_comida` VALUES (1,2,8),(1,3,8),(2,2,4),(3,2,2);
/*!40000 ALTER TABLE `cafeteria_oferta_comida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cine`
--

DROP TABLE IF EXISTS `cine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cine` (
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `apertura` time NOT NULL,
  `cierre` time NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cine`
--

LOCK TABLES `cine` WRITE;
/*!40000 ALTER TABLE `cine` DISABLE KEYS */;
INSERT INTO `cine` VALUES ('Cine1','calle 1','12:00:00','23:59:59'),('Cine2','calle 2','12:00:00','23:59:59'),('Yelmo','santa cruz','13:00:00','23:00:00');
/*!40000 ALTER TABLE `cine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comida`
--

DROP TABLE IF EXISTS `comida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comida` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripccion` varchar(45) DEFAULT NULL,
  `ingredientes` varchar(45) NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comida`
--

LOCK TABLES `comida` WRITE;
/*!40000 ALTER TABLE `comida` DISABLE KEYS */;
INSERT INTO `comida` VALUES (1,'cotufas','cotufas con sal','millo, sal',3),(2,'papas local','papas con queso y jamón','papas, queso, jamón',5),(3,'refresco','refresco','agua, sal',2);
/*!40000 ALTER TABLE `comida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra_persona_butaca`
--

DROP TABLE IF EXISTS `compra_persona_butaca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra_persona_butaca` (
  `persona` varchar(45) NOT NULL,
  `butaca` int(11) NOT NULL,
  `hora_sesion` datetime NOT NULL,
  `sala_butaca` int(11) NOT NULL,
  `cine_butaca` varchar(45) NOT NULL,
  PRIMARY KEY (`persona`,`butaca`,`hora_sesion`,`sala_butaca`,`cine_butaca`),
  KEY `fk_historico_persona_butaca_butaca_idx` (`butaca`,`sala_butaca`,`cine_butaca`),
  CONSTRAINT `fk_historico_persona_butaca_butaca` FOREIGN KEY (`butaca`, `sala_butaca`, `cine_butaca`) REFERENCES `butaca` (`numero`, `numero_sala`, `nombre_cine_sala`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_historico_persona_butaca_persona` FOREIGN KEY (`persona`) REFERENCES `persona` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_persona_butaca`
--

LOCK TABLES `compra_persona_butaca` WRITE;
/*!40000 ALTER TABLE `compra_persona_butaca` DISABLE KEYS */;
INSERT INTO `compra_persona_butaca` VALUES ('11111111A',1,'2021-01-22 17:00:00',1,'Cine1'),('22222222A',2,'2021-01-22 17:00:00',1,'Cine1');
/*!40000 ALTER TABLE `compra_persona_butaca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` (
  `id` varchar(45) NOT NULL,
  `no_miembros` int(11) NOT NULL,
  `dni_responsable` varchar(9) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `responsable_UNIQUE` (`dni_responsable`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
INSERT INTO `grupo` VALUES ('1',1,'4','2021-02-07'),('colegas',3,'11111111A','2021-02-08'),('colegas2',1,'44444444A','2021-02-08');
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lugar`
--

DROP TABLE IF EXISTS `lugar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lugar` (
  `id_lugar` int(11) NOT NULL,
  `cine_lugar` varchar(45) NOT NULL,
  PRIMARY KEY (`id_lugar`,`cine_lugar`),
  KEY `fk_lugar_cine_idx` (`cine_lugar`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lugar`
--

LOCK TABLES `lugar` WRITE;
/*!40000 ALTER TABLE `lugar` DISABLE KEYS */;
INSERT INTO `lugar` VALUES (1,'Cine1'),(2,'Cine2'),(3,'Cine2'),(4,'Yelmo');
/*!40000 ALTER TABLE `lugar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_incluye_comida`
--

DROP TABLE IF EXISTS `pedido_incluye_comida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_incluye_comida` (
  `idpedido` int(11) NOT NULL,
  `idcomida` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `cafeteria` int(11) NOT NULL,
  PRIMARY KEY (`idpedido`,`idcomida`),
  KEY `fk_comida_idx` (`idcomida`),
  KEY `fk_cafeteria_idx` (`cafeteria`),
  CONSTRAINT `fk_cafeteria` FOREIGN KEY (`cafeteria`) REFERENCES `cafeteria` (`id_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comida` FOREIGN KEY (`idcomida`) REFERENCES `comida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido` FOREIGN KEY (`idpedido`) REFERENCES `Pedido` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_incluye_comida`
--

LOCK TABLES `pedido_incluye_comida` WRITE;
/*!40000 ALTER TABLE `pedido_incluye_comida` DISABLE KEYS */;
INSERT INTO `pedido_incluye_comida` VALUES (1,1,2,2),(1,2,1,2),(2,3,1,2);
/*!40000 ALTER TABLE `pedido_incluye_comida` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuario`@`%`*/ /*!50003 TRIGGER `cinesDB`.`pedido_incluye_comida_BEFORE_INSERT` BEFORE INSERT ON `pedido_incluye_comida` FOR EACH ROW
BEGIN
	declare curr_price int;
    declare prod_price int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
        RESIGNAL;
    DECLARE EXIT HANDLER FOR SQLWARNING
        RESIGNAL;
    DECLARE EXIT HANDLER FOR NOT FOUND
        RESIGNAL; 
	call procedure_reducir_stock_cafeteria(new.idcomida, new.cantidad, new.cafeteria);
    if not exists(select pedido.id from Pedido as pedido where pedido.id = new.idpedido) then
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'No existe el pedido, crea el pedido antes de añadir items';
    else
		set curr_price = (select pedido.precio from Pedido as pedido where pedido.id = new.idpedido);
        set prod_price = (select comida.precio from comida where comida.id = new.idcomida);
        update Pedido set Pedido.precio = (curr_price + prod_price) where Pedido.id = new.idpedido;
        
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pelicula`
--

DROP TABLE IF EXISTS `pelicula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pelicula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(75) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `director` varchar(150) DEFAULT NULL,
  `año` date DEFAULT NULL,
  `duracion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pelicula`
--

LOCK TABLES `pelicula` WRITE;
/*!40000 ALTER TABLE `pelicula` DISABLE KEYS */;
INSERT INTO `pelicula` VALUES (1,'vengadores','acción','almenabar','2015-12-23','2:30');
/*!40000 ALTER TABLE `pelicula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `descuento` int(11) DEFAULT NULL,
  `telefono` varchar(12) NOT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `iban` varchar(24) DEFAULT NULL,
  `grupo_id` varchar(45) NOT NULL,
  PRIMARY KEY (`dni`),
  KEY `fk_persona_idx` (`grupo_id`),
  KEY `fk_persona_a_grupo_idx` (`grupo_id`),
  CONSTRAINT `fk_persona_a_grupo` FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES ('11111111A','Juan','Siverio',0,'922123456','hola@hola.com','4982737979319','colegas'),('22222222A','David','apellido',0,'922456789','adios@adios.com','4238472923','colegas'),('33333333A','Edu','apelldio',2,'23423425','hoal@hoal.com','32424323','colegas'),('4','4','4',4,'4','4','4','1'),('44444444A','Carlos','apellido',0,'987421765','hola@hola.com','3426876423847','colegas2');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuario`@`%`*/ /*!50003 TRIGGER `cinesDB`.`persona_BEFORE_INSERT` BEFORE INSERT ON `persona` FOR EACH ROW
BEGIN
	DECLARE grupo VARCHAR(45);
    declare cantidad int;
	set grupo = (select id  from grupo where id = new.grupo_id);

	if grupo IS null then    
		#SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Warning: Grupo no existe';
		#crearmos grupo y como somos los primeros, iniciamos número de miembros a 1.
		INSERT INTO grupo (`id`, `no_miembros`, `dni_responsable`, `fecha`) VALUES (new.grupo_id,1, new.dni, curdate());
	else
		#como el grupo ya existe no podemos crear el grupo, pero tenemos que comprobar que nos podemos
		#agregar al grupo si no supera el número máximo de miembros.
		#SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = grupo;
		set cantidad = (select no_miembros from grupo where id = grupo);
        if cantidad < 4 then
			UPDATE `cinesDB`.`grupo` SET `no_miembros` = (cantidad + 1) WHERE (`id` = grupo);
			UPDATE `cinesDB`.`grupo` SET fecha = curdate() WHERE (`id` = grupo);

		else
			SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Numero de usuarios excedido(4)';
		end if;
    
    end if;
	
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuario`@`%`*/ /*!50003 TRIGGER `cinesDB`.`persona_AFTER_DELETE` AFTER DELETE ON `persona` FOR EACH ROW
BEGIN
	declare numero_integrantes int(11);
    declare nuevo_responsable varchar(9);
   
   update grupo set grupo.no_miembros = (grupo.no_miembros - 1) where grupo.id = old.grupo_id;
	
    set numero_integrantes = (select g.no_miembros from grupo as g where g.id = old.grupo_id);
    
    if numero_integrantes < 1 then
		delete from grupo where grupo.id = old.grupo_id;
	else
		if not exists(select persona.dni from persona, grupo
					  where grupo.id = old.grupo_id and
                      grupo.dni_responsable = old.dni) then
			
            set nuevo_responsable = (select persona.dni from persona, grupo
									 where grupo.id = old.grupo_id limit 1);
           
           update grupo set grupo.dni_responsable = nuevo_responsable
            where grupo.id = old.grupo_id;
        end if;
        
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sala`
--

DROP TABLE IF EXISTS `sala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sala` (
  `numero` int(11) NOT NULL,
  `numero_butacas` int(11) NOT NULL,
  `pantalla` varchar(45) NOT NULL,
  `sonido` varchar(45) NOT NULL,
  `nombre_cine` varchar(45) NOT NULL,
  PRIMARY KEY (`numero`,`nombre_cine`),
  KEY `fk_sala_cine_idx` (`nombre_cine`),
  CONSTRAINT `fk_sala_cine` FOREIGN KEY (`nombre_cine`) REFERENCES `cine` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sala_lugar` FOREIGN KEY (`numero`) REFERENCES `lugar` (`id_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` VALUES (1,10,'4k','envolvente','Cine1'),(4,30,'4k','surround','Yelmo');
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuario`@`%`*/ /*!50003 TRIGGER `cinesDB`.`sala_BEFORE_INSERT_lugar` BEFORE INSERT ON `sala` FOR EACH ROW
BEGIN
	insert INTO lugar(`id_lugar`, `cine_lugar`) values (NEW.numero, NEW.nombre_cine);
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuario`@`%`*/ /*!50003 TRIGGER `cinesDB`.`sala_AFTER_INSERT_butaca` AFTER INSERT ON `sala` FOR EACH ROW
BEGIN
	DECLARE contador INT(11);
    SET contador = 1;
    while  contador <= NEW.numero_butacas do
		insert into butaca (`numero`, `numero_sala`, `nombre_cine_sala`) values (contador, NEW.numero, NEW.nombre_cine);
        SET contador = contador + 1;
  END WHILE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sala_exhibe_pelicula`
--

DROP TABLE IF EXISTS `sala_exhibe_pelicula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sala_exhibe_pelicula` (
  `sala` int(11) NOT NULL,
  `pelicula` int(11) NOT NULL,
  `cine` varchar(45) NOT NULL,
  `fecha-hora` datetime NOT NULL,
  PRIMARY KEY (`sala`,`pelicula`,`cine`,`fecha-hora`),
  KEY `fk_sala_idx` (`sala`,`cine`),
  KEY `fk_pelicula_idx` (`pelicula`),
  CONSTRAINT `fk_pelicula` FOREIGN KEY (`pelicula`) REFERENCES `pelicula` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sala` FOREIGN KEY (`sala`, `cine`) REFERENCES `sala` (`numero`, `nombre_cine`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala_exhibe_pelicula`
--

LOCK TABLES `sala_exhibe_pelicula` WRITE;
/*!40000 ALTER TABLE `sala_exhibe_pelicula` DISABLE KEYS */;
INSERT INTO `sala_exhibe_pelicula` VALUES (1,1,'Cine1','2021-01-22 17:00:00'),(4,1,'Yelmo','2021-01-22 17:00:00'),(4,1,'Yelmo','2021-01-22 19:00:00'),(4,1,'Yelmo','2021-01-22 21:00:00');
/*!40000 ALTER TABLE `sala_exhibe_pelicula` ENABLE KEYS */;
UNLOCK TABLES;
