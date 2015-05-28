
CREATE Procedure [dbo].[ProntoIni_TX_T]

@IdUsuario int,
@IdProntoIniClave int

AS 

SELECT *
FROM ProntoIni P 
WHERE (@IdUsuario=-1 or P.IdUsuario=@IdUsuario) and 
	(@IdProntoIniClave=-1 or P.IdProntoIniClave=@IdProntoIniClave)
