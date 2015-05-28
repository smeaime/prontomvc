






























CREATE Procedure [dbo].[NotasDebito_TXMesAnio]
As
SELECT min(CONVERT(varchar, MONTH(FechaNotaDebito)) + '/' + CONVERT(varchar, YEAR(FechaNotaDebito)) )
    AS Período,YEAR(FechaNotaDebito) , MONTH(FechaNotaDebito)  
    FROM NotasDebito
    GROUP BY  YEAR(FechaNotaDebito) , MONTH(FechaNotaDebito)  
    order by  YEAR(FechaNotaDebito)  desc , MONTH(FechaNotaDebito)  desc































