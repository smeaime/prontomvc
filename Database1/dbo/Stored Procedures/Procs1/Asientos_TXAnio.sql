


































CREATE Procedure [dbo].[Asientos_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(FechaAsiento)))  AS Período,YEAR(FechaAsiento)
FROM Asientos
GROUP BY  YEAR(FechaAsiento) 
order by  YEAR(FechaAsiento)  desc 


































