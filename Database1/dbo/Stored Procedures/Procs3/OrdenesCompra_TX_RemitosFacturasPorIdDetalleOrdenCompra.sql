


CREATE PROCEDURE [dbo].[OrdenesCompra_TX_RemitosFacturasPorIdDetalleOrdenCompra]

@IdDetalleOrdenCompra int

AS

SELECT 
 'FA - '+Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+
	Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+
	Convert(varchar,Facturas.NumeroFactura) as [Numero]
FROM DetalleFacturasOrdenesCompra dfoc
LEFT OUTER JOIN Facturas ON dfoc.IdFactura = Facturas.IdFactura
WHERE dfoc.IdDetalleOrdenCompra=@IdDetalleOrdenCompra

UNION ALL

SELECT 
 'RE - '+Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+
	Convert(varchar,Remitos.NumeroRemito) as [Numero]
FROM DetalleRemitos dr
LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
WHERE dr.IdDetalleOrdenCompra=@IdDetalleOrdenCompra


