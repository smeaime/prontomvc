
CREATE Procedure [dbo].[Unidades_TX_PorId]

@IdUnidad int

AS 

SELECT *
FROM Unidades
WHERE (IdUnidad=@IdUnidad)
