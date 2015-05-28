
CREATE Procedure [dbo].[SalidasMateriales_TXAnio]
AS
SELECT Min(CONVERT(varchar,YEAR(FechaSalidaMateriales)))  as [Periodo], YEAR(FechaSalidaMateriales)
FROM SalidasMateriales
WHERE FechaSalidaMateriales is not null
GROUP BY YEAR(FechaSalidaMateriales) 
ORDER BY YEAR(FechaSalidaMateriales)  desc
