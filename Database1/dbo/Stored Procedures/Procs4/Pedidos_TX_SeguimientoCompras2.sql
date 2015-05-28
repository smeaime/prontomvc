CREATE Procedure [dbo].[Pedidos_TX_SeguimientoCompras2]

@Desde datetime, 
@Hasta datetime, 
@IdObra int = Null, 
@IdArticulo int = Null, 
@NumeroPedido int = Null, 
@IdProveedor int = Null

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @NumeroPedido=IsNull(@NumeroPedido,-1)
SET @IdProveedor=IsNull(@IdProveedor,-1)

DECLARE @IdMonedaPesos int, @IdMonedaDolar int, @IdMonedaEuro int, @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @IdMonedaPesos=(Select Parametros.IdMoneda From Parametros Where Parametros.IdParametro=1)
SET @IdMonedaDolar=(Select Parametros.IdMonedaDolar From Parametros Where Parametros.IdParametro=1)
SET @IdMonedaEuro=(Select Parametros.IdMonedaEuro From Parametros Where Parametros.IdParametro=1)
SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 
			(
			 IdAux INTEGER IDENTITY (1, 1),
			 IdDetallePedido INTEGER,
			 IdDetalleRecepcion INTEGER,
			 IdDetalleRequerimiento INTEGER,
			 IdDetalleSalidaMateriales INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecibida NUMERIC(18,2),
			 CantidadEntregada NUMERIC(18,2),
			 Renglon INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdAux) ON [PRIMARY]
--IdDetalleValeSalida
CREATE TABLE #Auxiliar2 
			(
			 IdDetallePedido INTEGER,
			 IdDetalleRequerimiento INTEGER,
			 CantidadPedida NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdDetallePedido) ON [PRIMARY]

CREATE TABLE #Auxiliar3 
			(
			 IdDetalleRecepcion INTEGER,
			 CantidadRecibida NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdDetalleRecepcion) ON [PRIMARY]

CREATE TABLE #Auxiliar4 
			(
			 IdDetalleSalidaMateriales INTEGER,
			 CantidadEntregada NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdDetalleSalidaMateriales) ON [PRIMARY]

INSERT INTO #Auxiliar2 
 SELECT Det.IdDetallePedido, Det.IdDetalleRequerimiento, Det.Cantidad --Case When IsNull(DetalleRequerimientos.IdDioPorCumplido,0)=0 Then Det.IdDetalleRequerimiento Else Null End
 FROM DetallePedidos Det
 LEFT OUTER JOIN Pedidos ON Det.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN DetalleRequerimientos ON Det.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(Det.Cumplido,'NO')<>'AN' and 
		(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
		(@NumeroPedido<=0 or Pedidos.NumeroPedido=@NumeroPedido) and 
		(@IdProveedor<=0 or Pedidos.IdProveedor=@IdProveedor) and 
		Pedidos.FechaPedido Between @Desde And @Hasta

DECLARE @IdAux int, @IdDetallePedido int, @IdDetalleRecepcion int, @Renglon int, @IdDetalleRequerimiento int, @IdDetalleSalidaMateriales int, 
		@CantidadPedida numeric(18,2), @CantidadPedida2 numeric(18,2), @CantidadRecibida numeric(18,2), @CantidadEntregada numeric(18,2)

/*  Agrego las recepciones por cada IdDetallePedido  */
DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido, IdDetalleRequerimiento, CantidadPedida FROM #Auxiliar2 ORDER BY IdDetallePedido
OPEN Cur1
FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @IdDetalleRequerimiento, @CantidadPedida
WHILE @@FETCH_STATUS = 0
  BEGIN
	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 
	 SELECT Det.IdDetalleRecepcion, Det.Cantidad
	 FROM DetalleRecepciones Det
	 LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=Det.IdRecepcion
	 WHERE Det.IdDetallePedido=@IdDetallePedido and IsNull(Recepciones.Anulada,'')<>'SI'

	SET @Renglon=1

	IF IsNull((Select Count(*) From #Auxiliar3),0)>0
	  BEGIN
		SET @CantidadPedida2=@CantidadPedida
		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRecepcion, CantidadRecibida FROM #Auxiliar3 ORDER BY IdDetalleRecepcion
		OPEN Cur2
		FETCH NEXT FROM Cur2 INTO @IdDetalleRecepcion, @CantidadRecibida
		WHILE @@FETCH_STATUS = 0
		  BEGIN
			INSERT INTO #Auxiliar1 
			(IdDetallePedido, IdDetalleRecepcion, IdDetalleRequerimiento, CantidadPedida, CantidadRecibida, Renglon)
			VALUES
			(@IdDetallePedido, @IdDetalleRecepcion, @IdDetalleRequerimiento, @CantidadPedida2, @CantidadRecibida, @Renglon)

			SET @Renglon=@Renglon+1
			SET @CantidadPedida2=Null

			FETCH NEXT FROM Cur2 INTO @IdDetalleRecepcion, @CantidadRecibida
		  END
		CLOSE Cur2
		DEALLOCATE Cur2
	  END
	ELSE
	  BEGIN
		INSERT INTO #Auxiliar1 
		(IdDetallePedido, IdDetalleRecepcion, IdDetalleRequerimiento, CantidadPedida, Renglon)
		VALUES
		(@IdDetallePedido, Null, @IdDetalleRequerimiento, @CantidadPedida, 1)
	  END

	FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @IdDetalleRequerimiento, @CantidadPedida
  END
CLOSE Cur1
DEALLOCATE Cur1

/*  Agrego las salidas de materiales por cada IdDetalleRequerimiento  */
DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido, IdDetalleRequerimiento FROM #Auxiliar2 ORDER BY IdDetallePedido
OPEN Cur1
FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
  BEGIN
	TRUNCATE TABLE #Auxiliar4
	INSERT INTO #Auxiliar4 
	 SELECT DISTINCT dsm.IdDetalleSalidaMateriales, dsm.Cantidad
	 FROM DetalleValesSalida dvs 
	 LEFT OUTER JOIN DetalleSalidasMateriales dsm ON dsm.IdDetalleValeSalida=dvs.IdDetalleValeSalida
	 LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
	 WHERE IsNull(dvs.IdDetalleRequerimiento,0)>0 and (@IdDetalleRequerimiento=-1 or dvs.IdDetalleRequerimiento=@IdDetalleRequerimiento) and IsNull(SalidasMateriales.Anulada,'NO')<>'SI'

	IF IsNull((Select Count(*) From #Auxiliar4),0)>0
	  BEGIN
		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleSalidaMateriales, CantidadEntregada FROM #Auxiliar4 ORDER BY IdDetalleSalidaMateriales
		OPEN Cur2
		FETCH NEXT FROM Cur2 INTO @IdDetalleSalidaMateriales, @CantidadEntregada
		WHILE @@FETCH_STATUS = 0
		  BEGIN
			SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar1 Where IdDetallePedido=@IdDetallePedido and IdDetalleSalidaMateriales is Null Order By IdDetallePedido,Renglon),0)
			IF @IdAux=0
			  BEGIN
				SET @Renglon=IsNull((Select Top 1 Renglon From #Auxiliar1 Where IdDetallePedido=@IdDetallePedido Order By IdDetallePedido,Renglon Desc),0) + 1
				INSERT INTO #Auxiliar1 
				(IdDetallePedido, IdDetalleRecepcion, IdDetalleRequerimiento, IdDetalleSalidaMateriales, CantidadEntregada, Renglon)
				VALUES
				(@IdDetallePedido, Null, @IdDetalleRequerimiento, @IdDetalleSalidaMateriales, @CantidadEntregada, @Renglon)
			  END
			ELSE
				UPDATE #Auxiliar1
				SET IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales, CantidadEntregada=@CantidadEntregada
				WHERE IdAux=@IdAux

			FETCH NEXT FROM Cur2 INTO @IdDetalleSalidaMateriales, @CantidadEntregada
		  END
		CLOSE Cur2
		DEALLOCATE Cur2
	  END

	FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @IdDetalleRequerimiento
  END
CLOSE Cur1
DEALLOCATE Cur1

-- Busqueda de equipos destino --
CREATE TABLE #Auxiliar0 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdArticulo) ON [PRIMARY]

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
  BEGIN
	SET @sql1='Select Distinct a.IdArticulo, a.Descripcion, a.NumeroInventario 
				From #Auxiliar1
				Left Outer Join DetalleRequerimientos dr On dr.IdDetalleRequerimiento = #Auxiliar1.IdDetalleRequerimiento
				Left Outer Join Requerimientos On dr.IdRequerimiento = Requerimientos.IdRequerimiento
				Left Outer Join DetalleSalidasMateriales dsm On dsm.IdDetalleSalidaMateriales = #Auxiliar1.IdDetalleSalidaMateriales
				Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos a On a.IdArticulo = IsNull(dsm.IdEquipoDestino,IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino))
				Where a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar0 
	 SELECT DISTINCT a.IdArticulo, a.Descripcion, a.NumeroInventario
	 FROM #Auxiliar1
	 LEFT OUTER JOIN DetalleRequerimientos dr ON dr.IdDetalleRequerimiento = #Auxiliar1.IdDetalleRequerimiento
	 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN DetalleSalidasMateriales dsm ON dsm.IdDetalleSalidaMateriales = #Auxiliar1.IdDetalleSalidaMateriales
	 LEFT OUTER JOIN Articulos a ON a.IdArticulo = IsNull(dsm.IdEquipoDestino,IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino))
	 WHERE a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
  END

SET NOCOUNT OFF

/*
select a1.*, dp.Cantidad as [Pedido], dr.Cantidad as [Recibido], dsm.Cantidad  as [Entregado]
from #Auxiliar1 a1
left outer join DetallePedidos dp on dp.IdDetallePedido=a1.IdDetallePedido
left outer join DetalleRecepciones dr on dr.IdDetalleRecepcion=a1.IdDetalleRecepcion
left outer join DetalleSalidasMateriales dsm on dsm.IdDetalleSalidaMateriales=a1.IdDetalleSalidaMateriales
order by a1.IdDetallePedido,a1.Renglon
*/

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
 u1.Abreviatura as [Unidad_RM],
 DetalleRequerimientos.Cantidad as [Cantidad_RM],

 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
	IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Numero_PE],
 DetallePedidos.NumeroItem as [NumeroItem_PE],
 DetallePedidos.Cantidad as [Cantidad_PE],
 #Auxiliar1.CantidadPedida as [Cantidad2_PE],
 u2.Abreviatura as [Unidad_PE],
 DetallePedidos.Cumplido as [Cumplido_PE],
 Proveedores.RazonSocial as [Proveedor],
 Pedidos.FechaPedido as [Fecha_PE],
 Pedidos.FechaAprobacion as [FechaLiberacion_PE],
 DetallePedidos.FechaEntrega as [FechaEntrega_PE],
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
 Recepciones.NumeroRecepcionAlmacen as [NumeroRecepcionAlmacen_RE],
 Recepciones.FechaRecepcion as [Fecha_RE],
 E3.Nombre as [Realizo_RE],
 DetalleRecepciones.Cantidad as [Cantidad_RE],
 #Auxiliar1.CantidadRecibida as [Cantidad2_RE],
 u3.Abreviatura as [Unidad_RE],
 Case When Recepciones.FechaRecepcion is not null Then Datediff(day,Recepciones.FechaRecepcion,DetalleRequerimientos.FechaEntrega) Else Null End as [DiasCumplimiento],
 Case When Recepciones.FechaRecepcion is not null Then Datediff(day,Recepciones.FechaRecepcion,DetallePedidos.FechaEntrega) Else Null End as [DiasEntrega],
 Datediff(day,Pedidos.FechaPedido,DetalleRequerimientos.FechaLiberacionParaCompras) as [DiasGestionNP],
 Datediff(day,DetalleRequerimientos.FechaLiberacionParaCompras,Requerimientos.FechaRequerimiento) as [DiasGestionRM],
 Case When Recepciones.FechaRecepcion is not null Then Datediff(day,Recepciones.FechaRecepcion,DetalleRequerimientos.FechaLiberacionParaCompras)  Else Null End as [DiasGestionRE],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion_RE],

 Case  When SalidasMateriales.TipoSalida=0 Then 'SAL.FAB.'
	When SalidasMateriales.TipoSalida=1 Then 'SAL.OBRA'
	When SalidasMateriales.TipoSalida=2 Then 'A PROVEEDOR'
	Else Substring(IsNull(SalidasMateriales.ClaveTipoSalida,''),1,10)
 End as [Tipo_SM],
 Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Numero_SM],
 SalidasMateriales.FechaSalidaMateriales as [Fecha_SM],
 DetalleSalidasMateriales.Cantidad as [Cantidad_SM],
 #Auxiliar1.CantidadEntregada as [Cantidad2_SM],
 u4.Abreviatura as [Unidad_SM],
 IsNull(SalidasMateriales.Detalle,'') as [Detalle_SM],
 Substring(IsNull(c1.Nombre,'')+IsNull(' entre '+c2.Nombre,'')+IsNull(' y '+c3.Nombre,''),1,50) as [DestinoCalles_SM],
 DetalleSalidasMateriales.CostoUnitario * IsNull(DetalleSalidasMateriales.CotizacionMoneda,0) as [CostoUnitario_SM],
 #Auxiliar1.CantidadEntregada * IsNull(DetalleSalidasMateriales.CostoUnitario,0) * IsNull(DetalleSalidasMateriales.CotizacionMoneda,0) as [CostoTotal_SM],

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
 Case When DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion)<=0 
	Then DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion) * -1
	Else Null
 End as [DiasEnTermino],
 Case When DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion)>0 
	Then DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion)
	Else Null
 End as [DiasFueraTermino],
 ot.Descripcion as [Detalle_OT],
 #Auxiliar0.NumeroInventario+' '+#Auxiliar0.Descripcion as [EquipoDestino]
FROM #Auxiliar1
LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido = #Auxiliar1.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento = #Auxiliar1.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetalleRequerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleRecepciones ON DetalleRecepciones.IdDetalleRecepcion = #Auxiliar1.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = DetalleRecepciones.IdRecepcion
LEFT OUTER JOIN DetalleSalidasMateriales ON DetalleSalidasMateriales.IdDetalleSalidaMateriales = #Auxiliar1.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetalleSalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = IsNull(DetallePedidos.IdArticulo,DetalleRequerimientos.IdArticulo)
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetalleRequerimientos.IdEquipoDestino
LEFT OUTER JOIN Rubros ON Rubros.IdRubro = A1.IdRubro
LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro = A1.IdSubrubro
LEFT OUTER JOIN Unidades u1 ON u1.IdUnidad = DetalleRequerimientos.IdUnidad
LEFT OUTER JOIN Unidades u2 ON u2.IdUnidad = DetallePedidos.IdUnidad
LEFT OUTER JOIN Unidades u3 ON u3.IdUnidad = DetalleRecepciones.IdUnidad
LEFT OUTER JOIN Unidades u4 ON u4.IdUnidad = DetalleSalidasMateriales.IdUnidad
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Pedidos.IdProveedor
LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra = Pedidos.IdCondicionCompra
LEFT OUTER JOIN Obras ON Obras.IdObra = Requerimientos.IdObra
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Pedidos.IdMoneda
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.IdSolicito
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Pedidos.Aprobo
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado = Recepciones.Realizo
LEFT OUTER JOIN TiposCompra ON TiposCompra.IdTipoCompra = Requerimientos.IdTipoCompra
LEFT OUTER JOIN Ubicaciones ON DetalleRecepciones.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = IsNull(DetalleSalidasMateriales.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo)
LEFT OUTER JOIN Calles c1 ON c1.IdCalle = SalidasMateriales.IdCalle1
LEFT OUTER JOIN Calles c2 ON c2.IdCalle = SalidasMateriales.IdCalle2
LEFT OUTER JOIN Calles c3 ON c3.IdCalle = SalidasMateriales.IdCalle3
LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdArticulo = IsNull(DetalleSalidasMateriales.IdEquipoDestino,IsNull(DetalleRequerimientos.IdEquipoDestino,Requerimientos.IdEquipoDestino))
WHERE (@IdArticulo<=0 or DetallePedidos.IdArticulo=@IdArticulo) and 
		(@NumeroPedido<=0 or Pedidos.NumeroPedido=@NumeroPedido) and 
		(@IdProveedor<=0 or Pedidos.IdProveedor=@IdProveedor) 
ORDER BY [Numero_PE], [NumeroItem_PE], [Renglon]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
