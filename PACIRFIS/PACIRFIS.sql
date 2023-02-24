----PROYECTO NORMATIVO
SELECT * FROM T_MAC_PROYECTO_NORMATIVO

DELETE T_MAC_PROYECTO_NORMATIVO WHERE NU_ID_PROYECTO_NORMATIVO = 242
COMMIT

SELECT * FROM T_MAC_PROYECTO_NORMATIVO WHERE NU_ID_PROYECTO_NORMATIVO = 221 
UPDATE T_MAC_PROYECTO_NORMATIVO SET FE_PROYECTO_FEC_FIN_COMENT = null WHERE NU_ID_PROYECTO_NORMATIVO = 221 
COMMIT;

--ACTUALIZAR PROYECTO NORMATIVO A NO PUBLICADO Y NO TENER FECHA DE PUBLICACION
UPDATE T_MAC_PROYECTO_NORMATIVO SET TX_PROYECTO_PUBLICADO = 0 ,FE_PROYECTO_FEC_PUBLICACION = null WHERE NU_ID_PROYECTO_NORMATIVO = 221 
COMMIT;

UPDATE T_MAC_PROYECTO_NORMATIVO SET TX_NORMA_APRO_PUBLICADA = 0 ,FE_NORMA_APRO_FEC_PUBLICACION = null WHERE NU_ID_PROYECTO_NORMATIVO = 221 
COMMIT;

---PROYECTO DOCUMENTO



SELECT ---PARA HABILITAR PROYECTO NORMATIVO PUBLICADO
    NU_ID_DOCUMENTO_CATEGORIA,
    NU_ID_PROYECTO_NORMATIVO
FROM T_MVD_PROYECTO_DOCUMENTO
WHERE NU_ID_PROYECTO_NORMATIVO = 221 
AND TX_REGISTRO_ACTIVO = '1' 
AND NU_ID_DOCUMENTO_CATEGORIA IN (1,4,5) 


SELECT ---PARA HABILITAR NORMA APROBADA PARA PUBLICAR
    NU_ID_DOCUMENTO_CATEGORIA,
    NU_ID_PROYECTO_NORMATIVO
FROM T_MVD_PROYECTO_DOCUMENTO
WHERE NU_ID_PROYECTO_NORMATIVO = 221 
AND TX_REGISTRO_ACTIVO = '1' 
AND NU_ID_DOCUMENTO_CATEGORIA IN (6,7) 

SELECT * FROM T_MVD_PROYECTO_DOCUMENTO WHERE NU_ID_PROYECTO_NORMATIVO = 221 


SELECT 
    PD.NU_ID_PROYECTO_DOCUMENTO idProyectoDocumento, 
    PD.NU_ID_PROYECTO_NORMATIVO idProyectoNormativo, 
    PD.NU_ID_DOCUMENTO_CATEGORIA idDocumentoCategoria, 
    PD.TX_DOCUMENTO_DESCRIPCION documentoDescripcion, 
    PD.TX_DOCUMENTO_NOMBRE documentoNombre, 
    PD.TX_DOCUMENTO_TIPO documentoTipo, 
    PD.TX_DOCUMENTO_UUID uiid, 
    CT.TX_CATEGORIA_NOMBRE categoriaNombre, 
    CT.TX_CATEGORIA_ACEPTA_COMENTARIO aceptaComentario, 
    CT.TX_CATEGORIA_DIVIDE_PARRAFO divideParrafo,
    CT.TX_CATEGORIA_NORMA_APROBADA
FROM PACIRFIS.T_MVD_PROYECTO_DOCUMENTO PD 
LEFT OUTER JOIN T_GED_DOCUMENTO_CATEGORIA CT ON CT.NU_ID_DOCUMENTO_CATEGORIA = PD.NU_ID_DOCUMENTO_CATEGORIA 
WHERE (PD.TX_REGISTRO_ACTIVO = '1' AND PD.NU_ID_PROYECTO_NORMATIVO = 221 AND CT.TX_CATEGORIA_NORMA_APROBADA = '0' )

SELECT * FROM T_MVD_PROYECTO_DOCUMENTO WHERE NU_ID_PROYECTO_NORMATIVO = 221

--- DOCUMENTO CATEGORIA

SELECT * FROM T_GED_DOCUMENTO_CATEGORIA

WITH CATEGORIA AS 
( 
    SELECT CAT.NU_ID_DOCUMENTO_CATEGORIA 
    FROM T_GED_DOCUMENTO_CATEGORIA CAT 
    MINUS SELECT DOC.NU_ID_DOCUMENTO_CATEGORIA 
    FROM T_MVD_PROYECTO_DOCUMENTO DOC 
    WHERE DOC.NU_ID_PROYECTO_NORMATIVO =221 AND DOC.TX_REGISTRO_ACTIVO='1' 
) 
SELECT 
    CAT.NU_ID_DOCUMENTO_CATEGORIA as idDocumentoCategoria, 
    CAT.TX_CATEGORIA_NOMBRE as nombre, 
    CAT.TX_CATEGORIA_ACEPTA_COMENTARIO as aceptaComentario, 
    CAT.TX_CATEGORIA_DIVIDE_PARRAFO as divideParrafo 
FROM T_GED_DOCUMENTO_CATEGORIA CAT 
INNER JOIN CATEGORIA C ON C.NU_ID_DOCUMENTO_CATEGORIA = CAT.NU_ID_DOCUMENTO_CATEGORIA 
WHERE CAT.TX_CATEGORIA_ACTIVO = '1' AND CAT.TX_CATEGORIA_NORMA_APROBADA = '0'

-- GED PERSONA
SELECT * FROM T_GED_PERSONA

--SE CIERRA CON EL FLAG QUE ESTA EN T_MAC_PROYECTO_NROMATIVO

SELECT * FROM T_GED_PERSONA 
UPDATE T_GED_PERSONA SET TX_PERSONA_CORREO = 'kevinmtip@gmail.com' WHERE NU_ID_PERSONA = 141
COMMIT;


--CORREO PLANTILLA


SELECT * FROM T_GED_CORREO_PLANTILLA

---T_GED_PERSONA

SELECT * FROM T_GED_PERSONA
DELETE T_GED_PERSONA WHERE TX_PERSONA_CORREO = 'keviimpariiona@gmail.com'
commit;

--T_MVD_REGISTRO_TALLER

SELECT * FROM T_MVD_REGISTRO_TALLER
SELECT * FROM T_MVD_REGISTRO_TALLER WHERE NU_ID_PERSONA = 141

DELETE T_MVD_REGISTRO_TALLER
COMMIT




