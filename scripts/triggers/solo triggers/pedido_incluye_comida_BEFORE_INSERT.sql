CREATE DEFINER=`usuario`@`%` TRIGGER `cinesDB`.`pedido_incluye_comida_BEFORE_INSERT` BEFORE INSERT ON `pedido_incluye_comida` FOR EACH ROW
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
end