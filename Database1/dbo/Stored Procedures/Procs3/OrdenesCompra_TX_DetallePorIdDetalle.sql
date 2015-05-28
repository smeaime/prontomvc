
CREATE PROCEDURE [dbo].[OrdenesCompra_TX_DetallePorIdDetalle]

@IdDetalleOrdenCompra int

AS

SELECT
 doc.*,
 OrdenesCompra.NumeroOrdenCompra,
 OrdenesCompra.NumeroOrdenCompraCliente,
 OrdenesCompra.IdCondicionVenta,
 OrdenesCompra.IdMoneda,
 OrdenesCompra.IdObra,
 OrdenesCompra.PorcentajeBonificacion as [PorcentajeBonificacionOC],
 OrdenesCompra.IdListaPrecios,
 OrdenesCompra.IdDetalleClienteLugarEntrega,
 Articulos.AlicuotaIVA,
 Articulos.CostoPPP,
 Articulos.CostoPPPDolar,
 Colores.Descripcion as [Color],
 Case When doc.TipoCancelacion=1
	Then doc.Cantidad-Isnull((Select Sum(IsNull(drm.Cantidad,0)) 
				 From DetalleRemitos drm
				 Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
				 Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(Remitos.Anulado,'NO')<>'SI'),0)
	Else 100-Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) 
			From DetalleRemitos drm
			Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
			Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(Remitos.Anulado,'NO')<>'SI'),0)
 End as [PendienteRemitir]
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
WHERE doc.IdDetalleOrdenCompra=@IdDetalleOrdenCompra
