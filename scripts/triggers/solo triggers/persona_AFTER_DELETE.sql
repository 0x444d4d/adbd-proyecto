CREATE DEFINER=`usuario`@`%` TRIGGER `cinesDB`.`persona_AFTER_DELETE` AFTER DELETE ON `persona` FOR EACH ROW
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
END