
































CREATE Procedure [dbo].[Recibos_TXMesAnio]
/*
		@parameter1 datatype = default value,
		@parameter2 datatype OUTPUT
*/
As
SELECT 
min(CONVERT(varchar, MONTH(FechaRecibo)) + '/' + CONVERT(varchar, YEAR(FechaRecibo)) )  AS Período,
YEAR(FechaRecibo) , MONTH(FechaRecibo)  
FROM Recibos
GROUP BY  YEAR(FechaRecibo) , MONTH(FechaRecibo)  
order by  YEAR(FechaRecibo)  desc , MONTH(FechaRecibo)  desc

































