
CREATE PROCEDURE [dbo].[OrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente]

@IdCliente int

AS 

SET NOCOUNT ON
CREATE TABLE #Auxiliar1
			(
			 IdDetalleOrdenCompra INTEGER,
			 Pendiente NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  doc.IdDetalleOrdenCompra,
  Case When doc.TipoCancelacion=1
	Then doc.Cantidad-
		Isnull(
			(Select Sum(IsNull(df.Cantidad,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Left Outer Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Left Outer Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.Cantidad,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Left Outer Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0)
	Else 100-
		Isnull(
			(Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
			 From DetalleFacturasOrdenesCompra dfoc
			 Left Outer Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			 Left Outer Join Facturas fa On fa.IdFactura=df.IdFactura
			 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(fa.Anulada is null or fa.Anulada<>'SI'))
		,0)+
		Isnull(
			(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
			 From DetalleNotasCreditoOrdenesCompra dncoc
			 Left Outer Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
			 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				(nc.Anulada is null or nc.Anulada<>'SI'))
		,0)
  End
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE OrdenesCompra.IdCliente = @IdCliente and IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and IsNull(doc.Cumplido,'NO')='NO'

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30), @Entregado numeric, @Pedido numeric
SET @vector_X='01111111111111133'
SET @vector_T='03904HD0192209100'

SELECT 
 0,
 OrdenesCompra.NumeroOrdenCompra as [O.Compra],
 doc.IdDetalleOrdenCompra,
 OrdenesCompra.NumeroOrdenCompraCliente as [O.C.(Cli.)],
 Obras.NumeroObra as [Obra],
 doc.NumeroItem as [Item],
 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 doc.Cantidad as [Cant.],
 Unidades.Abreviatura as [Unidad],
 doc.IdArticulo,
 doc.Precio as [Precio],
 doc.PorcentajeBonificacion as [% Bon],
 doc.Cantidad * doc.Precio * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [Importe],
 Case When doc.TipoCancelacion=1
	Then #Auxiliar1.Pendiente
	Else #Auxiliar1.Pendiente
 End as [AFacturar],
 Case When doc.TipoCancelacion=1
	Then Convert(varchar,#Auxiliar1.Pendiente)
	Else Convert(varchar,#Auxiliar1.Pendiente)+' %'
 End as [Pend.facturar],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN #Auxiliar1 ON doc.IdDetalleOrdenCompra = #Auxiliar1.IdDetalleOrdenCompra
LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
WHERE OrdenesCompra.IdCliente = @IdCliente and IsNull(OrdenesCompra.Anulada,'')<>'SI' and IsNull(#Auxiliar1.Pendiente,0)>0
DROP TABLE #Auxiliar1
