-- View: public.vw_supervision_avanceprogramadovsrealejecutado

-- DROP VIEW public.vw_supervision_avanceprogramadovsrealejecutado;

--VISTA CORRECTA

DROP VIEW vw_supervision_avanceprogramadovsrealejecutado_tabla
CREATE OR REPLACE VIEW public.vw_supervision_avanceprogramadovsrealejecutado_tabla
 AS
 WITH programado AS (
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
            vw.c_valordatoadicional::text AS mes_anio
           FROM vw_datoadicional_tareaproyecto vw
          WHERE vw.c_valortarea::text = 'MN_Aprobacion_Valorizaciones_Mensuales'::text AND vw.c_datoadicional::text = 'Mes-Año'::text AND vw.c_valordatoadicional::text <> 'null'::text
        ), base1 AS (
         SELECT vw.n_idgen_proyecto,
            vw.n_idpro_tareaproyecto,
            vw.c_valordatoadicional AS n_valor,
			vw.c_datoadicional,
            f.mes_anio
           FROM vw_datoadicional_tareaproyecto vw
             JOIN fecha1 f ON vw.n_idpro_tareaproyecto = f.n_idpro_tareaproyecto
          WHERE vw.c_valortarea::text = 'MN_Aprobacion_Valorizaciones_Mensuales'::text AND vw.c_valordatoadicional::text <> 'null'::text AND vw.c_datoadicional::text = 'Monto Bruto Valorizado (S/)'::text
        ), fecha2 AS (
         SELECT vw.n_idgen_proyecto,
            vw.n_idpro_tareaproyecto,
            vw.c_valordatoadicional AS mes_anio
           FROM vw_datoadicional_tareaproyecto vw
          WHERE vw.c_valortarea::text = 'MN_Aprobacion_Valorizaciones_MayorMetrado'::text AND vw.c_datoadicional::text = 'Mes-Año'::text AND vw.c_valordatoadicional::text <> 'null'::text
        ), base2 AS (
         SELECT vw.n_idgen_proyecto,
            vw.n_idpro_tareaproyecto,
            vw.c_valordatoadicional AS n_valor,
			vw.c_datoadicional,
            f.mes_anio
           FROM vw_datoadicional_tareaproyecto vw
             JOIN fecha2 f ON vw.n_idpro_tareaproyecto = f.n_idpro_tareaproyecto
          WHERE vw.c_valortarea::text = 'MN_Aprobacion_Valorizaciones_MayorMetrado'::text AND vw.c_valordatoadicional::text <> 'null'::text AND vw.c_datoadicional::text = 'Monto Bruto Valorizado (S/)'::text
        ), fecha3 AS (
         SELECT vw.n_idgen_proyecto,
            vw.n_idpro_tareaproyecto,
            vw.c_valordatoadicional AS mes_anio
           FROM vw_datoadicional_tareaproyecto vw
          WHERE vw.c_valortarea::text = 'MN_Aprobacion_Valorizaciones_PartidaAdicional'::text AND vw.c_datoadicional::text = 'Mes-Año'::text AND vw.c_valordatoadicional::text <> 'null'::text
        ), base3 AS (
         SELECT vw.n_idgen_proyecto,
            vw.n_idpro_tareaproyecto,
            vw.c_valordatoadicional AS n_valor,
			vw.c_datoadicional,
            f.mes_anio
           FROM vw_datoadicional_tareaproyecto vw
             JOIN fecha3 f ON vw.n_idpro_tareaproyecto = f.n_idpro_tareaproyecto
          WHERE vw.c_valortarea::text = 'MN_Aprobacion_Valorizaciones_PartidaAdicional'::text AND vw.c_valordatoadicional::text <> 'null'::text AND vw.c_datoadicional::text = 'Monto Bruto Valorizado (S/)'::text
        )
 SELECT p.n_idgen_proyecto,
    p.fecha AS mes_anio,
    p.n_monto AS mensual_prog,
    b1.n_valor AS n_acumuladocontractual,
    b2.n_valor AS n_acumuladomayormetrado,
    b3.n_valor AS n_acumuladopartidaacional,
	b1.c_datoadicional AS b1c_datoadicional,
    b2.c_datoadicional AS b2c_datoadicional,
    b3.c_datoadicional AS b3c_datoadicional,
	b1.mes_anio AS b1_mes_anio,
	fn_validanumero(b1.n_valor) b_acumuladocontractual,
	fn_validanumero(b2.n_valor) b_acumuladomayormetrado,
	fn_validanumero(b3.n_valor) b_cumuladopartidaacional,
	fn_validafecha(b1.mes_anio) b_mes_anio,
	fn_validanumero(b1.n_valor) AND fn_validanumero(b2.n_valor) AND fn_validanumero(b3.n_valor) AND fn_validafecha(b1.mes_anio) AS tiene_error
   FROM programado p
     LEFT JOIN base1 b1 ON p.n_idgen_proyecto = b1.n_idgen_proyecto --AND p.fecha = b1.mes_anio
     LEFT JOIN base2 b2 ON p.n_idgen_proyecto = b2.n_idgen_proyecto --AND p.fecha = b2.mes_anio
     LEFT JOIN base3 b3 ON p.n_idgen_proyecto = b3.n_idgen_proyecto --AND p.fecha = b3.mes_anio
	WHERE p.n_idgen_proyecto = 12

ALTER TABLE public.vw_supervision_avanceprogramadovsrealejecutado
    OWNER TO postgres;



