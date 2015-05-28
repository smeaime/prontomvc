CREATE Procedure [dbo].[Facturas_TXAnio]

AS

SELECT min(CONVERT(varchar, YEAR(FechaFactura)))  AS Período, YEAR(FechaFactura)
FROM Facturas
--WHERE IsNull(FacturaContado,'NO')='NO'
GROUP BY YEAR(FechaFactura) 
ORDER BY YEAR(FechaFactura)  desc