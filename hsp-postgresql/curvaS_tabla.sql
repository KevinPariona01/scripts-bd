SELECT * FROM seg_user
SELECT * FROM pro_atributo
SELECT * FROM vw_obra_avanceprogramadovsrealejecutado WHERE n_idgen_proyecto = 12
SELECT * FROM vw_datoadicional_tareaproyecto WHERE c_datoadicional = 'Contractual Ejecutado' AND n_idgen_proyecto = 20
SELECT * FROM gen_datoadicional WHERE c_dato = 'Contractual Ejecutado'  


SELECT * FROM pro_adicionalvalor WHERE c_valor = '114945.81' 		n_idgen_datoadicional = 356 and n_idgen_proyecto = 20  

UPDATE pro_adicionalvalor SET c_valor = '114945.81' WHERE n_idpro_adicionalvalor = 7335

---
-- View: public.vw_obra_avanceprogramadovsrealejecutado

-- DROP VIEW public.vw_obra_avanceprogramadovsrealejecutado;

SELECT* FROM vw_obra_avanceprogramadovsrealejecutado_tabla WHERE n_idgen_proyecto = 168

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
            to_char(to_date(vw_datoadicional_tareaproyecto.c_valordatoadicional::text, 'DD/MM/YYYY'::text)::timestamp with time zone, 'Mon-yy'::text) AS mes_anio
           FROM vw_datoadicional_tareaproyecto
          WHERE vw_datoadicional_tareaproyecto.n_idgen_tarea = 118 AND vw_datoadicional_tareaproyecto.c_datoadicional::text = 'Mes-Año'::text AND vw_datoadicional_tareaproyecto.c_valordatoadicional::text <> 'null'::text
        ), base AS (
         SELECT vw_datoadicional_tareaproyecto.n_idgen_proyecto,
            vw_datoadicional_tareaproyecto.n_idpro_tareaproyecto,
			vw_datoadicional_tareaproyecto.c_datoadicional,
			vw_datoadicional_tareaproyecto.c_valordatoadicional
                
           FROM vw_datoadicional_tareaproyecto
          WHERE vw_datoadicional_tareaproyecto.n_idgen_tarea = 118 AND (vw_datoadicional_tareaproyecto.c_datoadicional::text = ANY (ARRAY['Mensual (S/) Programado'::character varying::text, 'Acumulado (S/) Programado'::character varying::text, 'Acumulado (S/) Programado'::character varying::text, 'Acumulado (%) Programado'::character varying::text, 'Contractual Ejecutado'::character varying::text, 'Mayor Metrado Ejecutado'::character varying::text, 'Prest. Adicional Ejecutado'::character varying::text, 'Mensual (S/) Ejecutado'::character varying::text, 'Acumulado (S/) Ejecutado'::character varying::text, 'Acumulado (%) Ejecutado'::character varying::text, 'Avance (%) Ejecutado'::character varying::text])) AND vw_datoadicional_tareaproyecto.c_valordatoadicional::text <> 'null'::text
        )
 SELECT p.n_idgen_proyecto,
    p.fecha AS mes_anio,
    p.n_monto AS mensual_prog,
	b.n_idpro_tareaproyecto,
	b.c_datoadicional,
	b.c_valordatoadicional
   FROM programado p
   LEFT JOIN base b ON p.n_idgen_proyecto = b.n_idgen_proyecto 
   GROUP BY p.fecha, p.n_monto, b.n_idpro_tareaproyecto, b.c_datoadicional, p.n_idgen_proyecto, b.c_valordatoadicional
   
   
   
   WHERE p.n_idgen_proyecto = 20
   
ALTER TABLE public.vw_obra_avanceprogramadovsrealejecutado_tabla
    OWNER TO postgres;

