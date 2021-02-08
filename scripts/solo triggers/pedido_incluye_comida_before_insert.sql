CREATE DEFINER=`usuario`@`%` TRIGGER `cinesDB`.`pedido_incluye_comida_BEFORE_INSERT` BEFORE INSERT ON `pedido_incluye_comida` FOR EACH ROW
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
        RESIGNAL;
    DECLARE EXIT HANDLER FOR SQLWARNING
        RESIGNAL;
    DECLARE EXIT HANDLER FOR NOT FOUND
        RESIGNAL; 
	call procedure_reducir_stock_cafeteria(new.idcomida, new.cantidad, new.cafeteria);
end