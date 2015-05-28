
CREATE Procedure [dbo].[ProntoIniClaves_T]

@IdProntoIniClave int

AS 

SELECT *
FROM ProntoIniClaves
WHERE IdProntoIniClave=@IdProntoIniClave
