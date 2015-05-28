CREATE PROCEDURE [dbo].[OrdenesCompra_TX_ItemsPendientesDeFacturarPorIdOrdenCompra]

@IdOrdenCompra int = Null,
@IdCliente int = Null,
@SoloPendiente int = Null,
@Desde datetime = Null,
@Hasta datetime = Null


AS

SET @IdOrdenCompra=IsNull(@IdOrdenCompra,-1)
SET @IdCliente=IsNull(@IdCliente,-1)
SET @SoloPendiente=IsNull(@SoloPendiente,-1)
SET @Desde=IsNull(@Desde,Convert(datetime,'1/1/1900',103))
SET @Hasta=IsNull(@Hasta,Convert(datetime,'31/12/2100',103))

SELECT 
 doc.*,
 OrdenesCompra.NumeroOrdenCompra,
 OrdenesCompra.FechaOrdenCompra,
 OrdenesCompra.IdCliente,
 OrdenesCompra.IdCondicionVenta,
 OrdenesCompra.IdMoneda,
 OrdenesCompra.IdObra,
 OrdenesCompra.Anulada,
 OrdenesCompra.PorcentajeBonificacion as [PorcentajeBonificacionOC],
 OrdenesCompra.IdListaPrecios,
 Clientes.Codigo,
 Clientes.RazonSocial as [Cliente],
 Articulos.Codigo as [CodigoArticulo],
 Articulos.Descripcion as [Articulo],
 Articulos.CostoPPP,
 Articulos.AlicuotaIVA,
 Unidades.Descripcion as [Unidad],
 Colores.Descripcion as [Color],
 doc.Cantidad * doc.Precio * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [ImporteItem],
 Isnull((Select Sum(IsNull(df.Cantidad,0)) 
	 From DetalleFacturasOrdenesCompra dfoc
	 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
	 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
	 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (fa.Anulada is null or fa.Anulada<>'SI')),0)+
 Isnull((Select Sum(IsNull(dncoc.Cantidad,0)) 
	 From DetalleNotasCreditoOrdenesCompra dncoc
	 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
	 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (nc.Anulada is null or nc.Anulada<>'SI')),0) as [Facturado],
 Isnull((Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
	 From DetalleFacturasOrdenesCompra dfoc
	 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
	 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
	 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (fa.Anulada is null or fa.Anulada<>'SI')),0)+
 Isnull((Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
	 From DetalleNotasCreditoOrdenesCompra dncoc
	 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
	 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (nc.Anulada is null or nc.Anulada<>'SI')),0) as [PorcentajeFacturado],
 Case When doc.TipoCancelacion=1
	Then doc.Cantidad - 
		Isnull((Select Sum(IsNull(df.Cantidad,0)) 
			From DetalleFacturasOrdenesCompra dfoc
			Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (fa.Anulada is null or fa.Anulada<>'SI')),0)+
		Isnull((Select Sum(IsNull(dncoc.Cantidad,0)) 
			From DetalleNotasCreditoOrdenesCompra dncoc
			Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (nc.Anulada is null or nc.Anulada<>'SI')),0)
	Else 1
 End as [CantidadPendienteDeFacturar],
 Case When doc.TipoCancelacion=2
	Then 100 - 
		Isnull((Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
			From DetalleFacturasOrdenesCompra dfoc
			Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			Inner Join Facturas fa On fa.IdFactura=df.IdFactura
			Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (fa.Anulada is null or fa.Anulada<>'SI')),0)+
		Isnull((Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			From DetalleNotasCreditoOrdenesCompra dncoc
			Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (nc.Anulada is null or nc.Anulada<>'SI')),0)
	Else Null
 End as [PorcentajePendienteDeFacturar]
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
WHERE (OrdenesCompra.Anulada is null or OrdenesCompra.Anulada<>'SI') and 
	(@IdOrdenCompra=-1 or doc.IdOrdenCompra=@IdOrdenCompra) and 
	(@IdCliente=-1 or OrdenesCompra.IdCliente=@IdCliente) and 
	((OrdenesCompra.FechaOrdenCompra Between @Desde And DATEADD(n,1439,@hasta))) and 
	(@SoloPendiente=-1 or (@SoloPendiente>=0 and 
	 Case When doc.TipoCancelacion=1
		Then doc.Cantidad-
			Isnull((Select Sum(IsNull(df.Cantidad,0)) 
				From DetalleFacturasOrdenesCompra dfoc
				Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
				Inner Join Facturas fa On fa.IdFactura=df.IdFactura
				Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (fa.Anulada is null or fa.Anulada<>'SI')),0)+
			Isnull((Select Sum(IsNull(dncoc.Cantidad,0)) 
				From DetalleNotasCreditoOrdenesCompra dncoc
				Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
				Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (nc.Anulada is null or nc.Anulada<>'SI')),0)
		Else 100-
			Isnull((Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
				From DetalleFacturasOrdenesCompra dfoc
				Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
				Inner Join Facturas fa On fa.IdFactura=df.IdFactura
				Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (fa.Anulada is null or fa.Anulada<>'SI')),0)+
			Isnull((Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
				From DetalleNotasCreditoOrdenesCompra dncoc
				Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
				Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and (nc.Anulada is null or nc.Anulada<>'SI')),0)
	 End > 0))
ORDER BY OrdenesCompra.FechaOrdenCompra, OrdenesCompra.NumeroOrdenCompra, doc.NumeroItem