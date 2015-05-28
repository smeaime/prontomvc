
CREATE Procedure [dbo].[Unidades_TT]

AS 

SELECT 
 IdUnidad, 
 Descripcion, 
 Abreviatura, 
 IdUnidad as [Codigo],
 UnidadesPorPack, 
 TaraEnKg
FROM Unidades
ORDER BY Descripcion
