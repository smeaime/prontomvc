
































CREATE Procedure [dbo].[Recibos_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(FechaRecibo)))  AS Período,YEAR(FechaRecibo)
FROM Recibos
GROUP BY  YEAR(FechaRecibo) 
order by  YEAR(FechaRecibo)  desc 

































