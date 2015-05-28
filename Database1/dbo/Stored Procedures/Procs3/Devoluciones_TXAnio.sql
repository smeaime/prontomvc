






























CREATE Procedure [dbo].[Devoluciones_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(FechaDevolucion)))  AS Período,YEAR(FechaDevolucion)
FROM Devoluciones
GROUP BY  YEAR(FechaDevolucion) 
order by  YEAR(FechaDevolucion)  desc 































