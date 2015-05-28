

































CREATE Procedure [dbo].[Remitos_TXAnio]
As
SELECT 
 Min(CONVERT(varchar, YEAR(FechaRemito)))  AS Período,YEAR(FechaRemito)
FROM Remitos
WHERE FechaRemito is not null
GROUP BY  YEAR(FechaRemito) 
ORDER by  YEAR(FechaRemito)  desc


































