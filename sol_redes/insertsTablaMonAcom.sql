SELECT * FROM MON_ACOM

INSERT INTO public.mon_acom(
	n_idmon_acom, n_tipo_usuario, c_nombre, n_tipo_documento, n_numero_documento, n_tipo_acometida, n_tipo_instalacion, n_idmon_inspeccion, n_borrado, n_id_usercrea, d_fechacrea)
	VALUES (default, 1, 'nombre1', 1, 12345789, 1, 2, 6092, 0, 1, now());
	
INSERT INTO public.mon_acom(
	n_idmon_acom, n_tipo_usuario, c_nombre, n_tipo_documento, n_numero_documento, n_tipo_acometida, n_tipo_instalacion, n_idmon_inspeccion, n_borrado, n_id_usercrea, d_fechacrea)
	VALUES (default, 2, 'nombre2', 1, 98754231, 1, 1, 6112, 0, 1, now());
	
INSERT INTO public.mon_sfv(
	n_idmon_acom, n_tipo_usuario, c_nombre, n_tipo_documento, n_numero_documento, n_tipo_acometida, n_idmon_inspeccion, n_tipo_instalacion, n_borrado, n_id_usercrea, d_fechacrea)
	VALUES (default, 1, 'nombre3', 1, 678123456, 1, 6131, 0, 1, now());
	
INSERT INTO public.mon_sfv(
	n_idmon_acom, n_tipo_usuario, c_nombre, n_tipo_documento, n_numero_documento, n_tipo_acometida, n_idmon_inspeccion, n_tipo_instalacion, n_borrado, n_id_usercrea, d_fechacrea)
	VALUES (default, 2, 'nombre4', 1, 678123456, 1, 944, 0, 1, now());

INSERT INTO public.mon_sfv(
	n_idmon_acom, n_tipo_usuario, c_nombre, n_tipo_documento, n_numero_documento, n_tipo_acometida, n_idmon_inspeccion, n_tipo_instalacion, n_borrado, n_id_usercrea, d_fechacrea)
	VALUES (default, 1, 'nombre5', 1, 1597536185, 1, 6110, 0, 1, now());
	
SELECT * FROM MON_ACOM