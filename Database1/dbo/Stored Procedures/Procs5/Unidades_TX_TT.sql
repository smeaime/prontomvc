
CREATE Procedure [dbo].[Unidades_TX_TT]

@IdUnidad int

AS 

SELECT 
 IdUnidad, 
 Descripcion, 
 Abreviatura, 
 IdUnidad as [Codigo],
 UnidadesPorPack, 
 TaraEnKg
FROM Unidades
WHERE (IdUnidad=@IdUnidad)
