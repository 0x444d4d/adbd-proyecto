CREATE DEFINER=`usuario`@`%` TRIGGER `cinesDB`.`persona_BEFORE_INSERT` BEFORE INSERT ON `persona` FOR EACH ROW
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
	
END