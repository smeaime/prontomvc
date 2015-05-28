CREATE Procedure [dbo].[Articulos_TX_CostosPorEquipo]

@Desde datetime,
@Hasta datetime,
@IdEquipo int,
@MostrarCostos varchar(2) = Null,
@IdTransportista int = Null,
@Orden varchar(1) = Null

AS 

SET NOCOUNT ON

SET @MostrarCostos=IsNull(@MostrarCostos,'')
SET @IdTransportista=IsNull(@IdTransportista,-1)
SET @Orden=IsNull(@Orden,'E')

DECLARE @EstaProntoMantenimiento int, @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)
SET @EstaProntoMantenimiento=ISNULL(DB_ID('ProntoMantenimiento'),0)
--SET @EstaProntoMantenimiento=0

CREATE TABLE #Auxiliar0 
			(
			 IdArticulo INTEGER, 
			 NumeroInventario VARCHAR(20), 
			 Descripcion VARCHAR(256),
			 IdTransportista INTEGER, 
			)
IF @EstaProntoMantenimiento>0 
    BEGIN
	SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento From Parametros P Where P.IdParametro=1),'')
	SET @sql1='Select A.IdArticulo, A.NumeroInventario, A.Descripcion, IsNull(A.IdTransportista,0) From '+@BasePRONTOMANT+'.dbo.Articulos A'
	INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
    END
ELSE
    BEGIN
	INSERT INTO #Auxiliar0
	 SELECT A.IdArticulo, A.NumeroInventario, A.Descripcion, IsNull(A.IdTransportista,0)
	 FROM Articulos A
    END

CREATE TABLE #Auxiliar1
			(
			 IdEquipo INTEGER,
			 Insumo VARCHAR(256),
			 Codigo VARCHAR(20), 
			 Tipo VARCHAR(11),
			 Numero VARCHAR(13),
			 Descripcion VARCHAR(50),
			 Fecha DATETIME,
			 FechaImputacion DATETIME,
			 Cantidad NUMERIC(18, 2),
			 IdUnidad INTEGER,
			 Costo NUMERIC(18, 4),
			 Importe NUMERIC(18, 2),
			 Observaciones VARCHAR(1000),
			 Detalle VARCHAR(30),
			 DestinoCalles VARCHAR(50)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Det.IdEquipoDestino,
  Articulos.Descripcion,
  Articulos.Codigo,
  Case  When SalidasMateriales.TipoSalida=0 Then 'SAL.FAB.'
	When SalidasMateriales.TipoSalida=1 Then 'SAL.OBRA'
	When SalidasMateriales.TipoSalida=2 Then 'A PROVEEDOR'
	Else Substring(IsNull(SalidasMateriales.ClaveTipoSalida,''),1,10)
  End,
  Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),
  OT.Descripcion,
  SalidasMateriales.FechaSalidaMateriales,
  IsNull(Det.FechaImputacion,SalidasMateriales.FechaSalidaMateriales),
  Det.Cantidad,
  Det.IdUnidad,
  IsNull(Det.CostoUnitario,0) * IsNull(Det.CotizacionMoneda,0),
  IsNull(Det.Cantidad,0) * IsNull(Det.CostoUnitario,0) * IsNull(Det.CotizacionMoneda,0),
  Convert(varchar(1000),IsNull(Det.Observaciones,'')),
  IsNull(SalidasMateriales.Detalle,''),
  Substring(IsNull(C1.Nombre,'')+IsNull(' entre '+C2.Nombre,'')+IsNull(' y '+C3.Nombre,''),1,50)
 FROM DetalleSalidasMateriales Det
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN DetalleValesSalida ON DetalleValesSalida.IdDetalleValeSalida=Det.IdDetalleValeSalida
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
 LEFT OUTER JOIN OrdenesTrabajo OT ON OT.IdOrdenTrabajo = IsNull(Det.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo)
 LEFT OUTER JOIN #Auxiliar0 ON Det.IdEquipoDestino = #Auxiliar0.IdArticulo
 LEFT OUTER JOIN Calles C1 ON SalidasMateriales.IdCalle1 = C1.IdCalle
 LEFT OUTER JOIN Calles C2 ON SalidasMateriales.IdCalle2 = C2.IdCalle
 LEFT OUTER JOIN Calles C3 ON SalidasMateriales.IdCalle3 = C3.IdCalle
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	Det.IdEquipoDestino is not null and 
	(@IdEquipo=-1 or Det.IdEquipoDestino=@IdEquipo) and 
	(@IdTransportista=-1 or #Auxiliar0.IdTransportista=@IdTransportista) and 
	IsNull(Det.FechaImputacion,SalidasMateriales.FechaSalidaMateriales) between @Desde and @Hasta

UNION ALL

 SELECT 
  Det.IdEquipoDestino,
  Articulos.Descripcion,
  Articulos.Codigo,
  'OTR.ING.',
  '0000'+'-'+Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen),
  OT.Descripcion,
  OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,
  OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,
  Det.Cantidad * -1,
  Det.IdUnidad,
  IsNull(Det.CostoUnitario,0),
  IsNull(Det.Cantidad,0) * IsNull(Det.CostoUnitario,0) * -1,
  Convert(varchar(1000),IsNull(Det.Observaciones,'')),
  '',
  ''
 FROM DetalleOtrosIngresosAlmacen Det
 LEFT OUTER JOIN OtrosIngresosAlmacen ON Det.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN OrdenesTrabajo OT ON OT.IdOrdenTrabajo = Det.IdOrdenTrabajo
 LEFT OUTER JOIN #Auxiliar0 ON Det.IdEquipoDestino = #Auxiliar0.IdArticulo
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
	Det.IdEquipoDestino is not null and 
	(@IdEquipo=-1 or Det.IdEquipoDestino=@IdEquipo) and 
	(@IdTransportista=-1 or #Auxiliar0.IdTransportista=@IdTransportista) and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen between @Desde and @Hasta

IF @EstaProntoMantenimiento<>0
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 
	  (Select Top 1 Articulos.IdArticulo From Articulos Where Articulos.NumeroInventario=art.NumeroInventario),
	  art1.Descripcion,
	  art1.Codigo,
	  'CONS.MANT.',
	  Substring('00000000',1,8-Len(Convert(varchar,con.NumeroConsumo)))+Convert(varchar,con.NumeroConsumo),
	  Null,
	  con.FechaConsumo,
	  con.FechaConsumo,
	  DetCon.Cantidad,
	  DetCon.IdUnidadConsumible,
	  IsNull(DetCon.Costo,0),
	  IsNull(DetCon.Cantidad,0) * IsNull(DetCon.Costo,0),
	  '',
	  '',
          ''
	 FROM ProntoMantenimiento.dbo.DetalleConsumos DetCon
	 LEFT OUTER JOIN ProntoMantenimiento.dbo.Consumos con ON DetCon.IdConsumo = con.IdConsumo
	 LEFT OUTER JOIN ProntoMantenimiento.dbo.Articulos art ON DetCon.IdArticulo = art.IdArticulo
	 LEFT OUTER JOIN ProntoMantenimiento.dbo.Articulos art1 ON DetCon.IdConsumible = art1.IdArticulo
	 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdArticulo=(Select Top 1 Articulos.IdArticulo From Articulos Where Articulos.NumeroInventario=art.NumeroInventario)
	 WHERE art.NumeroInventario is not null and 
		DetCon.IdDetalleSalidaMaterialesPRONTO is null and 
		(@IdEquipo=-1 or DetCon.IdArticulo=@IdEquipo) and 
		(@IdTransportista=-1 or #Auxiliar0.IdTransportista=@IdTransportista) and 
		con.FechaConsumo between @Desde and @Hasta and 
		Exists(Select Top 1 Articulos.IdArticulo From Articulos Where Articulos.NumeroInventario=art.NumeroInventario)
	
	 UNION ALL
	
	 SELECT 
	  (Select Top 1 Articulos.IdArticulo From Articulos Where Articulos.NumeroInventario=art.NumeroInventario),
	  art1.Descripcion,
	  art1.Codigo,
	  'CONS.OT',
	  Substring('00000000',1,8-Len(Convert(varchar,OT.NumeroOrdenTrabajo)))+Convert(varchar,OT.NumeroOrdenTrabajo),
	  Null,
	  OT.FechaOrdenTrabajo,
	  OT.FechaOrdenTrabajo,
	  DetOTC.Cantidad,
	  DetOTC.IdUnidad,
	  IsNull(DetOTC.Costo,0),
	  IsNull(DetOTC.Cantidad,0) * IsNull(DetOTC.Costo,0),
	  '',
	  '',
          ''
	 FROM ProntoMantenimiento.dbo.DetalleOrdenesTrabajoConsumos DetOTC
	 LEFT OUTER JOIN ProntoMantenimiento.dbo.DetalleOrdenesTrabajo DetOT ON DetOTC.IdDetalleOrdenTrabajo = DetOT.IdDetalleOrdenTrabajo
	 LEFT OUTER JOIN ProntoMantenimiento.dbo.OrdenesTrabajo OT ON DetOT.IdOrdenTrabajo = OT.IdOrdenTrabajo
	 LEFT OUTER JOIN ProntoMantenimiento.dbo.Articulos art ON OT.IdArticulo = art.IdArticulo
	 LEFT OUTER JOIN ProntoMantenimiento.dbo.Articulos art1 ON DetOTC.IdArticulo = art1.IdArticulo
	 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdArticulo=(Select Top 1 Articulos.IdArticulo From Articulos Where Articulos.NumeroInventario=art.NumeroInventario)
	 WHERE art.NumeroInventario is not null and 
		(@IdEquipo=-1 or OT.IdArticulo=@IdEquipo) and 
		(@IdTransportista=-1 or #Auxiliar0.IdTransportista=@IdTransportista) and 
		OT.FechaOrdenTrabajo between @Desde and @Hasta and 
		Exists(Select Top 1 Articulos.IdArticulo From Articulos Where Articulos.NumeroInventario=art.NumeroInventario) 
    END

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)

IF @Orden='E'
    BEGIN
	SET @vector_X='001111111111111661133'
	IF @MostrarCostos='NO'
		SET @vector_T='001C9C2A5524420993F00'
	ELSE
		SET @vector_T='001C9C2A5524420333F00'

	SELECT 
	 #Auxiliar1.IdEquipo as [K_IdEquipo],
	 1 as [K_Orden],
	 #Auxiliar0.NumeroInventario as [Nro.Inv.],
	 #Auxiliar0.Descripcion as [Equipo],
	 #Auxiliar0.Descripcion as [Equipo p/buscar],
	 #Auxiliar1.Insumo as [Insumo],
	 #Auxiliar1.Codigo as [Codigo],
	 #Auxiliar1.Observaciones as [Observaciones],
	 #Auxiliar1.Tipo as [Tipo],
	 #Auxiliar1.Numero as [Numero],
	 #Auxiliar1.Descripcion as [OT],
	 #Auxiliar1.Fecha as [Fecha],
	 #Auxiliar1.FechaImputacion as [Fecha imp.],
	 Case When #Auxiliar1.Cantidad is not Null Then #Auxiliar1.Cantidad Else Null End as [Cantidad],
	 Unidades.Abreviatura as [Un.],
	 Case When #Auxiliar1.Costo is not Null Then #Auxiliar1.Costo Else Null End as [Costo],
	 Case When #Auxiliar1.Importe is not Null Then #Auxiliar1.Importe Else Null End  as [Importe],
	 #Auxiliar1.Detalle as [Detalle],
	 #Auxiliar1.DestinoCalles as [Destino - Calles],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar1.IdEquipo = #Auxiliar0.IdArticulo
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = #Auxiliar1.IdUnidad
	
	UNION ALL
	
	SELECT 
	 #Auxiliar1.IdEquipo as [K_IdEquipo],
	 2 as [K_Orden],
	 Null as [Nro.Inv.],
	 Null as [Equipo],
	 #Auxiliar0.Descripcion as [Equipo p/buscar],
	 Null as [Insumo],
	 Null as [Codigo],
	 Null as [Observaciones],
	 Null as [Tipo],
	 ' TOTAL :' as [Numero],
	 Null as [OT],
	 Null as [Fecha],
	 Null as [Fecha imp.],
	 Null as [Cantidad],
	 Null as [Un.],
	 Null as [Costo],
	 SUM(Importe) as [Importe],
	 Null as [Detalle],
	 Null as [Destino - Calles],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar1.IdEquipo = #Auxiliar0.IdArticulo
	GROUP BY #Auxiliar1.IdEquipo, #Auxiliar0.Descripcion

	ORDER BY [K_IdEquipo], [K_Orden], [Insumo], [Fecha]
    END
ELSE
    BEGIN
	SET @vector_X='0001111111111111166133'
	IF @MostrarCostos='NO'
		SET @vector_T='0001C91C2A552442099300'
	ELSE
		SET @vector_T='0001C91C2A552442033300'

	SELECT 
	 #Auxiliar1.IdEquipo as [K_IdEquipo],
	 #Auxiliar0.IdTransportista as [K_IdTransportista],
	 1 as [K_Orden],
	 #Auxiliar0.NumeroInventario as [Nro.Inv.],
	 #Auxiliar0.Descripcion as [Equipo],
	 #Auxiliar0.Descripcion as [Equipo p/buscar],
	 Transportistas.RazonSocial as [Transportista],
	 #Auxiliar1.Insumo as [Insumo],
	 #Auxiliar1.Codigo as [Codigo],
	 #Auxiliar1.Observaciones as [Observaciones],
	 #Auxiliar1.Tipo as [Tipo],
	 #Auxiliar1.Numero as [Numero],
	 #Auxiliar1.Descripcion as [OT],
	 #Auxiliar1.Fecha as [Fecha],
	 #Auxiliar1.FechaImputacion as [Fecha imp.],
	 Case When #Auxiliar1.Cantidad is not Null Then #Auxiliar1.Cantidad Else Null End as [Cantidad],
	 Unidades.Abreviatura as [Un.],
	 Case When #Auxiliar1.Costo is not Null Then #Auxiliar1.Costo Else Null End as [Costo],
	 Case When #Auxiliar1.Importe is not Null Then #Auxiliar1.Importe Else Null End  as [Importe],
	 #Auxiliar1.Detalle as [Detalle],
	 #Auxiliar1.DestinoCalles as [Destino - Calles],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar1.IdEquipo = #Auxiliar0.IdArticulo
	LEFT OUTER JOIN Transportistas ON #Auxiliar0.IdTransportista = Transportistas.IdTransportista
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = #Auxiliar1.IdUnidad
	
	UNION ALL
	
	SELECT 
	 #Auxiliar1.IdEquipo as [K_IdEquipo],
	 #Auxiliar0.IdTransportista as [K_IdTransportista],
	 2 as [K_Orden],
	 Null as [Nro.Inv.],
	 Null as [Equipo],
	 #Auxiliar0.Descripcion as [Equipo p/buscar],
	 Transportistas.RazonSocial as [Transportista],
	 Null as [Insumo],
	 Null as [Codigo],
	 Null as [Observaciones],
	 Null as [Tipo],
	 Null as [Numero],
	 'TOTAL EQUIPO :' as [OT],
	 Null as [Fecha],
	 Null as [Fecha imp.],
	 Null as [Cantidad],
	 Null as [Un.],
	 Null as [Costo],
	 SUM(Importe) as [Importe],
	 Null as [Detalle],
	 Null as [Destino - Calles],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar1.IdEquipo = #Auxiliar0.IdArticulo
	LEFT OUTER JOIN Transportistas ON #Auxiliar0.IdTransportista = Transportistas.IdTransportista
	GROUP BY #Auxiliar0.IdTransportista, Transportistas.RazonSocial, #Auxiliar1.IdEquipo, #Auxiliar0.Descripcion

	UNION ALL
	
	SELECT 
	 999999 as [K_IdEquipo],
	 #Auxiliar0.IdTransportista as [K_IdTransportista],
	 2 as [K_Orden],
	 Null as [Nro.Inv.],
	 Null as [Equipo],
	 '' as [Equipo p/buscar],
	 Transportistas.RazonSocial as [Transportista],
	 Null as [Insumo],
	 Null as [Codigo],
	 Null as [Observaciones],
	 Null as [Tipo],
	 Null as [Numero],
	 'TOTAL TRANSPORTISTA :' as [OT],
	 Null as [Fecha],
	 Null as [Fecha imp.],
	 Null as [Cantidad],
	 Null as [Un.],
	 Null as [Costo],
	 SUM(Importe) as [Importe],
	 Null as [Detalle],
	 Null as [Destino - Calles],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar1.IdEquipo = #Auxiliar0.IdArticulo
	LEFT OUTER JOIN Transportistas ON #Auxiliar0.IdTransportista = Transportistas.IdTransportista
	GROUP BY #Auxiliar0.IdTransportista, Transportistas.RazonSocial

	ORDER BY [K_IdTransportista], [K_IdEquipo], [K_Orden], [Insumo], [Fecha]
    END

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1