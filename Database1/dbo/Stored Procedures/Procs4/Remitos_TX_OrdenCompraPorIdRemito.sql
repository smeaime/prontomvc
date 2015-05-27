





CREATE PROCEDURE [dbo].[Remitos_TX_OrdenCompraPorIdRemito]
@IdRemito int
AS
SELECT TOP 1 
 OrdenesCompra.NumeroOrdenCompraCliente as [NumeroOrdenCompra]
FROM DetalleRemitos DetRem
LEFT OUTER JOIN Remitos ON DetRem.IdRemito = Remitos.IdRemito
LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = DetRem.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
WHERE DetRem.IdRemito=@IdRemito and 
	(Remitos.Anulado is null or Remitos.Anulado<>'SI')





