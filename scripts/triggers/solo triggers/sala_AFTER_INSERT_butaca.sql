CREATE DEFINER=`usuario`@`%` TRIGGER `cinesDB`.`sala_AFTER_INSERT_butaca` AFTER INSERT ON `sala` FOR EACH ROW
BEGIN
	DECLARE contador INT(11);
    SET contador = 1;
    while  contador <= NEW.numero_butacas do
		insert into butaca (`numero`, `numero_sala`, `nombre_cine_sala`) values (contador, NEW.numero, NEW.nombre_cine);
        SET contador = contador + 1;
  END WHILE;
END