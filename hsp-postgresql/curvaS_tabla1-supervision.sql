-- View: public.vw_supervision_avanceprogramadovsrealejecutado
/*
SELECT * FROM vw_supervision_avanceprogramadovsrealejecutado WHERE n_idgen_proyecto = 12
SELECT * FROM vw_obra_avanceprogramadovsrealejecutado WHERE n_idgen_proyecto = 20
SELECT * FROM pro_adicionalvalor WHERE c_valor  = '64654.68'
UPDATE pro_adicionalvalor SET c_valor = 'A2' WHERE n_idpro_adicionalvalor = 5825
--
UPDATE pro_adicionalvalor SET c_valor = '114945.81' WHERE n_idpro_adicionalvalor = 7335
SELECT * FROM vw_datoadicional_tareaproyecto WHERE c_datoadicional = 'Monto Bruto Valorizado (S/)' and c_valordatoadicional = '64654.68'
SELECT * FROM gen_datoadicional WHERE c_dato = 'Monto Bruto Valorizado (S/)'  
*/
SELECT * FROM pro_adicionalvalor WHERE c_valor  = '64654.68'
UPDATE pro_adicionalvalor SET c_valor = 'A2' WHERE n_idpro_adicionalvalor = 5825

CREATE OR REPLACE VIEW public.vw_supervision_avanceprogramadovsrealejecutado_tabla
 AS
; WITH programado AS (
         SELECT p_1.n_monto,
            to_char((('01/'::text || ("right"('0'::text || p_1.n_mes, 2) || '/'::text)) || p_1.n_anio)::timestamp without time zone, 'Mon-yy'::text) AS fecha,
            v.n_idgen_proyecto
           FROM gen_programa p_1
             JOIN gen_version v ON p_1.n_idgen_version = v.n_idgen_version AND v.n_borrado = 0
          WHERE p_1.n_borrado = 0 AND v.n_idgen_version = (( SELECT max(v2.n_idgen_version) AS max
                   FROM gen_version v2
                  WHERE v2.n_borrado = 0 AND v2.n_idgen_proyecto = v.n_idgen_proyecto AND v2.n_idgen_fase = 4)) AND v.n_idgen_fase = 4
          ORDER BY p_1.n_orden
        ), fecha1 AS (
         SELECT vw.n_idgen_proyecto,
            vw.n_idpro_tareaproyecto,
            vw.c_valordatoadicional AS mes_anio
           FROM vw_datoadicional_tareaproyecto vw
          WHERE vw.c_valortarea::text = 'MN_Aprobacion_Valorizaciones_Mensuales'::text AND vw.c_datoadicional::text = 'Mes-Año'::text AND vw.c_valordatoadicional::text <> 'null'::text
        ), base1 AS (
         SELECT vw.n_idgen_proyecto,
            vw.n_idpro_tareaproyecto,
            vw.c_valordatoadicional AS n_valor,
			vw.c_datoadicional
           FROM vw_datoadicional_tareaproyecto vw
			WHERE vw.c_valortarea in ('MN_Aprobacion_Valorizaciones_Mensuales',
									 'MN_Aprobacion_Valorizaciones_MayorMetrado',
									 ) and c_datoadicional in ('Monto Bruto Valorizado (S/)')
		)
             --JOIN fecha1 f ON vw.n_idpro_tareaproyecto = f.n_idpro_tareaproyecto
 SELECT p.n_idgen_proyecto,
    p.fecha AS mes_anio,
    p.n_monto AS mensual_prog,
	b1.c_datoadicional,
	b1.n_valor,
	f1.mes_anio AS mes_anio_base1,
	--fn_validanumero(b1.n_valor) b_valor
   FROM programado p
     INNER JOIN base1 b1 ON p.n_idgen_proyecto = b1.n_idgen_proyecto
     INNER JOIN fecha1 f1 ON p.n_idgen_proyecto = f1.n_idgen_proyecto
	WHERE p.n_idgen_proyecto = 12  and c_valortarea
	GROUP BY p.n_idgen_proyecto, p.fecha, p.n_monto, b1.n_valor, f1.mes_anio, b1.c_datoadicional
ALTER TABLE public.vw_supervision_avanceprogramadovsrealejecutado
    OWNER TO postgres;


select * from vw_datoadicional_tareaproyecto
