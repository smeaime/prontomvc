






























CREATE Procedure [dbo].[Devoluciones_TXMesAnio]
As
SELECT min(CONVERT(varchar, MONTH(FechaDevolucion)) + '/' + CONVERT(varchar, YEAR(FechaDevolucion)) )
    AS Período,YEAR(FechaDevolucion) , MONTH(FechaDevolucion)  
    FROM Devoluciones
    GROUP BY  YEAR(FechaDevolucion) , MONTH(FechaDevolucion)  
    order by  YEAR(FechaDevolucion)  desc , MONTH(FechaDevolucion)  desc































