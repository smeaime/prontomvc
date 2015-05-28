CREATE PROCEDURE [dbo].[OrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente]

@IdCliente int = Null,
@SoloPendiente int = Null,
@Desde datetime = Null,
@Hasta datetime = Null

AS

SET @IdCliente=IsNull(@IdCliente,-1)
SET @SoloPendiente=IsNull(@SoloPendiente,-1)
SET @Desde=IsNull(@Desde,Convert(datetime,'1/1/1900',103))
SET @Hasta=IsNull(@Hasta,Convert(datetime,'31/12/2100',103))

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111111111111133'
SET @vector_T='00641010022205100'

SELECT 
 doc.IdDetalleOrdenCompra,
 doc.IdOrdenCompra,
 OrdenesCompra.NumeroOrdenCompra as [Orden de compra],
 OrdenesCompra.FechaOrdenCompra [Fecha],
 Clientes.RazonSocial as [Cliente],
 doc.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 doc.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 doc.Precio as [Precio],
 doc.Cantidad * doc.Precio * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [Importe],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,Isnull((Select Sum(IsNull(drm.Cantidad,0)) 
					From DetalleRemitos drm
					Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (Remitos.Anulado is null or Remitos.Anulado<>'SI')),0))
	Else Convert(varchar,Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) 
					From DetalleRemitos drm
					Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (Remitos.Anulado is null or Remitos.Anulado<>'SI')	),0))+' %'
 End as [Remitido],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,doc.Cantidad-Isnull((Select Sum(IsNull(drm.Cantidad,0)) From DetalleRemitos drm
						 Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
						 Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(Remitos.Anulado,'')<>'SI'),0))
	Else Convert(varchar,100-Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) From DetalleRemitos drm
					Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(Remitos.Anulado,'')<>'SI'),0))+' %'
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
WHERE IsNull(OrdenesCompra.Anulada,'')<>'SI' and 
	(@IdCliente=-1 or OrdenesCompra.IdCliente=@IdCliente) and 
	((OrdenesCompra.FechaOrdenCompra Between @Desde And DATEADD(n,1439,@hasta))) and 
	(@SoloPendiente=-1 or (@SoloPendiente>=0 and 
	 Case When doc.TipoCancelacion=1
		Then doc.Cantidad-Isnull((Select Sum(IsNull(drm.Cantidad,0)) From DetalleRemitos drm
					  Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
					  Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(Remitos.Anulado,'')<>'SI'),0)
		Else 100-Isnull((Select Sum(IsNull(drm.PorcentajeCertificacion,0)) From DetalleRemitos drm
				 Left Outer Join Remitos On drm.IdRemito=Remitos.IdRemito
				 Where drm.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(Remitos.Anulado,'')<>'SI'),0)
	 End>0))
ORDER BY OrdenesCompra.FechaOrdenCompra, OrdenesCompra.NumeroOrdenCompra, doc.NumeroItem