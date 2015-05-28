CREATE Procedure [dbo].[ComprobantesProveedores_TXAnio]

AS

SELECT 
 MIN(CONVERT(varchar, YEAR(FechaRecepcion)))  AS Período,
 YEAR(FechaRecepcion)
FROM ComprobantesProveedores
GROUP BY  YEAR(FechaRecepcion) 
ORDER BY  YEAR(FechaRecepcion)  desc