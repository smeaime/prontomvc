



































CREATE Procedure [dbo].[Subdiarios_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(FechaComprobante)))  AS Período,YEAR(FechaComprobante)
FROM Subdiarios
GROUP BY  YEAR(FechaComprobante) 
order by  YEAR(FechaComprobante)  desc 



































