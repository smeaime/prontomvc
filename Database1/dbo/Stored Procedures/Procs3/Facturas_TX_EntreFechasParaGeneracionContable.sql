
CREATE PROCEDURE [dbo].[Facturas_TX_EntreFechasParaGeneracionContable]

@Desde datetime,
@Hasta datetime

AS

SELECT 
	Facturas.IdFactura, 
	Facturas.TipoABC AS [A/B/E],
	Facturas.NumeroFactura AS [Factura], 
	Facturas.FechaFactura AS [Fecha Factura]
FROM Facturas 
WHERE (Facturas.FechaFactura between @Desde and @hasta) and 
	 (Facturas.Anulada is null or Facturas.Anulada<>'SI')
ORDER BY Facturas.FechaFactura
