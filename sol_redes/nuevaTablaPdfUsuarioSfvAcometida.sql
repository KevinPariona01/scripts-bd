-- Table: public.aco_detalleacometida

-- DROP TABLE IF EXISTS public.aco_detalleacometida;

SELECT * FROM mon_sfv

DROP TABLE mon_sfv

CREATE TABLE mon_sfv
(
    n_idmon_sfv  serial PRIMARY KEY,
    n_tipo_usuario integer NULL,
    c_nombre varchar(256) NULL ,
    n_tipo_documento integer NULL ,
    n_numero_documento integer NULL ,
	n_tipo_sfv integer NULL,
	n_idmon_inspeccion INTEGER,
	n_borrado integer NOT NULL,
    n_id_usercrea integer NOT NULL,
    n_is_usermodi integer,
    d_fechacrea timestamp without time zone NOT NULL,
    d_fechamodi timestamp without time zone,
	FOREIGN KEY (n_idmon_inspeccion) REFERENCES MON_INSPECCION(n_idmon_inspeccion)
)

SELECT * FROM PL_TIPOARMADO WHERE b_movil = TRUE
SELECT * FROM MON_INSPECCION
SELECT * FROM pl_armado
SELECT * FROM mon_inspecciondetalle


INSERT INTO public.pl_tipoarmado(
	n_idpl_tipoarmado, c_codigo, c_nombre, n_borrado, n_id_usercrea, d_fechacrea,b_movil)
	VALUES (default, 'sfv', 'sistema fotovoltaico', 0, 1, now(),true);
	
---

select 
plar.n_idpl_armado
from mon_inspeccion ins
left join mon_inspecciondetalle det on det.n_idmon_inspeccion = ins.n_idmon_inspeccion  and det.n_borrado = 0
left join pl_armado plar on plar.n_idpl_armado = det.n_idpl_armado and plar.n_borrado = 0
where ins.n_idmon_inspeccion = 6110 and ins.n_borrado = 0

--6131 , 944


--------





