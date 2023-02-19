CREATE OR REPLACE VIEW public.vw_obra_avanceprogramadovsrealejecutado_tabla
 AS
 WITH programado AS (
         SELECT p_1.n_monto,
            to_char((('01/'::text || ("right"('0'::text || p_1.n_mes, 2) || '/'::text)) || p_1.n_anio)::timestamp without time zone, 'Mon-yy'::text) AS fecha,
            v.n_idgen_proyecto
           FROM gen_programa p_1
             JOIN gen_version v ON p_1.n_idgen_version = v.n_idgen_version AND v.n_borrado = 0
          WHERE p_1.n_borrado = 0 AND v.n_idgen_version = (( SELECT max(v2.n_idgen_version) AS max
                   FROM gen_version v2
                  WHERE v2.n_borrado = 0 AND v2.n_idgen_proyecto = v.n_idgen_proyecto AND v2.n_idgen_fase = 3)) AND v.n_idgen_fase = 3
          ORDER BY p_1.n_orden
        ), fecha AS (
         SELECT vw_datoadicional_tareaproyecto.n_idpro_tareaproyecto,
            vw_datoadicional_tareaproyecto.c_valordatoadicional::text AS mes_anio
           FROM vw_datoadicional_tareaproyecto
          WHERE vw_datoadicional_tareaproyecto.n_idgen_tarea = 118 AND vw_datoadicional_tareaproyecto.c_datoadicional::text = 'Mes-Año'::text AND vw_datoadicional_tareaproyecto.c_valordatoadicional::text <> 'null'::text
        ), base AS (
         SELECT vw_datoadicional_tareaproyecto.n_idgen_proyecto,
            vw_datoadicional_tareaproyecto.n_idpro_tareaproyecto,
			vw_datoadicional_tareaproyecto.c_datoadicional
                /**CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Mensual (S/) Programado'
                    ELSE '0'
                END AS mensual_programado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Acumulado (S/) Programado'
                    ELSE '0'
                END AS acumulado_programado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Acumulado (%) Programado'
                    ELSE '0'
                END AS acum_porcen_programado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Contractual Ejecutado'
                    ELSE '0'
                END AS contractual_ejecutado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Mayor Metrado Ejecutado'
                    ELSE '0'
                END AS acumulado_mm_ejecutado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Prest. Adicional Ejecutado'
                    ELSE '0'
                END AS acumulado_pa_ejecutado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Mensual (S/) Ejecutado'
                    ELSE '0'
                END AS suma_acum_pa_ejecutado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Acumulado (S/) Ejecutado'
                    ELSE '0'
                END AS total_acum_ejecutado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Acumulado (%) Ejecutado'
                    ELSE '0'
                END AS acum_porcen_ejecutado,
                CASE vw_datoadicional_tareaproyecto.c_datoadicional
                    WHEN 'Avance (%) Ejecutado'
                    ELSE '0'
                END AS avance_ejecutado_porcentaje*/
           FROM vw_datoadicional_tareaproyecto
          WHERE vw_datoadicional_tareaproyecto.n_idgen_tarea = 118 AND (vw_datoadicional_tareaproyecto.c_datoadicional::text = ANY (ARRAY['Mensual (S/) Programado'::character varying::text, 'Acumulado (S/) Programado'::character varying::text, 'Acumulado (S/) Programado'::character varying::text, 'Acumulado (%) Programado'::character varying::text, 'Contractual Ejecutado'::character varying::text, 'Mayor Metrado Ejecutado'::character varying::text, 'Prest. Adicional Ejecutado'::character varying::text, 'Mensual (S/) Ejecutado'::character varying::text, 'Acumulado (S/) Ejecutado'::character varying::text, 'Acumulado (%) Ejecutado'::character varying::text, 'Avance (%) Ejecutado'::character varying::text])) AND vw_datoadicional_tareaproyecto.c_valordatoadicional::text <> 'null'::text
        )/*, preliminar AS (
         SELECT b.n_idgen_proyecto,
            b.n_idpro_tareaproyecto,
            f.mes_anio,
            --sum(b.mensual_programado) AS mensual_prog,
            --sum(b.acumulado_programado) AS acumulador_prog,
            --sum(b.acum_porcen_programado) AS porcentaje_prog,
            --sum(b.contractual_ejecutado) AS acum_contractual_eje,
            --sum(b.acumulado_mm_ejecutado) AS acumulado_mm_eje,
            --sum(b.acumulado_pa_ejecutado) AS acumulado_pa_eje,
            --sum(b.suma_acum_pa_ejecutado) AS acumulado_pa_suma_eje,
            --sum(b.total_acum_ejecutado) AS total_acumulado_eje,
            --sum(b.acum_porcen_ejecutado) AS porcentaje_eje,
            --sum(b.avance_ejecutado_porcentaje) AS avance
           FROM base b
             JOIN fecha f ON b.n_idpro_tareaproyecto = f.n_idpro_tareaproyecto
          GROUP BY b.n_idgen_proyecto, b.n_idpro_tareaproyecto, f.mes_anio
          ORDER BY b.n_idgen_proyecto, b.n_idpro_tareaproyecto
        )*/
 SELECT p.n_idgen_proyecto,
    p.fecha AS mes_anio,
    p.n_monto AS mensual_prog,
	pre.c_datoadicional
    /*pre.acumulador_prog AS acumulador_prog,
    pre.porcentaje_prog AS porcentaje_prog,
    pre.acum_contractual_eje AS acum_contractual_eje,
    pre.acumulado_mm_eje AS acumulado_mm_eje,
    pre.acumulado_pa_eje AS acumulado_pa_eje,
    pre.acumulado_pa_suma_eje AS acumulado_pa_suma_eje,
    pre.total_acumulado_eje AS total_acumulado_eje,
    pre.porcentaje_eje AS porcentaje_eje,
    pre.avance, 0::double precision) AS avance*/
   FROM programado p
     LEFT JOIN base pre ON p.n_idgen_proyecto = pre.n_idgen_proyecto --AND p.fecha = pre.mes_anio;
	WHERE p.n_idgen_proyecto = 12

ALTER TABLE public.vw_obra_avanceprogramadovsrealejecutado
    OWNER TO postgres;