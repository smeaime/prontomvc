
CREATE PROCEDURE [dbo].[DetNotasCreditoOC_TXCre]

@IdNotaCredito int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111133'
SET @vector_T='039000000933000100'

SELECT
 DetNC_OC.IdDetalleNotaCreditoOrdenesCompra,
 OrdenesCompra.NumeroOrdenCompra as [O.Compra],
 DetNC_OC.IdDetalleOrdenCompra as [IdAux],
 OrdenesCompra.NumeroOrdenCompraCliente as [O.C.(Cli.)],
 Obras.NumeroObra as [Obra],
 doc.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 doc.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 doc.IdArticulo,
 doc.Precio as [Precio],
 doc.Cantidad * doc.Precio as [Importe],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,doc.Cantidad-
		Isnull(
			(Select Sum(df.Cantidad) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(dncoc.Cantidad) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito<>DetNC_OC.IdNotaCredito)
		,0))
	Else Convert(varchar,100-
		Isnull(
			(Select Sum(df.PorcentajeCertificacion) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(dncoc.PorcentajeCertificacion) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito<>DetNC_OC.IdNotaCredito)
		,0))+' %'
 End as [Pendiente],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,
		Isnull(
			(Select Sum(dncoc.Cantidad) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito=DetNC_OC.IdNotaCredito)
		,0))
	Else Convert(varchar,
		Isnull(
			(Select Sum(dncoc.PorcentajeCertificacion) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI') and 
				nc.IdNotaCredito=DetNC_OC.IdNotaCredito)
		,0))+' %'
 End as [A acreditar],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,doc.Cantidad-
		Isnull(
			(Select Sum(df.Cantidad) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(dncoc.Cantidad) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0))
	Else Convert(varchar,100-
		Isnull(
			(Select Sum(df.PorcentajeCertificacion) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(dncoc.PorcentajeCertificacion) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0))+' %'
 End as [Nuevo pend.],
 Colores.Descripcion as [Color],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasCreditoOrdenesCompra DetNC_OC
LEFT OUTER JOIN DetalleOrdenesCompra doc ON DetNC_OC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON doc.IdColor=Colores.IdColor
WHERE (DetNC_OC.IdNotaCredito = @IdNotaCredito)
