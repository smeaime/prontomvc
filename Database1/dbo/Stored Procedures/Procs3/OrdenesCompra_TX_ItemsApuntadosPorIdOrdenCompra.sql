


CREATE PROCEDURE [dbo].[OrdenesCompra_TX_ItemsApuntadosPorIdOrdenCompra]

@IdOrdenCompra int

AS

SELECT 
 drm.IdDetalleOrdenCompra,
 doc.NumeroItem,
 'RM' as [Tipo],
 re.NumeroRemito as [Numero],
 re.FechaRemito as [Fecha]
FROM DetalleRemitos drm 
LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = drm.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Remitos re On re.IdRemito=drm.IdRemito
WHERE OrdenesCompra.IdOrdenCompra=@IdOrdenCompra and (re.Anulado is null or re.Anulado<>'SI')

UNION ALL

SELECT 
 dfoc.IdDetalleOrdenCompra,
 doc.NumeroItem,
 'FA' as [Tipo],
 fa.NumeroFactura as [Numero],
 fa.FechaFactura as [Fecha]
FROM DetalleFacturasOrdenesCompra dfoc
LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
LEFT OUTER JOIN Facturas fa On fa.IdFactura=df.IdFactura
WHERE OrdenesCompra.IdOrdenCompra=@IdOrdenCompra and (fa.Anulada is null or fa.Anulada<>'SI')

UNION ALL

SELECT 
 dncoc.IdDetalleOrdenCompra,
 doc.NumeroItem,
 'NC' as [Tipo],
 nc.NumeroNotaCredito as [Numero], 
 nc.FechaNotaCredito as [Fecha]
FROM DetalleNotasCreditoOrdenesCompra dncoc
LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dncoc.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
WHERE OrdenesCompra.IdOrdenCompra=@IdOrdenCompra and (nc.Anulada is null or nc.Anulada<>'SI')


