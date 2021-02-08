CREATE DATABASE  IF NOT EXISTS `cinesDB` /*!40100 DEFAULT CHARACTER SET latin1 */;
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
  `dni_persona` varchar(9) DEFAULT NULL,
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
  KEY `fk_butaca_sala_idx` (`numero_sala`),
  CONSTRAINT `fk_butaca_sala` FOREIGN KEY (`numero_sala`) REFERENCES `sala` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `apertura` varchar(45) DEFAULT NULL,
  `cierre` varchar(45) DEFAULT NULL,
  `nombre_cine` varchar(45) NOT NULL,
  PRIMARY KEY (`id_lugar`),
  KEY `fk_cafeteria_cine_idx` (`nombre_cine`),
  CONSTRAINT `fk_cafeteria_cine` FOREIGN KEY (`nombre_cine`) REFERENCES `cine` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cafeteria_lugar` FOREIGN KEY (`id_lugar`) REFERENCES `lugar` (`id_lugar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
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
  CONSTRAINT `fk_oferta_cafeteria` FOREIGN KEY (`idcafeteria`) REFERENCES `cafeteria` (`id_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_oferta_comida` FOREIGN KEY (`idcomida`) REFERENCES `comida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `pedido_incluye_comida`
--

DROP TABLE IF EXISTS `pedido_incluye_comida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_incluye_comida` (
  `idpedido` int(11) NOT NULL,
  `idcomida` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `cafeteria` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpedido`,`idcomida`),
  KEY `fk_comida_idx` (`idcomida`),
  KEY `fk_cafeteria_idx` (`cafeteria`),
  CONSTRAINT `fk_cafeteria` FOREIGN KEY (`cafeteria`) REFERENCES `cafeteria` (`id_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comida` FOREIGN KEY (`idcomida`) REFERENCES `comida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido` FOREIGN KEY (`idpedido`) REFERENCES `Pedido` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
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
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
        RESIGNAL;
    DECLARE EXIT HANDLER FOR SQLWARNING
        RESIGNAL;
    DECLARE EXIT HANDLER FOR NOT FOUND
        RESIGNAL; 
	call procedure_reducir_stock_cafeteria(new.idcomida, new.cantidad, new.cafeteria);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `fecha-hora` datetime DEFAULT NULL,
  PRIMARY KEY (`sala`,`pelicula`,`cine`),
  KEY `fk_sala_idx` (`sala`,`cine`),
  KEY `fk_pelicula_idx` (`pelicula`),
  CONSTRAINT `fk_pelicula` FOREIGN KEY (`pelicula`) REFERENCES `pelicula` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sala` FOREIGN KEY (`sala`, `cine`) REFERENCES `sala` (`numero`, `nombre_cine`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'cinesDB'
--

--
-- Dumping routines for database 'cinesDB'
--
/*!50003 DROP FUNCTION IF EXISTS `butacas_libres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` FUNCTION `butacas_libres`(fecha datetime, sala int(11), cine varchar(45), butaca int(11)) RETURNS varchar(50) CHARSET latin1
BEGIN
	
    declare butacas varchar(50);
	set butacas = (select a.numero from butaca as a
			where a.numero_sala = sala not in
			(
				select b.butaca from compra_persona_butaca as b
				where b.sala_butaca = sala and
				b.cine_butaca = cine and
				b.hora_sesion = fecha
			
		));
	return butacas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `butaca_esta_libre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` FUNCTION `butaca_esta_libre`(fecha datetime, sala int(11), cine varchar(45), butaca int(11)) RETURNS int(11)
BEGIN
	return(select EXISTS(select * from compra_persona_butaca as b
			where b.sala_butaca = sala and
			b.cine_butaca = cine and
			b.hora_sesion = fecha and
			b.butaca = butaca) as reservado);	
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `butaca_ocupada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` FUNCTION `butaca_ocupada`(fecha datetime, sala int(11), cine varchar(45), butaca int(11)) RETURNS int(11)
BEGIN
	RETURN( select EXISTS(select * from compra_persona_butaca as b
			where b.sala_butaca = sala and
			b.cine_butaca = cine and
			b.hora_sesion = fecha and
			b.butaca = butaca));	
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `comprar_butaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` FUNCTION `comprar_butaca`(fecha datetime, sala int(11), cine varchar(45), butaca int(11)) RETURNS int(11)
BEGIN
	RETURN( select EXISTS(select * from compra_persona_butaca as b
			where b.sala_butaca = sala and
			b.cine_butaca = cine and
			b.hora_sesion = fecha and
			b.butaca = butaca));	
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `butacas_libres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` PROCEDURE `butacas_libres`(fecha datetime, sala int(11), cine varchar(45), butaca int(11))
BEGIN
	
    declare butacas varchar(50);
	select a.numero from butaca as a
			where a.numero_sala = sala not in
			(
				select b.butaca from compra_persona_butaca as b
				where b.sala_butaca = sala and
				b.cine_butaca = cine and
				b.hora_sesion = fecha
			
		);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procedure_annadir_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` PROCEDURE `procedure_annadir_stock`( in producto int(11), in cantidad int(11))
BEGIN
	declare old_qtty int(11);
    set old_qtty = (select stock from comida where id = producto);
    update comida set stock = old_qtty + cantidad where id = producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procedure_butacas_libres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` PROCEDURE `procedure_butacas_libres`(fecha datetime, sala int(11), cine varchar(45), butaca int(11))
BEGIN
    declare butacas varchar(50);
	select a.numero 
    from butaca as a
	where a.nombre_cine_sala = cine and
	a.numero_sala = sala and
    a.numero not in
			(
				select b.butaca from compra_persona_butaca as b
				where b.sala_butaca = sala and
				b.cine_butaca = cine and
				b.hora_sesion = fecha
			); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procedure_reducir_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` PROCEDURE `procedure_reducir_stock`(in producto int(11), in candidad int(11))
BEGIN
	declare cur_qtty int(11);
    set cur_qtty = (select comida.stock from comida where comida.id = producto);
    if (cur_qtty - cantidad) >= 0 then
        update comida set comida.stock = (cur_qtty - cantidad) where comida.id = producto;
	else
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Error con el stock';
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procedure_reducir_stock_cafeteria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`usuario`@`%` PROCEDURE `procedure_reducir_stock_cafeteria`(in producto int(11), in cantidad int(11), in cafeteria int(11))
BEGIN
	declare cur_qtty int(11);
    set cur_qtty = (select c.cantidad from cafeteria_oferta_comida as c
					where c.idcomida = producto and c.idcafeteria = cafeteria);
    
    if (cur_qtty - cantidad) >= 0 then
        update cafeteria_oferta_comida as c
        set c.cantidad = (cur_qtty - cantidad)
        where c.idcomida = producto;
	
    else
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Error con el stock';
    
    end if;
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

-- Dump completed on 2021-02-08 12:16:20
