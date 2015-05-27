
CREATE Procedure [dbo].[DetOrdenesCompra_TX_PorIdDetalleOrdenCompraConDatos]

@IdDetalleOrdenCompra int

AS 

SELECT 
 doc.*,
 Articulos.Descripcion as [Articulo],
 Articulos.IdUbicacionStandar,
 Case When doc.TipoCancelacion=1
	Then doc.Cantidad-Isnull((Select Sum(IsNull(drm.Cantidad,0)) 
				 From DetalleRemitos drm
				 Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
				 Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
					IsNull(Remitos.Anulado,'NO')<>'SI'),0)
	Else 100-Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) 
			From DetalleRemitos drm
			Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
			Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				IsNull(Remitos.Anulado,'NO')<>'SI'),0)
 End as [Pend.remitir],
 Colores.Descripcion as [Color]
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
WHERE (doc.IdDetalleOrdenCompra = @IdDetalleOrdenCompra)
