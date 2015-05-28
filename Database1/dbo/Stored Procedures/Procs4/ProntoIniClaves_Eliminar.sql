
CREATE Procedure [dbo].[ProntoIniClaves_Eliminar]

@IdProntoIniClave int

AS 

DELETE ProntoIni
WHERE IdProntoIniClave=@IdProntoIniClave

DELETE ProntoIniClaves
WHERE IdProntoIniClave=@IdProntoIniClave
