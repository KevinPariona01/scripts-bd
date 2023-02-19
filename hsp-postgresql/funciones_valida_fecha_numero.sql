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
---


CREATE OR REPLACE FUNCTION public.fn_validanumero(
	p_valor character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
	declare pn_valor double precision = 0.0;
	
	
BEGIN
	SELECT p_valor::double precision into pn_valor ;
RETURN TRUE; 	   			
EXCEPTION When others  then
RETURN FALSE; 
 raise notice '% %','error '|| SQLERRM, SQLSTATE;
RETURN cast( '01/01/1900' as timestamp);
END

$BODY$;