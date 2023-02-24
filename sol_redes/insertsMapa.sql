SELECT * FROM mon_inspeccion
SELECT * FROM mon_inspeccion WHERE c_codigo = 'codigo_admin' ---ID 6132
UPDATE mon_inspeccion SET n_idpl_linea = 6030   WHERE n_idmon_inspeccion = 6132 --6030 or 3806
UPDATE mon_inspeccion SET n_tipoapp = 2 WHERE n_idmon_inspeccion = 6132
UPDATE mon_inspeccion SET n_id_usercrea = 60 WHERE n_idmon_inspeccion = 6132
UPDATE mon_inspeccion SET c_codigoestructura = 'SFV_PruebaSFV' WHERE n_idmon_inspeccion = 6132
UPDATE mon_inspeccion SET c_latitud = '-13.839568', c_longitud = '-76.257065' WHERE n_idmon_inspeccion = 6132
----

SELECT * FROM mon_inspecciondetalle WHERE n_idmon_inspeccion = 6132--ID 15817
SELECT * FROM mon_inspecciondetallefoto WHERE n_idmon_inspecciondetalle = 2789 -- ID ORIGINAL 2789
--MODIFICAR AL ORIGINAL IMPORTANTE
UPDATE mon_inspecciondetallefoto SET n_idmon_inspecciondetalle = 2789 WHERE n_idmon_inspecciondetallefoto = 1164 ---ORIGINAL 2789 QUE SE CAMBIO POR MIENTRAS POR 15817 PARA VER UNA FOTO

SELECT * FROM mon_sfv

SELECT * FROM mon_acom

SELECT * FROM pl_linea WHERE c_nombre = 'jeampier' WHERE --ID 6031 Y 6032
SELECT * FROM pl_linea WHERE n_idpl_tipolinea =5
SELECT * FROM pl_linea WHERE n_idpl_linea = 3806

SELECT * FROM pl_zona

SELECT * FROM pl_estructura

SELECT * FROM pl_tipolinea

SELECT * FROM 

---INSERTS

INSERT INTO public.pl_linea(
	n_idpl_linea, c_nombre, c_codigo, n_idpl_tipolinea, n_borrado, n_id_usercrea, d_fechacrea, n_idpl_zona, b_expediente, b_replanteo, b_montaje, b_cierre)
	VALUES (default, 'jeampier', 'codigoLineaPrueba', 1, 0, 1, now(), 15, true, false, false, false);
	
INSERT INTO public.mon_inspeccion(
	n_idmon_inspeccion, c_codigo, c_latitud, c_longitud, n_precision, n_altitud, d_fecha, n_borrado, n_id_usercrea, d_fechacrea, n_idpl_linea, c_codigoestructura, c_codigoede, n_tipoapp)
	VALUES (default, 'codigo_admin', '12.2262729', '-76.9297349', 0, 0, now(), 0 , 1, now(), 6031, 'JEAN24', 'JEAN25', 1);
	
INSERT INTO public.mon_inspecciondetalle(
	n_idmon_inspecciondetalle, n_idmon_inspeccion, n_idpl_armado, n_cantidad, n_orientacion, b_adicional, b_eliminado, c_observacion, n_borrado, n_id_usercrea, d_fechacrea)
	VALUES (default, 6132, 1357, 1, 0, false, false, '', 0, 1, now());
	
INSERT INTO public.mon_sfv(
	n_idmon_sfv, n_tipo_usuario, c_nombre, n_tipo_documento, n_numero_documento, n_tipo_sfv, n_idmon_inspeccion, n_borrado, n_id_usercrea, d_fechacrea)
	VALUES (default, 1, 'JEAMPIER', 1, 12345678, 1, 6132, 0, 1, now());
	
INSERT INTO public.mon_acom(
	n_idmon_acom, n_tipo_usuario, c_nombre, n_tipo_documento, n_numero_documento, n_tipo_acometida, n_tipo_instalacion, n_idmon_inspeccion, n_borrado, n_id_usercrea, n_is_usermodi, d_fechacrea, d_fechamodi)
	VALUES (default, 1, 'ANTONIO', 1, 78456123, 1, 1, ?, ?, ?, ?, ?, ?);
	
	
-------
SELECT * FROM mon_sistemafotovoltaico
UPDATE mon_sistemafotovoltaico SET n_borrado = 0 WHERE n_idmon_sistemafotovoltaico = 1

--- QUERY BUSQUEDA DE MAPA
--0
select 
	pe.c_nombre, 
	pe.c_codigo, 
	pe.c_latitud, 
	pe.c_longitud, 
	l.n_idpl_linea, 
	tpl.n_idpl_tipolinea, 
	z.n_idpl_zona, 
	z.n_idpro_proyecto 
from pl_estructura pe 
inner join pl_linea l on pe.n_idpl_linea = l.n_idpl_linea and l.n_borrado = 0 
inner join pl_tipolinea tpl on tpl.n_idpl_tipolinea = l.n_idpl_tipolinea and tpl.n_borrado = 0 
inner join pl_zona z on z.n_idpl_zona = l.n_idpl_zona and z.n_borrado = 0 
where pe.n_borrado = 0 
and (pe.n_version = 0 or 0 = 0) 
and ( 0 = 0 or tpl.n_idpl_tipolinea = 0)  
and (z.n_idpro_proyecto = 5) and (0 = 0 or z.n_idpl_zona = 0 ) and pe.c_nombre like '%SFV_PruebaSFV%'  and (0=0 or l.n_idpl_linea = 0 )

--1
select 
	mi.c_codigo, 
	mi.c_codigoestructura, 
	mi.c_latitud, 
	mi.c_longitud, 
	l.n_idpl_linea, 
	tpl.n_idpl_tipolinea, 
	z.n_idpl_zona, 
	z.n_idpro_proyecto 
from mon_inspeccion mi 
inner join pl_linea l on mi.n_idpl_linea = l.n_idpl_linea and l.n_borrado = 0 
inner join pl_tipolinea tpl on tpl.n_idpl_tipolinea = l.n_idpl_tipolinea and tpl.n_borrado = 0 
inner join pl_zona z on z.n_idpl_zona = l.n_idpl_zona and z.n_borrado = 0 
where mi.n_borrado = 0 
and ( 0 = $3 or tpl.n_idpl_tipolinea = $3)   
and (z.n_idpro_proyecto = $2) and (0 = $4 or z.n_idpl_zona = $4 ) and mi.c_codigo like '%SFV_PruebaSFV%' or mi.c_codigoestructura like '%SFV_PruebaSFV%'  and (0=$5 or l.n_idpl_linea = $5 )

---

UPDATE mon_sistemafotovoltaico SET n_idmon_inspeccion = 5685  WHERE n_idmon_sistemafotovoltaico = 1 
UPDATE mon_acometida SET n_idmon_inspeccion = 6132  , n_borrado = 0 WHERE n_idmon_acometida = 1











