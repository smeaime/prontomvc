
CREATE Procedure [dbo].[Presupuestos_TXAnio]

AS

SELECT Min(CONVERT(varchar, YEAR(FechaIngreso)))  as [Período], YEAR(FechaIngreso)
FROM Presupuestos
GROUP BY  YEAR(FechaIngreso) 
ORDER BY  YEAR(FechaIngreso)  desc
