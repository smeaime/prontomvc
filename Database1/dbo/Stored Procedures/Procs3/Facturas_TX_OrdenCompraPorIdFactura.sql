CREATE PROCEDURE [dbo].[Facturas_TX_OrdenCompraPorIdFactura]

@IdFactura int

AS

SELECT TOP 1 OrdenesCompra.NumeroOrdenCompraCliente as [NumeroOrdenCompra]
FROM DetalleFacturasOrdenesCompra dfoc
LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
WHERE dfoc.IdFactura=@IdFactura