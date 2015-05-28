
CREATE PROCEDURE [dbo].[OrdenesCompra_TX_PorIdClienteTodosParaCredito]

@IdCliente int,
@IdNotaCreditoActual int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30), @Entregado numeric, @Pedido numeric
SET @vector_X='01111111111111111111133'
SET @vector_T='039000D0193309909091100'

SELECT 
 doc.IdDetalleOrdenCompra,
 OrdenesCompra.NumeroOrdenCompra as [O.Compra],
 doc.IdDetalleOrdenCompra,
 OrdenesCompra.NumeroOrdenCompraCliente as [O.C.(Cli.)],
 Obras.NumeroObra as [Obra],
 doc.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 doc.Cantidad as [Cant.],
 Unidades.Abreviatura as [Unidad],
 doc.IdArticulo,
 doc.Precio as [Precio],
 doc.Cantidad * doc.Precio * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [Importe],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,doc.Cantidad-
		Isnull(
			(Select Sum(IsNull(df.Cantidad,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.Cantidad,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito<>@IdNotaCreditoActual)
		,0))
	Else Convert(varchar,100-
		Isnull(
			(Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito<>@IdNotaCreditoActual)
		,0))+' %'
 End as [Pendiente],
 Case When doc.TipoCancelacion=1
	Then doc.Cantidad-
		Isnull(
			(Select Sum(IsNull(df.Cantidad,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.Cantidad,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito<>@IdNotaCreditoActual)
		,0)
	Else 100-
		Isnull(
			(Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito<>@IdNotaCreditoActual)
		,0)
 End as [Pendiente_SF],
 doc.TipoCancelacion,
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,
		Isnull(
			(Select Sum(IsNull(dncoc.Cantidad,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito=@IdNotaCreditoActual)
		,0))
	Else Convert(varchar,
		Isnull(
			(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito=@IdNotaCreditoActual)
		,0))+' %'
 End as [A acreditar],
 Case When doc.TipoCancelacion=1
	Then Isnull(
			(Select Sum(IsNull(dncoc.Cantidad,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito=@IdNotaCreditoActual)
		,0)
	Else Isnull(
			(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito=@IdNotaCreditoActual)
		,0)
 End as [AAcreditar_SF],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,doc.Cantidad-
		Isnull(
			(Select Sum(IsNull(df.Cantidad,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.Cantidad,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0))
	Else Convert(varchar,100-
		Isnull(
			(Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0))+' %'
 End as [Nuevo pend.],
 Case When doc.TipoCancelacion=1
	Then doc.Cantidad-
		Isnull(
			(Select Sum(IsNull(df.Cantidad,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.Cantidad,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0)
	Else 100-
		Isnull(
			(Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0)
 End as [NuevoPendiente_SF],
 doc.PorcentajeBonificacion as [% Bon],
 Colores.Descripcion as [Color],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN Colores ON doc.IdColor=Colores.IdColor
WHERE (OrdenesCompra.Anulada is null or OrdenesCompra.Anulada<>'SI') and OrdenesCompra.IdCliente = @IdCliente
ORDER BY OrdenesCompra.FechaOrdenCompra,OrdenesCompra.NumeroOrdenCompra
