-- FUNCTION: public.fn_fechartarea(integer, timestamp without time zone)

-- DROP FUNCTION IF EXISTS public.fn_fechartarea(integer, timestamp without time zone);
select fn_validafecha('11-19')
CREATE OR REPLACE FUNCTION public.fn_validafecha(
	p_valor varchar)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
	declare pn_valor VARCHAR;
BEGIN

	SELECT to_char(to_date(p_valor::text, 'DD/MM/YYYY'::text)::timestamp with time zone, 'Mon-yy'::text) into pn_valor ;
RETURN TRUE; 	   			
EXCEPTION When others  then
RETURN FALSE; 
 raise notice '% %','error '|| SQLERRM, SQLSTATE;
END

$BODY$;

SELECT to_char(to_date('11-19'::text, 'DD/MM/YYYY'::text)::timestamp with time zone, 'Mon-yy'::text) into pn_valor
