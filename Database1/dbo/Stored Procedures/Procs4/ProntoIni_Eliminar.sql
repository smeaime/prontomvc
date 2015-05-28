
CREATE Procedure [dbo].[ProntoIni_Eliminar]

@IdUsuario int,
@IdProntoIniClave int

AS 

DELETE ProntoIni
WHERE IdUsuario=@IdUsuario and IdProntoIniClave=@IdProntoIniClave
