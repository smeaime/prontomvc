






























CREATE Procedure [dbo].[NotasCredito_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(FechaNotaCredito)))  AS Período,YEAR(FechaNotaCredito)
FROM NotasCredito
GROUP BY  YEAR(FechaNotaCredito) 
order by  YEAR(FechaNotaCredito)  desc































