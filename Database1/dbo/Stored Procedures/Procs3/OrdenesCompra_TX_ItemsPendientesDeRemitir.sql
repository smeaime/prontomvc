
CREATE PROCEDURE [dbo].[OrdenesCompra_TX_ItemsPendientesDeRemitir]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001111111111111111133'
SET @vector_T='005542110E10022205100'

SELECT 
 doc.IdDetalleOrdenCompra,
 doc.IdOrdenCompra,
 OrdenesCompra.NumeroOrdenCompraCliente as [O.C.(Cli.)],
 OrdenesCompra.NumeroOrdenCompra as [Orden compra],
 OrdenesCompra.FechaOrdenCompra [Fecha],
 Obras.NumeroObra as [Obra],
 Clientes.Codigo as [Codigo],
 Clientes.RazonSocial as [Cliente],
 doc.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 Colores.Descripcion as [Color],
 doc.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 doc.Precio as [Precio],
 doc.Cantidad * doc.Precio * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [Importe],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,Isnull((Select Sum(IsNull(drm.Cantidad,0)) 
					From DetalleRemitos drm
					Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
						(Remitos.Anulado is null or Remitos.Anulado<>'SI')	),0))
	Else Convert(varchar,Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) 
					From DetalleRemitos drm
					Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
						(Remitos.Anulado is null or Remitos.Anulado<>'SI')	),0))+' %'
 End as [Remitido],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,doc.Cantidad-Isnull((Select Sum(IsNull(drm.Cantidad,0)) 
						 From DetalleRemitos drm
						 Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
						 Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
							(Remitos.Anulado is null or Remitos.Anulado<>'SI')	),0))
	Else Convert(varchar,100-Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) 
					From DetalleRemitos drm
					Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
						(Remitos.Anulado is null or Remitos.Anulado<>'SI')	),0))+' %'
 End as [Pend.remitir],
 doc.Observaciones,
 doc.PorcentajeBonificacion as [% Bon],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
WHERE  IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and IsNull(doc.Cumplido,'')<>'SI' and OrdenesCompra.Aprobo is not null and 
	Case When doc.TipoCancelacion=1
		Then doc.Cantidad-Isnull((Select Sum(IsNull(drm.Cantidad,0)) 
					  From DetalleRemitos drm
					  Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					  Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
						(Remitos.Anulado is null or Remitos.Anulado<>'SI')	),0)
		Else 100-Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) 
				From DetalleRemitos drm
				Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
				Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
					(Remitos.Anulado is null or Remitos.Anulado<>'SI')	),0)
	End > 0
