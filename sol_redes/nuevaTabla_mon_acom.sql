SELECT * FROM mon_acom
CREATE TABLE mon_acom
(
    n_idmon_acom  serial PRIMARY KEY,
    n_tipo_usuario integer NULL,
    c_nombre varchar(256) NULL ,
    n_tipo_documento integer NULL ,
    n_numero_documento integer NULL ,
	n_tipo_acometida integer NULL,
	n_tipo_instalacion integer NULL,
	n_idmon_inspeccion INTEGER,
	n_borrado integer NOT NULL,
    n_id_usercrea integer NOT NULL,
    n_is_usermodi integer,
    d_fechacrea timestamp without time zone NOT NULL,
    d_fechamodi timestamp without time zone,
	FOREIGN KEY (n_idmon_inspeccion) REFERENCES MON_INSPECCION(n_idmon_inspeccion)
)