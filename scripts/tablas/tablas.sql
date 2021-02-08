
CREATE DATABASE  IF NOT EXISTS `cinesDB` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cinesDB`;

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
