
CREATE Procedure [dbo].[wMonedas_TL]
AS 
SELECT IdMoneda, Nombre as [Titulo]
FROM Monedas 
ORDER BY Nombre

