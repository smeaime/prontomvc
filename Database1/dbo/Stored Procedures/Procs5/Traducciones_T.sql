

CREATE Procedure [dbo].[Traducciones_T]
@IdTraduccion int
AS 
SELECT *
FROM Traducciones
WHERE IdTraduccion=@IdTraduccion


