
CREATE PROCEDURE OrdenesProduccion_TX_ItemsPendientesDeProducir
@IdArticuloFiltro int=0
AS

Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='001111111111111111133'
Set @vector_T='002243220100122035100'

Select 
 doc.IdDetalleOrdenCompra,
 doc.IdOrdenCompra,
 OrdenesCompra.NumeroOrdenCompraCliente as [O.C. Cli.)],
 OrdenesCompra.NumeroOrdenCompra as [O.Compra],
-- doc.FechaNecesidad as [Fecha],
 doc.FechaEntrega as [Fecha],
 Obras.NumeroObra as [Obra],
 Clientes.Codigo as [Codigo],
 Clientes.RazonSocial as [Cliente],
 doc.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 doc.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 Monedas.Abreviatura as [Mon.],
 doc.Precio as [Precio],
 doc.Cantidad * doc.Precio * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [Importe OC],
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
 End as [Pend.facturar],
 (doc.Cantidad * doc.Precio * (1-IsNull(doc.PorcentajeBonificacion,0)/100)) - 
	Isnull((Select Sum(IsNull(df.Cantidad,0) * IsNull(df.PrecioUnitario,0) * (1-IsNull(df.Bonificacion,0)/100)) 
		From DetalleFacturasOrdenesCompra dfoc
		Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
		Inner Join Facturas fa On fa.IdFactura=df.IdFactura
		Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
			(fa.Anulada is null or fa.Anulada<>'SI')),0)
 as [Imp.pend.fact.],
 doc.Observaciones,
 doc.PorcentajeBonificacion as [% Bon],
-- 	Colores.Descripcion AS [Color],

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Colores ON ProduccionOrdenes.IdColor = Colores.IdColor
--LEFT OUTER JOIN Colores ON ProduccionOrdenes.IdColor = Colores.IdColor
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN Monedas ON OrdenesCompra.IdMoneda = Monedas.IdMoneda
WHERE  (OrdenesCompra.Anulada is null or OrdenesCompra.Anulada<>'SI') and 
	 IsNull(doc.Cumplido,'NO')='NO' and 
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
	 End > 0
