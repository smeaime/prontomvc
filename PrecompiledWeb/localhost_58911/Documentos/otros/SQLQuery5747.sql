SELECT  IdArticulo FROM Articulos WHERE
REPLACE(Descripcion, CHAR(13) + CHAR(10), '')  COLLATE Modern_Spanish_ci_as
like 'CONEC. DIN 41612 TIPO C  (%'    --si busco 'CONEC. DIN 41612 TIPO C (%' deja de funcionar, por el parentesis

Para búsquedas de caracteres comodines como literales, debe incluirlo dentro de corchetes, por ejemplo, si busca:
... like '%[%]%': busca cadenas que contengan el signo '%';


'CONEC. DIN 41612 TIPO C  (64) HEMB.RECTO P/IMP.   Codigo Conec Codigo: 122A10309X  ó 12-000022.    (ubicacion E20004)' 

CONEC. DIN 41612 TIPO C (

SELECT TOP 1 Descripcion COLLATE latin1_general_ci_as  ,* FROM Articulos WHERE Codigo like '059104724'

select top 100 * from detallerequerimientos





