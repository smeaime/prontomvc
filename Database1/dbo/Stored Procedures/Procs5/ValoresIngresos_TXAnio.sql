































CREATE Procedure [dbo].[ValoresIngresos_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(FechaIngreso)))  AS Período,YEAR(FechaIngreso)
FROM ValoresIngresos
WHERE FechaIngreso is not null
GROUP BY  YEAR(FechaIngreso) 
ORDER by  YEAR(FechaIngreso)  desc
































