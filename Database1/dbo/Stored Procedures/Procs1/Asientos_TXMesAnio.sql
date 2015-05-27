


































CREATE Procedure [dbo].[Asientos_TXMesAnio]
As
SELECT 
min(CONVERT(varchar, MONTH(FechaAsiento)) + '/' + CONVERT(varchar, YEAR(FechaAsiento)) )  AS Período,
YEAR(FechaAsiento) , MONTH(FechaAsiento)  
FROM Asientos
GROUP BY  YEAR(FechaAsiento) , MONTH(FechaAsiento)  
order by  YEAR(FechaAsiento)  desc , MONTH(FechaAsiento)  desc



































