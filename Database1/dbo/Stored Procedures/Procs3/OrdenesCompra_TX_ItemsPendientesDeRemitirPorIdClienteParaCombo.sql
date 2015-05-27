CREATE PROCEDURE [dbo].[OrdenesCompra_TX_ItemsPendientesDeRemitirPorIdClienteParaCombo]

@IdCliente int,
@ComprobanteDestino varchar(1) = Null,
@ModeloDatos varchar(2) = Null

AS

SET NOCOUNT ON

SET @ComprobanteDestino=IsNull(@ComprobanteDestino,'F')
SET @ModeloDatos=IsNull(@ModeloDatos,'01')

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleOrdenCompra INTEGER,
			 NumeroOrdenCompraCliente VARCHAR(20),
			 NumeroObra VARCHAR(13),
			 NumeroItem INTEGER,
			 Articulo VARCHAR(200),
			 Cantidad NUMERIC(18,2),
			 Pendiente NUMERIC(18,2),
			 Unidad VARCHAR(20),
			 Color VARCHAR(50)
			)
CREATE TABLE #Auxiliar2	
			(
			 IdDetalleOrdenCompra INTEGER,
			 Cantidad NUMERIC(18,2),
			 PorcentajeCertificacion NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdDetalleOrdenCompra) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT drm.IdDetalleOrdenCompra, Sum(IsNull(drm.Cantidad,0)), Sum(IsNull(drm.PorcentajeCertificacion,0)) 
 FROM DetalleRemitos drm
 LEFT OUTER JOIN Remitos ON drm.IdRemito=Remitos.IdRemito
 WHERE IsNull(drm.IdDetalleOrdenCompra,0)>0 and IsNull(Remitos.Anulado,'NO')<>'SI' and Remitos.IdCliente = @IdCliente
 GROUP BY drm.IdDetalleOrdenCompra

IF @ComprobanteDestino='F'
	INSERT INTO #Auxiliar1 
	 SELECT 
	  doc.IdDetalleOrdenCompra,
	  OrdenesCompra.NumeroOrdenCompraCliente,
	  Obras.NumeroObra,
	  doc.NumeroItem,
	  Articulos.Descripcion,
	  doc.Cantidad,
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
	  End,
	  Unidades.Abreviatura,
	  Colores.Descripcion
	 FROM DetalleOrdenesCompra doc
	 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
	 LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
	 LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
	 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
	 LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
	 WHERE IsNull(OrdenesCompra.Anulada,'')<>'SI' and OrdenesCompra.IdCliente = @IdCliente and IsNull(doc.Cumplido,'')<>'SI' and 
		 Case When doc.TipoCancelacion=1
			Then doc.Cantidad-
				Isnull(
					(Select Sum(IsNull(df.Cantidad,0)) 
					 From DetalleFacturasOrdenesCompra dfoc
					 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
					 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
					 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(fa.Anulada,'')<>'SI')
				,0)+
				Isnull(
					(Select Sum(IsNull(dncoc.Cantidad,0)) 
					 From DetalleNotasCreditoOrdenesCompra dncoc
					 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
					 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(nc.Anulada,'')<>'SI')
				,0)
			Else 100-
				Isnull(
					(Select Sum(IsNull(df.PorcentajeCertificacion,0)) 
					 From DetalleFacturasOrdenesCompra dfoc
					 Inner Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
					 Inner Join Facturas fa On fa.IdFactura=df.IdFactura
					 Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(fa.Anulada,'')<>'SI')
				,0)+
				Isnull(
					(Select Sum(IsNull(dncoc.PorcentajeCertificacion,0)) 
					 From DetalleNotasCreditoOrdenesCompra dncoc
					 Inner Join NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
					 Where dncoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and IsNull(nc.Anulada,'')<>'SI')
				,0)
		 End > 0
ELSE
	INSERT INTO #Auxiliar1 
	 SELECT 
	  doc.IdDetalleOrdenCompra,
	  OrdenesCompra.NumeroOrdenCompraCliente,
	  Obras.NumeroObra,
	  doc.NumeroItem,
	  Articulos.Descripcion,
	  doc.Cantidad,
	  Case When doc.TipoCancelacion=1
		Then doc.Cantidad-Isnull(#Auxiliar2.Cantidad,0)
		Else 100-Isnull(#Auxiliar2.PorcentajeCertificacion,0)
	  End,
	  Unidades.Abreviatura,
	  Colores.Descripcion
	 FROM DetalleOrdenesCompra doc
	 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
	 LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
	 LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
	 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
	 LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
	 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
	 WHERE IsNull(OrdenesCompra.Anulada,'')<>'SI' and OrdenesCompra.IdCliente = @IdCliente and IsNull(doc.Cumplido,'')<>'SI' and 
		Case When doc.TipoCancelacion=1
			Then doc.Cantidad-Isnull(#Auxiliar2.Cantidad,0)
			Else 100-Isnull(#Auxiliar2.PorcentajeCertificacion,0)
		End>0 

SET NOCOUNT OFF

SELECT 
 #Auxiliar1.IdDetalleOrdenCompra,
 Case When @ModeloDatos='01' Then
	 'O.compra : '+Convert(varchar,#Auxiliar1.NumeroOrdenCompraCliente)+', '+
	 'obra : '+Convert(varchar,#Auxiliar1.NumeroObra)+', '+
	 'item : '+Convert(varchar,#Auxiliar1.NumeroItem)+', '+
	 'material : '+#Auxiliar1.Articulo+', '+
	 'cant.: '+Convert(varchar,#Auxiliar1.Cantidad)+' '+#Auxiliar1.Unidad+' '+
	 'sdo.: '+Convert(varchar,#Auxiliar1.Pendiente)+' '+#Auxiliar1.Unidad+
	 IsNull(', color : '+#Auxiliar1.Color,'')
	When @ModeloDatos='02' Then
	 'O.compra : '+Convert(varchar,#Auxiliar1.NumeroOrdenCompraCliente)+', '+
	 ''+#Auxiliar1.Articulo+IsNull(', color : '+#Auxiliar1.Color,'')+
	 ', Pendiente : '+Convert(varchar,#Auxiliar1.Pendiente)+' '+#Auxiliar1.Unidad
	Else ''
 End as [Titulo]
FROM #Auxiliar1

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2