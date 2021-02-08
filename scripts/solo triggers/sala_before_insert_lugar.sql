CREATE DEFINER=`usuario`@`%` TRIGGER `cinesDB`.`sala_BEFORE_INSERT_lugar` BEFORE INSERT ON `sala` FOR EACH ROW
BEGIN
	insert INTO lugar(`id_lugar`, `cine_lugar`) values (NEW.numero, NEW.nombre_cine);
END