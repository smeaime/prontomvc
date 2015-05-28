
CREATE PROCEDURE [dbo].[Remitos_TX_ItemsPendientesDeFacturarPorFechaCliente]

@Desde datetime,
@Hasta datetime,
@IdCliente int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30), @Entregado numeric, @Pedido numeric
SET @vector_X='0111111111111111133'
SET @vector_T='0E94111133210E11000'

SELECT 
 0,
 Substring('0000',1,4-Len(Convert(varchar,Remitos.PuntoVenta)))+Convert(varchar,Remitos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Remito],
 dr.IdDetalleRemito,
 Remitos.FechaRemito [Fecha],
 Transportistas.RazonSocial as [Transportista],
 Remitos.Chofer [Chofer],
 Remitos.Patente [Patente],
 Remitos.OrdenCarga [O.Carga],
 Remitos.COT [COT],
 Remitos.OrdenCompra [O.Compra],
 Clientes.Codigo as [Codigo],
 Clientes.RazonSocial as [Cliente],
 dr.NumeroItem as [Item],
 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 dr.Cantidad as [Cant.],
 Unidades.Abreviatura as [Unidad],
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
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRemitos dr
LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
LEFT OUTER JOIN Clientes ON Remitos.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Articulos ON dr.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON dr.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Transportistas ON Remitos.IdTransportista=Transportistas.IdTransportista
LEFT OUTER JOIN UnidadesEmpaque ON dr.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
WHERE  Remitos.Destino=1 and (Remitos.Anulado is null or Remitos.Anulado<>'SI') and 
	(@IdCliente=-1 or Remitos.IdCliente=@IdCliente) and 
	(Remitos.FechaRemito Between @Desde And @Hasta) and 
	Case When  IsNull(dr.TipoCancelacion,1)=1
		Then dr.Cantidad-
			Isnull(
				(Select Sum(df.Cantidad) 
				 From DetalleFacturasRemitos dfr
				 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
				 Inner Join Facturas On Facturas.IdFactura=dfr.IdFactura
				 Where dfr.IdDetalleRemito=dr.IdDetalleRemito and (Facturas.Anulada is null or Facturas.Anulada<>'SI'))
			,0)
		Else 100-
			Isnull(
				(Select Sum(df.PorcentajeCertificacion) 
				 From DetalleFacturasRemitos dfr
				 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
				 Inner Join Facturas On Facturas.IdFactura=dfr.IdFactura
				 Where dfr.IdDetalleRemito=dr.IdDetalleRemito and (Facturas.Anulada is null or Facturas.Anulada<>'SI'))
			,0)
	End > 0
