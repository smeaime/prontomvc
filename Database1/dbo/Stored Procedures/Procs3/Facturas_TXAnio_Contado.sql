CREATE Procedure [dbo].[Facturas_TXAnio_Contado]

AS

SELECT min(CONVERT(varchar, YEAR(FechaFactura)))  AS Período, YEAR(FechaFactura)
FROM Facturas
--WHERE IsNull(FacturaContado,'NO')='SI'
GROUP BY YEAR(FechaFactura) 
ORDER BY YEAR(FechaFactura)  desc