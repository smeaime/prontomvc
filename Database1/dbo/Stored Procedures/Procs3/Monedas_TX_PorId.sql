










CREATE Procedure [dbo].[Monedas_TX_PorId]
@IdMoneda int
AS 
SELECT*
FROM Monedas
WHERE (IdMoneda=@IdMoneda)











