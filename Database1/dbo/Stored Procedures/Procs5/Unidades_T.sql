




CREATE Procedure [dbo].[Unidades_T]
@IdUnidad int
AS 
SELECT *
FROM Unidades
WHERE (IdUnidad=@IdUnidad)




