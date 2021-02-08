CREATE DEFINER=`usuario`@`%` TRIGGER `cinesDB`.`cafeteria_BEFORE_INSERT` BEFORE INSERT ON `cafeteria` FOR EACH ROW
BEGIN
	insert into lugar(`id_lugar`, `cine_lugar`) values (NEW.id_lugar, NEW.nombre_cine); 
END