
CREATE PROCEDURE [dbo].[Remitos_TX_DetallesPendientesDeFacturarPorIdCliente]

@IdCliente int

As

declare @vector_X varchar(30),@vector_T varchar(30), @Entregado numeric, @Pedido numeric
set @vector_X='01111111133'
set @vector_T='03911110900'

SELECT 
 0,
 Remitos.NumeroRemito as [Remito],
 dr.IdDetalleRemito,
 dr.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 dr.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 Case When IsNull(dr.TipoCancelacion,1)=1
	Then Convert(varchar,dr.Cantidad-
		Isnull(
			(Select Sum(df.Cantidad) 
			 From DetalleFacturasRemitos dfr
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
			 Inner Join Facturas On Facturas.IdFactura=dfr.IdFactura
			 Where dfr.IdDetalleRemito=dr.IdDetalleRemito and 
				(Facturas.Anulada is null or Facturas.Anulada<>'SI'))
		,0))
	Else Convert(varchar,100-
		Isnull(
			(Select Sum(df.PorcentajeCertificacion) 
			 From DetalleFacturasRemitos dfr
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
			 Inner Join Facturas On Facturas.IdFactura=dfr.IdFactura
			 Where dfr.IdDetalleRemito=dr.IdDetalleRemito and 
				(Facturas.Anulada is null or Facturas.Anulada<>'SI'))
		,0))+' %'
 End as [Pendiente],
 Case When IsNull(dr.TipoCancelacion,1)=1
	Then dr.Cantidad-
		Isnull(
			(Select Sum(df.Cantidad) 
			 From DetalleFacturasRemitos dfr
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
			 Inner Join Facturas On Facturas.IdFactura=dfr.IdFactura
			 Where dfr.IdDetalleRemito=dr.IdDetalleRemito and 
				(Facturas.Anulada is null or Facturas.Anulada<>'SI'))
		,0)
	Else 100-
		Isnull(
			(Select Sum(df.PorcentajeCertificacion) 
			 From DetalleFacturasRemitos dfr
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
			 Inner Join Facturas On Facturas.IdFactura=dfr.IdFactura
			 Where dfr.IdDetalleRemito=dr.IdDetalleRemito and 
				(Facturas.Anulada is null or Facturas.Anulada<>'SI'))
		,0)
 End as [AFacturar],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRemitos dr
LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
LEFT OUTER JOIN Articulos ON dr.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON dr.IdUnidad = Unidades.IdUnidad
WHERE Remitos.IdCliente = @IdCliente and Remitos.Destino=1 and (Remitos.Anulado is null or Remitos.Anulado<>'SI')
