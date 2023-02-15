with fase as ( 
    select gf.c_nombre, gf.n_idgen_fase, gf.c_tipofase from gen_fase gf 
    --inner join pro_tareaproyecto tp on tp.n_idpro_tareaproyecto = av.n_idpro_tareaproyecto and tp.n_borrado = 0 and tp.n_idgen_proyecto = 59 
    where gf.c_tipofase = 'PRO'
) 

--CONSULTA PARA VERIFICAR SI TODOS LOS DATOS ADICIONALES ESTAN LLENOS
SELECT 
	count(pa.n_idpro_atributo),
	pa.n_idgen_fase, 
	pb.n_idgen_proyecto
FROM pro_atributo pa
Left outer join pro_proyectoatributo pb on pa.n_idpro_atributo=pb.n_idpro_atributo and pb.n_borrado = 0 and pb.n_idgen_proyecto = 59 
WHERE c_valoratributo is not null and pa.n_idgen_fase = 2 
group by pa.n_idgen_fase, pb.n_idgen_proyecto




SELECT * FROM gen_fase
WHERE c_tipofase = 'PRO'


SELECT * FROM pro_atributo
SELECT * FROM pro_bolsaproyectoatributo
SELECT * FROM gen_fase