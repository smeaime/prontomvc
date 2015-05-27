CREATE Procedure [dbo].[Pedidos_TX_SeguimientoCompras]

@Desde datetime, 
@Hasta datetime, 
@IdObra int,
@SoloConEntregasExcedentes varchar(2) = Null,
@Formato varchar(20) = Null,
@TiposCompra varchar(20) = Null

AS 

SET NOCOUNT ON

SET @SoloConEntregasExcedentes=IsNull(@SoloConEntregasExcedentes,'')
SET @Formato=IsNull(@Formato,'')
SET @TiposCompra=IsNull(@TiposCompra,'')

DECLARE @IdMonedaPesos int, @IdMonedaDolar int, @IdMonedaEuro int

SET @IdMonedaPesos=(Select Parametros.IdMoneda From Parametros Where Parametros.IdParametro=1)
SET @IdMonedaDolar=(Select Parametros.IdMonedaDolar From Parametros Where Parametros.IdParametro=1)
SET @IdMonedaEuro=(Select Parametros.IdMonedaEuro From Parametros Where Parametros.IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdDetallePedido INTEGER,
			 IdDetalleRecepcion INTEGER,
			 IdDetalleRequerimiento INTEGER,
			 Renglon INTEGER
			)

CREATE TABLE #Auxiliar2 
			(
			 IdDetallePedido INTEGER,
			 IdDetalleRequerimiento INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdDetallePedido) ON [PRIMARY]

CREATE TABLE #Auxiliar3 
			(
			 IdDetalleRecepcion INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdDetalleRecepcion) ON [PRIMARY]

CREATE TABLE #Auxiliar4 
			(
			 TipoCompra VARCHAR(2),
			 IdDetallePedido INTEGER,
			 IdPedido INTEGER
			)

CREATE TABLE #Auxiliar5 
			(
			 TipoCompra VARCHAR(2),
			 IdPedido INTEGER
			)

CREATE TABLE #Auxiliar6 
			(
			 TipoCompra VARCHAR(2),
			 IdDetalleRequerimiento INTEGER,
			 IdRequerimiento INTEGER
			)

CREATE TABLE #Auxiliar7 
			(
			 TipoCompra VARCHAR(2),
			 IdRequerimiento INTEGER
			)

INSERT INTO #Auxiliar2 
 SELECT Det.IdDetallePedido, Det.IdDetalleRequerimiento --Case When IsNull(DetalleRequerimientos.IdDioPorCumplido,0)=0 Then Det.IdDetalleRequerimiento Else Null End
 FROM DetallePedidos Det
 LEFT OUTER JOIN Pedidos ON Det.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN DetalleRequerimientos ON Det.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(Det.Cumplido,'NO')<>'AN' and (@IdObra=-1 or Requerimientos.IdObra=@IdObra) and Pedidos.FechaPedido Between @Desde And @Hasta

-- Agregar RM que no tienen pedido y su estado es CMP (liberadas para compra)
INSERT INTO #Auxiliar2 
 SELECT 0, dr.IdDetalleRequerimiento
 FROM DetalleRequerimientos dr
 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(dr.Cumplido,'NO')<>'AN' and IsNull(Requerimientos.Cumplido,'NO')<>'AN' and IsNull(Requerimientos.Confirmado,'SI')='SI' and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and (Requerimientos.FechaRequerimiento Between @Desde And @Hasta) and 
	IsNull(dr.TipoDesignacion,'')='CMP' and 
	Not Exists(Select Top 1 Det1.IdDetallePedido From DetallePedidos Det1 Where Det1.IdDetalleRequerimiento = dr.IdDetalleRequerimiento) and
	Not Exists(Select Top 1 Det2.IdDetalleRequerimiento From DetalleRecepciones Det2 Where Det2.IdDetalleRequerimiento = dr.IdDetalleRequerimiento) and
	IsNull(dr.IdDioPorCumplido,0)=0

/*  CURSOR  */
DECLARE @IdDetallePedido int, @IdDetalleRecepcion int, @Renglon int, @IdDetalleRequerimiento int

DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido, IdDetalleRequerimiento FROM #Auxiliar2 ORDER BY IdDetallePedido
OPEN Cur1
FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
   BEGIN
	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 
	 SELECT Det.IdDetalleRecepcion
	 FROM DetalleRecepciones Det
	 LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=Det.IdRecepcion
	 WHERE Det.IdDetallePedido=@IdDetallePedido and IsNull(Recepciones.Anulada,'')<>'SI'

	SET @Renglon=1

	IF IsNull((Select Count(*) From #Auxiliar3),0)>0
	   BEGIN
		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRecepcion FROM #Auxiliar3 ORDER BY IdDetalleRecepcion
		OPEN Cur2
		FETCH NEXT FROM Cur2 INTO @IdDetalleRecepcion
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			INSERT INTO #Auxiliar1 
			(IdDetallePedido, IdDetalleRecepcion, IdDetalleRequerimiento, Renglon)
			VALUES
			(@IdDetallePedido, @IdDetalleRecepcion, @IdDetalleRequerimiento, @Renglon)

			SET @Renglon=@Renglon+1

			FETCH NEXT FROM Cur2 INTO @IdDetalleRecepcion
		   END
		CLOSE Cur2
		DEALLOCATE Cur2
	   END
	ELSE
	   BEGIN
		INSERT INTO #Auxiliar1 
		(IdDetallePedido, IdDetalleRecepcion, IdDetalleRequerimiento, Renglon)
		VALUES
		(@IdDetallePedido, Null, @IdDetalleRequerimiento, 1)
	   END

	FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @IdDetalleRequerimiento
   END
CLOSE Cur1
DEALLOCATE Cur1


INSERT INTO #Auxiliar4 
 SELECT DISTINCT TiposCompra.Modalidad, #Auxiliar1.IdDetallePedido, DetallePedidos.IdPedido
 FROM #Auxiliar1
 LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido = #Auxiliar1.IdDetallePedido
 LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento = #Auxiliar1.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetalleRequerimientos.IdRequerimiento
 LEFT OUTER JOIN TiposCompra ON TiposCompra.IdTipoCompra = Requerimientos.IdTipoCompra

INSERT INTO #Auxiliar5 
 SELECT DISTINCT TipoCompra, IdPedido
 FROM #Auxiliar4
 WHERE IsNull(IdPedido,0)>0


INSERT INTO #Auxiliar6 
 SELECT DISTINCT TiposCompra.Modalidad, #Auxiliar1.IdDetalleRequerimiento, DetalleRequerimientos.IdRequerimiento
 FROM #Auxiliar1
 LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento = #Auxiliar1.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetalleRequerimientos.IdRequerimiento
 LEFT OUTER JOIN TiposCompra ON TiposCompra.IdTipoCompra = Requerimientos.IdTipoCompra
 WHERE IsNull(#Auxiliar1.IdDetalleRequerimiento,0)>0

INSERT INTO #Auxiliar7 
 SELECT DISTINCT TipoCompra, IdRequerimiento
 FROM #Auxiliar6
 WHERE IsNull(IdRequerimiento,0)>0

SET NOCOUNT OFF

IF @Formato=''
	SELECT 
	 #Auxiliar1.Renglon as [Renglon],
	 Substring('00000000',1,8-Len(Convert(varchar,Requerimientos.NumeroRequerimiento)))+Convert(varchar,Requerimientos.NumeroRequerimiento) as [Numero_RM],
	 DetalleRequerimientos.NumeroItem as [NumeroItem_RM],
	 Requerimientos.FechaRequerimiento as [Fecha_RM],
	 Requerimientos.FechaAprobacion as [FechaLiberacion_RM],
	 Requerimientos.Detalle as [Detalle_RM],
	 E1.Nombre as [Solicito_RM],
	 DetalleRequerimientos.FechaEntrega as [FechaEntrega_RM],
	 DetalleRequerimientos.FechaLiberacionParaCompras as [FechaLiberacionParaCompras],
	 (Select Top 1 au.FechaAutorizacion From AutorizacionesPorComprobante au 
		Where au.IdFormulario=3 and au.IdComprobante=Requerimientos.IdRequerimiento Order By au.OrdenAutorizacion Desc) as [FechaUltimaFirma],
	 Rubros.Descripcion as [Rubro],
	 Subrubros.Descripcion as [Subrubro],
	 A1.Codigo as [Codigo],
	 A1.Descripcion+' '+Convert(varchar(3000),IsNull(DetalleRequerimientos.Observaciones,'')) as [Material],
	 Unidades.Abreviatura as [Unidad],
	 DetalleRequerimientos.Cantidad as [Cantidad_RM],
	 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Numero_PE],
	 DetallePedidos.NumeroItem as [NumeroItem_PE],
	 DetallePedidos.Cantidad as [Cantidad_PE],
	 DetallePedidos.Cumplido as [Cumplido_PE],
	 Proveedores.RazonSocial as [Proveedor],
	 Pedidos.FechaPedido as [Fecha_PE],
	 Pedidos.FechaAprobacion as [FechaLiberacion_PE],
	 (Select Top 1 au.FechaAutorizacion From AutorizacionesPorComprobante au Where au.IdFormulario=4 and au.IdComprobante=Pedidos.IdPedido and au.OrdenAutorizacion=1) as [FechaFirma1_PE],
	 (Select Top 1 au.FechaAutorizacion From AutorizacionesPorComprobante au Where au.IdFormulario=4 and au.IdComprobante=Pedidos.IdPedido and au.OrdenAutorizacion=2) as [FechaFirma2_PE],
	 (Select Top 1 au.FechaAutorizacion From AutorizacionesPorComprobante au Where au.IdFormulario=4 and au.IdComprobante=Pedidos.IdPedido and au.OrdenAutorizacion=3) as [FechaFirma3_PE],
	 Pedidos.FechaEnvioProveedor as [FechaEnvioProveedor_PE],
	 E2.Nombre as [Aprobo_PE],
	 cc.Codigo as [CodigoCondicionPago],
	 cc.Descripcion as [DescripcionCondicionPago],
	 DetallePedidos.FechaEntrega as [FechaEntrega_PE],
	 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
	 Monedas.Abreviatura as [Moneda],
	 DetallePedidos.Precio*IsNull(Pedidos.CotizacionMoneda,1) as [Precio],
	 DetallePedidos.Precio as [Precio2],
	 DetallePedidos.Cantidad*DetallePedidos.Precio*IsNull(Pedidos.CotizacionMoneda,1) as [Importe],
	 ((DetallePedidos.Cantidad*DetallePedidos.Precio)-IsNull(DetallePedidos.ImporteBonificacion,0)) as [Importe2],
	 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+
		IsNull(' / '+Convert(varchar,Recepciones.SubNumero),'') as [Numero_RE],
	 Recepciones.FechaRecepcion as [Fecha_RE],
	 E3.Nombre as [Realizo_RE],
	 DetalleRecepciones.Cantidad as [Cantidad_RE],
	 Case When Recepciones.FechaRecepcion is not null Then Datediff(day,Recepciones.FechaRecepcion,DetalleRequerimientos.FechaEntrega) Else Null End as [DiasCumplimiento],
	 Case When Recepciones.FechaRecepcion is not null Then Datediff(day,Recepciones.FechaRecepcion,DetallePedidos.FechaEntrega) Else Null End as [DiasEntrega],
	 Datediff(day,Pedidos.FechaPedido,DetalleRequerimientos.FechaLiberacionParaCompras) as [DiasGestionNP],
	 Datediff(day,DetalleRequerimientos.FechaLiberacionParaCompras,Requerimientos.FechaRequerimiento) as [DiasGestionRM],
	 Case When Recepciones.FechaRecepcion is not null Then Datediff(day,Recepciones.FechaRecepcion,DetalleRequerimientos.FechaLiberacionParaCompras)  Else Null End as [DiasGestionRE],
	 DetalleRequerimientos.IdRequerimiento,
	 DetallePedidos.IdPedido,
	 DetalleRecepciones.IdRecepcion,
	 IsNull(Requerimientos.TipoRequerimiento,'')+
		Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP' Then IsNull(' - '+A2.NumeroInventario,'')
			When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST' Then Convert(varchar,IsNull(' - '+ot.NumeroOrdenTrabajo,''))
			Else ''
		End as [TipoRequerimiento],
	 TiposCompra.Modalidad as [TipoCompra],
	 Case When IsNull(DetallePedidos.IdDetallePedido,0)=0 and Exists(Select Top 1 dvs.IdDetalleValeSalida From DetalleValesSalida dvs Where dvs.IdDetalleRequerimiento=#Auxiliar1.IdDetalleRequerimiento) Then 'SI' Else '' End as [SinPedidoConVale],
	 Case When IsNull((Select Top 1 drls.Situacion From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=#Auxiliar1.IdDetalleRequerimiento Order By Fecha Desc),'A')='A' Then 'A' Else 'I' End as [Situacion],
	 Case When IsNull((Select Top 1 drls.Situacion From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=#Auxiliar1.IdDetalleRequerimiento and IsNull(drls.CambioSituacion,'SI')='SI' Order By Fecha Desc),'')='A'  
		Then (Select Top 1 drls.Fecha From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=#Auxiliar1.IdDetalleRequerimiento and IsNull(drls.CambioSituacion,'SI')='SI' Order By Fecha Desc) 
		Else Null
	 End as [FechaActivacion],
	 Case When IsNull((Select Top 1 drls.Situacion From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=#Auxiliar1.IdDetalleRequerimiento and IsNull(drls.CambioSituacion,'SI')='SI' Order By Fecha Desc),'')='I'  
		Then (Select Top 1 drls.Fecha From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=#Auxiliar1.IdDetalleRequerimiento and IsNull(drls.CambioSituacion,'SI')='SI' Order By Fecha Desc) 
		Else Null
	 End as [FechaInactivacion]
	FROM #Auxiliar1
	LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido = #Auxiliar1.IdDetallePedido
	LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
	LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento = #Auxiliar1.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetalleRequerimientos.IdRequerimiento
	LEFT OUTER JOIN DetalleRecepciones ON DetalleRecepciones.IdDetalleRecepcion = #Auxiliar1.IdDetalleRecepcion
	LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = DetalleRecepciones.IdRecepcion
	LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = IsNull(DetallePedidos.IdArticulo,DetalleRequerimientos.IdArticulo)
	LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetalleRequerimientos.IdEquipoDestino
	LEFT OUTER JOIN Rubros ON Rubros.IdRubro = A1.IdRubro
	LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro = A1.IdSubrubro
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetalleRequerimientos.IdUnidad
	LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Pedidos.IdProveedor
	LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra = Pedidos.IdCondicionCompra
	LEFT OUTER JOIN Obras ON Obras.IdObra = Requerimientos.IdObra
	LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Pedidos.IdMoneda
	LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.IdSolicito
	LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Pedidos.Aprobo
	LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado = Recepciones.Realizo
	LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
	LEFT OUTER JOIN TiposCompra ON TiposCompra.IdTipoCompra = Requerimientos.IdTipoCompra
	WHERE (@SoloConEntregasExcedentes='' or
			(IsNull((Select Sum(IsNull(dr.Cantidad,0)) From DetalleRecepciones dr 
						Left Outer Join Recepciones r On r.IdRecepcion=dr.IdRecepcion
						Where dr.IdDetallePedido=#Auxiliar1.IdDetallePedido and IsNull(r.Anulada,'')<>'SI'),0)>DetallePedidos.Cantidad and DetallePedidos.Cantidad>=0)) and 
			(@TiposCompra='' or Patindex('%('+IsNull(TiposCompra.Modalidad,'XX')+')%', @TiposCompra)<>0)
	ORDER BY [Numero_PE], [NumeroItem_PE], [Renglon]

IF @Formato='PEDIDOS_CANTIDAD'
	SELECT TipoCompra as [TipoCompra], count(*) as [CantidadPedidos]
	FROM #Auxiliar5
	WHERE (@TiposCompra='' or Patindex('%('+IsNull(TipoCompra,'XX')+')%', @TiposCompra)<>0)
	GROUP BY TipoCompra
	ORDER BY TipoCompra

IF @Formato='PEDIDOS_IMPORTES'
	SELECT 
	 #Auxiliar4.TipoCompra as [TipoCompra], 
	 Case When Pedidos.IdMoneda=@IdMonedaPesos Then 'P' When Pedidos.IdMoneda=@IdMonedaDolar Then 'D' When Pedidos.IdMoneda=@IdMonedaEuro Then 'E' Else '' End as [Moneda], 
	 Sum((DetallePedidos.Cantidad*DetallePedidos.Precio)-IsNull(DetallePedidos.ImporteBonificacion,0)) as [Importe]
	FROM #Auxiliar4
	LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido = #Auxiliar4.IdDetallePedido
	LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
	WHERE IsNull(#Auxiliar4.IdDetallePedido,0)>0 and (@TiposCompra='' or Patindex('%('+IsNull(#Auxiliar4.TipoCompra,'XX')+')%', @TiposCompra)<>0)
	GROUP BY #Auxiliar4.TipoCompra, Pedidos.IdMoneda
	ORDER BY #Auxiliar4.TipoCompra, [Moneda]

IF @Formato='RM_CANTIDAD'
	SELECT TipoCompra as [TipoCompra], count(*) as [CantidadRequerimientos]
	FROM #Auxiliar7
	WHERE (@TiposCompra='' or Patindex('%('+IsNull(TipoCompra,'XX')+')%', @TiposCompra)<>0)
	GROUP BY TipoCompra
	ORDER BY TipoCompra

IF @Formato='RM_ITEMS_CANTIDAD'
	SELECT TipoCompra as [TipoCompra], count(*) as [CantidadItemsRequerimientos]
	FROM #Auxiliar6
	WHERE (@TiposCompra='' or Patindex('%('+IsNull(TipoCompra,'XX')+')%', @TiposCompra)<>0)
	GROUP BY TipoCompra
	ORDER BY TipoCompra

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7