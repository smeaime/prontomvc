





























CREATE Procedure [dbo].[Monedas_T]
@IdMoneda int
AS 
SELECT*
FROM Monedas
where (IdMoneda=@IdMoneda)






























