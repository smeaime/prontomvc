
CREATE Procedure [dbo].[Monedas_TL]
AS 
SELECT IdMoneda, Nombre as [Titulo]
FROM Monedas 
ORDER BY Nombre
