CREATE Procedure [dbo].[Conciliaciones_TXAnio]

AS

SELECT Min(CONVERT(varchar, YEAR(FechaFinal)))  as [Período], YEAR(FechaFinal)
FROM Conciliaciones
GROUP BY  YEAR(FechaFinal) 
ORDER BY  YEAR(FechaFinal)  desc