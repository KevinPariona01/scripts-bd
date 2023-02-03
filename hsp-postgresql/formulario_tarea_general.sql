select * from vw_get_tarea_proyecto_registro where n_idgen_proyecto = 59 order by n_idgen_tarea


with valor as ( 
    select av.n_idgen_datoadicional, av.c_valor from pro_adicionalvalor av 
    inner join pro_tareaproyecto tp on tp.n_idpro_tareaproyecto = av.n_idpro_tareaproyecto and tp.n_borrado = 0 and tp.n_idgen_proyecto = 59 
    where av.n_borrado = 0 
) 
SELECT distinct g.n_idgen_datoadicional, g.c_dato, g.c_tipodato, g.n_idgen_tarea, g.c_unidad, av.c_valor FROM gen_datoadicional g 
inner join pro_tareaproyecto tp on g.n_idgen_tarea = tp.n_idgen_tarea and tp.n_borrado = 0 and tp.n_idgen_proyecto = 59
left outer join valor av on av.n_idgen_datoadicional = g.n_idgen_datoadicional 
where g.n_borrado = 0 and vt.c_descripciontarea = 'Suscripción del Contrato'

SELECT * FROM pro_tareaproyecto
----

with valor as ( 
    select av.n_idgen_datoadicional, av.c_valor, av.n_idpro_adicionalvalor  from pro_adicionalvalor av 
    inner join pro_tareaproyecto tp on tp.n_idpro_tareaproyecto = av.n_idpro_tareaproyecto and tp.n_borrado = 0 and tp.n_idgen_proyecto = 59
    where av.n_borrado = 0 
) 
SELECT distinct gd.n_idgen_datoadicional, vt.*, gd.c_dato, gd.c_tipodato, gd.n_idgen_tarea, gd.c_unidad, av.n_idpro_adicionalvalor, av.c_valor, tp.n_idpro_tareaproyecto FROM gen_datoadicional gd 
INNER JOIN vw_tarea vt on vt.n_idgen_tarea = gd.n_idgen_tarea
INNER JOIN pro_tareaproyecto tp on gd.n_idgen_tarea = tp.n_idgen_tarea and tp.n_borrado = 0 and tp.n_idgen_proyecto = 59
LEFT OUTER JOIN valor av on av.n_idgen_datoadicional = gd.n_idgen_datoadicional 
where gd.n_borrado = 0 and vt.c_descripciontarea = 'Suscripción del Contrato'
WHERE vt.c_descripciontarea = 'Suscripción del Contrato'


---
with valor as ( 
    select av.n_idgen_datoadicional, av.c_valor, av.n_idpro_adicionalvalor  from pro_adicionalvalor av 
    inner join pro_tareaproyecto tp on tp.n_idpro_tareaproyecto = av.n_idpro_tareaproyecto and tp.n_borrado = 0 and tp.n_idgen_proyecto = 59
    where av.n_borrado = 0 
) 
SELECT vt.*, gd.n_idgen_datoadicional, gd.c_dato, gd.c_tipodato, gd.n_idgen_tarea, gd.c_unidad, av.n_idpro_adicionalvalor, av.c_valor, tp.n_idpro_tareaproyecto FROM vw_tarea vt
INNER JOIN gen_datoadicional gd on gd.n_idgen_tarea = vt.n_idgen_tarea
inner join pro_tareaproyecto tp on gd.n_idgen_tarea = tp.n_idgen_tarea and tp.n_borrado = 0 and tp.n_idgen_proyecto = 59
left outer join valor av on av.n_idgen_datoadicional = gd.n_idgen_datoadicional 
--WHERE vt.c_descripciontarea = 'Suscripción del Contrato'
WHERE vt.n_idgen_fase = 2







SELECT * FROM pro_adicionalvalor where n_idpro_adicionalvalor = 19771
SELECT * FROM pro_tareaproyecto where n_idgen_proyecto = 59
SELECT * FROM GEN_TAREA 
SELECT * FROM VW_TAREA
SELECT * FROM gen_datoadicional

SELECT * FROM seg_user WHERE c_username = 'jvargas'

