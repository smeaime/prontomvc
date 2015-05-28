






























CREATE Procedure [dbo].[NotasDebito_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(FechaNotaDebito)))  AS Período,YEAR(FechaNotaDebito)
FROM NotasDebito
GROUP BY  YEAR(FechaNotaDebito) 
order by  YEAR(FechaNotaDebito)  desc 































