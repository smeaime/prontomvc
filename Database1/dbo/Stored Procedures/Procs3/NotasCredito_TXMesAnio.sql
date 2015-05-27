






























CREATE Procedure [dbo].[NotasCredito_TXMesAnio]
As
SELECT min(CONVERT(varchar, MONTH(FechaNotaCredito)) + '/' + CONVERT(varchar, YEAR(FechaNotaCredito)) )
    AS Período,YEAR(FechaNotaCredito) , MONTH(FechaNotaCredito)  
    FROM NotasCredito
    GROUP BY  YEAR(FechaNotaCredito) , MONTH(FechaNotaCredito)  
    order by  YEAR(FechaNotaCredito)  desc , MONTH(FechaNotaCredito)  desc































