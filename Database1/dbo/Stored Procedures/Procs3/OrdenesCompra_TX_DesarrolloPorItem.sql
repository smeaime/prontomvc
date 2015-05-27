
CREATE PROCEDURE [dbo].[OrdenesCompra_TX_DesarrolloPorItem]

@ActivaRango int,
@DesdeAlfa varchar(100),
@HastaAlfa varchar(100),
@Pendiente varchar(2),
@TipoComprobante varchar(1) = Null,
@TipoInforme varchar(1) = Null

AS

SET NOCOUNT ON

SET @TipoComprobante=IsNull(@TipoComprobante,'F')
SET @TipoInforme=IsNull(@TipoInforme,'D')

CREATE TABLE #Auxiliar1
			(
			 IdDetalleOrdenCompra INTEGER,
			 NumeroOrdenCompra INTEGER,
			 FechaOrdenCompra DATETIME,
			 IdCliente INTEGER,
			 NumeroItem INTEGER,
			 TipoComprobante VARCHAR(2),
			 NumeroComprobante INTEGER,
			 FechaComprobante DATETIME,
			 IdArticulo INTEGER,
			 IdUnidad INTEGER,
			 TipoCancelacion INTEGER,
			 Cantidad NUMERIC(18, 2),
			 CantidadPedida NUMERIC(18, 2),
			 CantidadEntregada NUMERIC(18, 2),
			 PorcentajeCertificacion NUMERIC(18, 2),
			 Observaciones VARCHAR(1000),
			 FechaEntrega DATETIME,
			 IdColor INTEGER,
			)
INSERT INTO #Auxiliar1 
 SELECT 
  doc.IdDetalleOrdenCompra,
  OrdenesCompra.NumeroOrdenCompra,
  OrdenesCompra.FechaOrdenCompra,
  OrdenesCompra.IdCliente,
  doc.NumeroItem,
  'OC',
  Null,
  Null,
  doc.IdArticulo,
  doc.IdUnidad,
  doc.TipoCancelacion,
  doc.Cantidad,
  doc.Cantidad,
  0,
  100,
  Convert(varchar,OrdenesCompra.Observaciones),
  doc.FechaEntrega,
  doc.IdColor
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=OrdenesCompra.IdCliente
 WHERE  (OrdenesCompra.Anulada is null or OrdenesCompra.Anulada<>'SI') and 
	(@Pendiente='NO' or (@Pendiente='SI' and IsNull(doc.Cumplido,'NO')='NO')) and 
	(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa))

IF @TipoComprobante='F'
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 
	  dfoc.IdDetalleOrdenCompra,
	  OrdenesCompra.NumeroOrdenCompra,
	  OrdenesCompra.FechaOrdenCompra,
	  OrdenesCompra.IdCliente,
	  doc.NumeroItem,
	  'FA',
	  fa.NumeroFactura,
	  fa.FechaFactura,
	  doc.IdArticulo,
	  doc.IdUnidad,
	  doc.TipoCancelacion,
	  df.Cantidad * -1,
	  0,
	  df.Cantidad * -1,
	  df.PorcentajeCertificacion * -1,
	  Convert(varchar,df.Observaciones),
	  Null,
	  Null
	 FROM DetalleFacturasOrdenesCompra dfoc
	 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
	 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
	 LEFT OUTER JOIN DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
	 LEFT OUTER JOIN Facturas fa On fa.IdFactura=df.IdFactura
	 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=OrdenesCompra.IdCliente
	 WHERE (OrdenesCompra.Anulada is null or OrdenesCompra.Anulada<>'SI') and 
		(@Pendiente='NO' or (@Pendiente='SI' and IsNull(doc.Cumplido,'NO')='NO')) and 
		OrdenesCompra.IdOrdenCompra is not null and (fa.Anulada is null or fa.Anulada<>'SI') and 
		(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa))

	 UNION ALL
	
	 SELECT 
	  dncoc.IdDetalleOrdenCompra,
	  OrdenesCompra.NumeroOrdenCompra,
	  OrdenesCompra.FechaOrdenCompra,
	  OrdenesCompra.IdCliente,
	  doc.NumeroItem,
	  'NC',
	  nc.NumeroNotaCredito, 
	  nc.FechaNotaCredito,
	  doc.IdArticulo,
	  doc.IdUnidad,
	  doc.TipoCancelacion,
	  dncoc.Cantidad,
	  0,
	  dncoc.Cantidad,
	  dncoc.PorcentajeCertificacion,
	  Convert(varchar,nc.Observaciones),
	  Null,
	  Null
	 FROM DetalleNotasCreditoOrdenesCompra dncoc
	 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dncoc.IdDetalleOrdenCompra
	 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
	 LEFT OUTER JOIN NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
	 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=OrdenesCompra.IdCliente
	 WHERE (OrdenesCompra.Anulada is null or OrdenesCompra.Anulada<>'SI') and 
		(@Pendiente='NO' or (@Pendiente='SI' and IsNull(doc.Cumplido,'NO')='NO')) and 
		OrdenesCompra.IdOrdenCompra is not null and (nc.Anulada is null or nc.Anulada<>'SI') and 
		(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa))
    END
ELSE
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 
	  Det.IdDetalleOrdenCompra,
	  OrdenesCompra.NumeroOrdenCompra,
	  OrdenesCompra.FechaOrdenCompra,
	  OrdenesCompra.IdCliente,
	  doc.NumeroItem,
	  'RE',
	  Remitos.NumeroRemito,
	  Remitos.FechaRemito,
	  doc.IdArticulo,
	  doc.IdUnidad,
	  doc.TipoCancelacion,
	  Det.Cantidad * -1,
	  0,
	  Det.Cantidad * -1,
	  Det.PorcentajeCertificacion * -1,
	  Convert(varchar,Det.Observaciones),
	  Null,
	  Null
	 FROM DetalleRemitos Det
	 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = Det.IdDetalleOrdenCompra
	 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
	 LEFT OUTER JOIN Remitos ON Remitos.IdRemito=Det.IdRemito
	 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=OrdenesCompra.IdCliente
	 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and 
		(@Pendiente='NO' or (@Pendiente='SI' and IsNull(doc.Cumplido,'NO')='NO')) and 
		OrdenesCompra.IdOrdenCompra is not null and IsNull(Remitos.Anulado,'NO')<>'SI' and 
		(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa))
    END

UPDATE #Auxiliar1
SET PorcentajeCertificacion=Null
WHERE TipoCancelacion=1

UPDATE #Auxiliar1
SET Cantidad=Null
WHERE TipoCancelacion=2 and TipoComprobante<>'OC'

CREATE TABLE #Auxiliar2
			(
			 IdDetalleOrdenCompra INTEGER,
			 NumeroOrdenCompra INTEGER,
			 FechaOrdenCompra DATETIME,
			 IdCliente INTEGER,
			 NumeroItem INTEGER,
			 IdArticulo INTEGER,
			 IdUnidad INTEGER,
			 TipoCancelacion INTEGER,
			 CantidadPedida NUMERIC(18, 2),
			 CantidadEntregada NUMERIC(18, 2),
			 PorcentajeCertificacion NUMERIC(18, 2),
			 FechaEntrega DATETIME,
			 IdColor INTEGER
			)
IF @TipoInforme='R'
    BEGIN
	INSERT INTO #Auxiliar2 
	 SELECT IdDetalleOrdenCompra, NumeroOrdenCompra, FechaOrdenCompra, IdCliente, NumeroItem, IdArticulo, IdUnidad, TipoCancelacion, 
		Sum(IsNull(CantidadPedida,0)), Sum(IsNull(CantidadEntregada,0)), Sum(IsNull(PorcentajeCertificacion,0)), FechaEntrega, IdColor
	 FROM #Auxiliar1
	 GROUP BY IdDetalleOrdenCompra, NumeroOrdenCompra, FechaOrdenCompra, IdCliente, NumeroItem, IdArticulo, IdUnidad, 
			TipoCancelacion, FechaEntrega, IdColor
    END

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)

IF @TipoInforme='D'
    BEGIN
	SET @vector_X='000001111111111111111133'
	SET @vector_T='00000340202D100342251A00'
	
	SELECT 
	 #Auxiliar1.IdDetalleOrdenCompra,
	 #Auxiliar1.NumeroOrdenCompra as [Aux1],
	 #Auxiliar1.FechaOrdenCompra as [Aux2],
	 #Auxiliar1.NumeroItem as [Aux3],
	 1 as [Aux4],
	 #Auxiliar1.NumeroOrdenCompra as [Nro.OC],
	 #Auxiliar1.FechaOrdenCompra as [Fecha OC],
	 #Auxiliar1.NumeroItem as [Item],
	 Clientes.Codigo as [Cod.Cli.],
	 Clientes.RazonSocial as [Cliente],
	 Articulos.Codigo as [Cod.Art.],
	 Articulos.Descripcion as [Articulo],
	 Colores.Descripcion as [Color],
	 Unidades.Abreviatura as [En],
	 #Auxiliar1.TipoComprobante as [Tipo],
	 #Auxiliar1.NumeroComprobante as [Nro.Comp.],
	 #Auxiliar1.FechaComprobante as [Fecha Comp.],
	 #Auxiliar1.Cantidad,
	 #Auxiliar1.PorcentajeCertificacion as [% Avance],
	 #Auxiliar1.FechaEntrega as [Fecha entrega],
	 DateDiff(day,GetDate(),#Auxiliar1.FechaEntrega) as [Dif.Dias],
	 #Auxiliar1.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN Colores ON #Auxiliar1.IdColor = Colores.IdColor
	WHERE #Auxiliar1.TipoComprobante='OC'
	
	UNION ALL 
	
	SELECT 
	 #Auxiliar1.IdDetalleOrdenCompra,
	 #Auxiliar1.NumeroOrdenCompra as [Aux1],
	 #Auxiliar1.FechaOrdenCompra as [Aux2],
	 #Auxiliar1.NumeroItem as [Aux3],
	 2 as [Aux4],
	 Null as [Nro.OC],
	 Null as [Fecha OC],
	 Null as [Item],
	 Null as [Cod.Cli.],
	 Null as [Cliente],
	 Null as [Cod.Art.],
	 Null as [Articulo],
	 Null as [Color],
	 Null as [En],
	 #Auxiliar1.TipoComprobante as [Tipo],
	 #Auxiliar1.NumeroComprobante as [Nro.Comp.],
	 #Auxiliar1.FechaComprobante as [Fecha Comp.],
	 #Auxiliar1.Cantidad,
	 #Auxiliar1.PorcentajeCertificacion as [% Avance],
	 Null as [Fecha entrega],
	 Null as [Dif.Dias],
	 #Auxiliar1.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad
	WHERE #Auxiliar1.TipoComprobante<>'OC'
	
	UNION ALL 
	
	SELECT 
	 0,
	 #Auxiliar1.NumeroOrdenCompra as [Aux1],
	 #Auxiliar1.FechaOrdenCompra as [Aux2],
	 #Auxiliar1.NumeroItem as [Aux3],
	 8 as [Aux4],
	 Null as [Nro.OC],
	 Null as [Fecha OC],
	 Null as [Item],
	 Null as [Cod.Cli.],
	 Null as [Cliente],
	 Null as [Cod.Art.],
	 '     TOTALES DEL ITEM' as [Articulo],
	 Null as [Color],
	 Null as [En],
	 Null as [Tipo],
	 Null as [Nro.Comp.],
	 Null as [Fecha Comp.],
	 SUM(IsNull(#Auxiliar1.Cantidad,0)),
	 SUM(IsNull(#Auxiliar1.PorcentajeCertificacion,0)) as [% Avance],
	 Null as [Fecha entrega],
	 Null as [Dif.Dias],
	 Null as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	GROUP BY #Auxiliar1.NumeroOrdenCompra,#Auxiliar1.FechaOrdenCompra,#Auxiliar1.NumeroItem
	
	UNION ALL 
	
	SELECT 
	 0,
	 #Auxiliar1.NumeroOrdenCompra as [Aux1],
	 #Auxiliar1.FechaOrdenCompra as [Aux2],
	 #Auxiliar1.NumeroItem as [Aux3],
	 9 as [Aux4],
	 Null as [Nro.OC],
	 Null as [Fecha OC],
	 Null as [Item],
	 Null as [Cod.Cli.],
	 Null as [Cliente],
	 Null as [Cod.Art.],
	 Null as [Articulo],
	 Null as [Color],
	 Null as [En],
	 Null as [Tipo],
	 Null as [Nro.Comp.],
	 Null as [Fecha Comp.],
	 Null as [Cantidad],
	 Null as [% Avance],
	 Null as [Fecha entrega],
	 Null as [Dif.Dias],
	 Null as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	GROUP BY #Auxiliar1.NumeroOrdenCompra, #Auxiliar1.FechaOrdenCompra, #Auxiliar1.NumeroItem
	
	ORDER BY #Auxiliar1.FechaOrdenCompra, #Auxiliar1.NumeroOrdenCompra, #Auxiliar1.NumeroItem, [Aux4], [Nro.Comp.]
    END
ELSE
    BEGIN
	SET @vector_X='0111111111166611133'
	SET @vector_T='0340202D10222251A00'
	
	SELECT 
	 #Auxiliar2.IdDetalleOrdenCompra,
	 #Auxiliar2.NumeroOrdenCompra as [Nro.OC],
	 #Auxiliar2.FechaOrdenCompra as [Fecha OC],
	 #Auxiliar2.NumeroItem as [Item],
	 Clientes.Codigo as [Cod.Cli.],
	 Clientes.RazonSocial as [Cliente],
	 Articulos.Codigo as [Cod.Art.],
	 Articulos.Descripcion as [Articulo],
	 Colores.Descripcion as [Color],
	 Unidades.Abreviatura as [En],
	 #Auxiliar2.CantidadPedida as [Cant.Ped.],
	 #Auxiliar2.CantidadEntregada as [Cant.Entr.],
	 #Auxiliar2.CantidadPedida+#Auxiliar2.CantidadEntregada as [Saldo],
	 #Auxiliar2.PorcentajeCertificacion as [% Avance],
	 #Auxiliar2.FechaEntrega as [Fecha entrega],
	 DateDiff(day,GetDate(),#Auxiliar2.FechaEntrega) as [Dif.Dias],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2 
	LEFT OUTER JOIN Clientes ON #Auxiliar2.IdCliente = Clientes.IdCliente
	LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON #Auxiliar2.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN Colores ON #Auxiliar2.IdColor = Colores.IdColor
	ORDER BY #Auxiliar2.NumeroOrdenCompra, #Auxiliar2.FechaOrdenCompra, #Auxiliar2.NumeroItem
    END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
