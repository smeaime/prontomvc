
CREATE Procedure [dbo].[ProntoIni_T]

@IdProntoIni int

AS 

SELECT *
FROM ProntoIni P 
WHERE P.IdProntoIni=@IdProntoIni
