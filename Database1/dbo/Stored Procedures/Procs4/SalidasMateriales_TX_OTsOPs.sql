CREATE Procedure [dbo].[SalidasMateriales_TX_OTsOPs]

@FechaDesde datetime, 
@FechaHasta datetime,
@Numero varchar(20),
@Tipo varchar(1),
@OT_OP varchar(2) = Null,
@ConOTs varchar(2) = Null,
@IdObra int = Null,
@Estado varchar(1) = Null

AS 

SET NOCOUNT ON

DECLARE @EstaProntoMantenimiento int, @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)
SET @EstaProntoMantenimiento=ISNULL(DB_ID('ProntoMantenimiento'),0)

CREATE TABLE #Auxiliar0 
			(
			 IdArticulo INTEGER, 
			 NumeroInventario VARCHAR(20), 
			 Descripcion VARCHAR(256)
			)
IF @EstaProntoMantenimiento>0 
    BEGIN
	SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento From Parametros P Where P.IdParametro=1),'')
	SET @sql1='Select A.IdArticulo, A.NumeroInventario, A.Descripcion From '+@BasePRONTOMANT+'.dbo.Articulos A'
	INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
    END
ELSE
    BEGIN
	INSERT INTO #Auxiliar0
	 SELECT A.IdArticulo, A.NumeroInventario, A.Descripcion
	 FROM Articulos A
    END

DECLARE @IdObraParaOTOP int, @DescartarTipoSalidaParaOTOP int
SET @IdObra=IsNull(@IdObra,-1)
--SET @IdObraParaOTOP=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='IdObraParaOTOP'),-1)
SET @IdObraParaOTOP=@IdObra
SET @DescartarTipoSalidaParaOTOP=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='DescartarTipoSalidaParaOTOP'),-1)
SET @OT_OP=IsNull(@OT_OP,'OT')
SET @ConOTs=IsNull(@ConOTs,'')
SET @Estado=IsNull(@Estado,'*')

CREATE TABLE #Auxiliar1 
			(
			 TipoSalida VARCHAR(30), 
			 TipoNumero VARCHAR(30), 
			 IdOrdenTrabajo INTEGER, 
			 FechaSalida DATETIME, 
			 NumeroSalida VARCHAR(15), 
			 IdArticulo INTEGER, 
			 Cantidad NUMERIC(18,2), 
			 Costo NUMERIC(18,2), 
			)
INSERT INTO #Auxiliar1
 SELECT 
  Case	When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
	When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
	When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
	Else SalidasMateriales.ClaveTipoSalida
  End,
  Case When @OT_OP='OP'
	Then 'OP - ' + 	Case When Det.IdEquipoDestino is not null or DetReq.IdEquipoDestino is not null
				Then IsNull((Select Top 1 A.NumeroInventario COLLATE Modern_Spanish_CI_AS From #Auxiliar0 A Where IsNull(Det.IdEquipoDestino,DetReq.IdEquipoDestino)=A.IdArticulo),'')
				Else IsNull((Select Top 1 A.NumeroInventario COLLATE Modern_Spanish_CI_AS From #Auxiliar0 A Where IsNull(oc.IdEquipoDestino,0)=A.IdArticulo),'')
			End + 
			Case When Len(IsNull(oc.NumeroOrdenTrabajo,''))<>0 
				Then ' / OT - ' +Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0)) --+ Substring('00000000',1,8-Len(Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))))+Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))
				Else ''
			End
	When @OT_OP='OT'
	 Then 'OT - ' + Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0)) --Substring('00000000',1,8-Len(Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))))+Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))
	Else ''
  End,
  IsNull(Det.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo),
  SalidasMateriales.FechaSalidaMateriales,
  Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),
  Det.IdArticulo,
  Case When SalidasMateriales.TipoSalida=2 
	Then Det.Cantidad*-1 
	Else Det.Cantidad 
  End,
  Det.CostoUnitario * IsNull(Det.CotizacionMoneda,1)
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleValesSalida ON DetalleValesSalida.IdDetalleValeSalida=Det.IdDetalleValeSalida
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
 LEFT OUTER JOIN OrdenesTrabajo oc ON oc.IdOrdenTrabajo = IsNull(Det.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo)
 WHERE SalidasMateriales.FechaSalidaMateriales between @FechaDesde and @FechaHasta and 
	IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(@DescartarTipoSalidaParaOTOP=-1 or IsNull(SalidasMateriales.TipoSalida,-1)<>@DescartarTipoSalidaParaOTOP) and 
	(IsNull(Det.IdEquipoDestino,DetReq.IdEquipoDestino) is not null or 
	 IsNull(Det.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo) is not null) and 
	(
	 (Len(Rtrim(@Numero))=0 and @OT_OP='OP' and 
	  IsNull((Select Top 1 A.NumeroInventario From #Auxiliar0 A Where IsNull(Det.IdEquipoDestino,DetReq.IdEquipoDestino)=A.IdArticulo),'')<>''
	 ) or 
	 (Len(Rtrim(@Numero))=0 and @OT_OP='OT' and Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,''))<>'') or 
	 (@Numero<>'' and @OT_OP='OP' and 
	  (IsNull((Select Top 1 A.NumeroInventario From #Auxiliar0 A Where IsNull(Det.IdEquipoDestino,DetReq.IdEquipoDestino)=A.IdArticulo),'')=@Numero or 
	   (@ConOTs='SI' and IsNull((Select Top 1 A.NumeroInventario From #Auxiliar0 A Where IsNull(oc.IdEquipoDestino,0)=A.IdArticulo),'')=@Numero))
	 ) or 
	 (@Numero<>'' and @OT_OP='OT' and Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))=@Numero)
	) and 
	(@Estado='*' or IsNull(oc.NumeroOrdenTrabajo,'')='' or (@Estado='A' and oc.FechaFinalizacion is null) or (@Estado='C' and oc.FechaFinalizacion is not null)) and
	(@IdObraParaOTOP<=0 or Det.IdObra=@IdObraParaOTOP) and 
	(@Tipo='*' or DetReq.MoP=@Tipo)

INSERT INTO #Auxiliar1
 SELECT 
  'Otros ingresos',
  Case When @OT_OP='OP'
	Then 'OP - ' + 	Case When Det.IdEquipoDestino is not null 
				Then IsNull((Select Top 1 A.NumeroInventario COLLATE Modern_Spanish_CI_AS From #Auxiliar0 A Where Det.IdEquipoDestino=A.IdArticulo),'')
				Else IsNull((Select Top 1 A.NumeroInventario COLLATE Modern_Spanish_CI_AS From #Auxiliar0 A Where oc.IdEquipoDestino=A.IdArticulo),'')
			End + 
			Case When IsNull(oc.NumeroOrdenTrabajo,0)<>0 
				Then ' / OT - ' +Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0)) --+ Substring('00000000',1,8-Len(Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))))+Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))
				Else ''
			End
	When @OT_OP='OT'
	 Then 'OT - ' +Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0)) --+ Substring('00000000',1,8-Len(Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))))+Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))
	Else ''
  End,
  Det.IdOrdenTrabajo,
  OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,
  '0000-'+Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen),
  Det.IdArticulo,
  Det.Cantidad*-1,
  Det.CostoUnitario
 FROM DetalleOtrosIngresosAlmacen Det
 LEFT OUTER JOIN OtrosIngresosAlmacen ON Det.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 LEFT OUTER JOIN OrdenesTrabajo oc ON oc.IdOrdenTrabajo = Det.IdOrdenTrabajo
 WHERE OtrosIngresosAlmacen.FechaOtroIngresoAlmacen between @FechaDesde and @FechaHasta and 
	IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
	(Det.IdEquipoDestino is not null or Det.IdOrdenTrabajo is not null) and 
	((Len(Rtrim(@Numero))=0 and @OT_OP='OP' and IsNull((Select Top 1 A.NumeroInventario From #Auxiliar0 A 
								Where Det.IdEquipoDestino=A.IdArticulo),'')<>'') or 
	 (Len(Rtrim(@Numero))=0 and @OT_OP='OT' and Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))<>0) or 
	 (@Numero<>'' and @OT_OP='OP' and 
	  (IsNull((Select Top 1 A.NumeroInventario From #Auxiliar0 A Where IsNull(Det.IdEquipoDestino,0)=A.IdArticulo),'')=@Numero or 
	   (@ConOTs='SI' and IsNull((Select Top 1 A.NumeroInventario From #Auxiliar0 A Where IsNull(oc.IdEquipoDestino,0)=A.IdArticulo),'')=@Numero))
	 ) or 
	 (@Numero<>'' and @OT_OP='OT' and Convert(varchar,IsNull(oc.NumeroOrdenTrabajo,0))=@Numero)) and 
	(@Estado='*' or IsNull(oc.NumeroOrdenTrabajo,'')='' or (@Estado='A' and oc.FechaFinalizacion is null) or (@Estado='C' and oc.FechaFinalizacion is not null)) and
	(@IdObraParaOTOP<=0 or Det.IdObra=@IdObraParaOTOP) 

SET NOCOUNT OFF

SELECT 
 #Auxiliar1.*, 
 Case When oc.IdOrdenTrabajo is not null Then oc.Descripcion Else '' End as [Descripcion],
 Case When oc.IdOrdenTrabajo is not null Then oc.TrabajosARealizar Else '' End as [Trabajos a realizar],
 Case When oc.IdOrdenTrabajo is not null Then oc.FechaInicio Else Null End as [Fecha inicio],
 Case When oc.IdOrdenTrabajo is not null Then oc.FechaEntrega Else Null End as [Fecha entrega], Case When oc.IdOrdenTrabajo is not null Then oc.FechaFinalizacion Else Null End as [Fecha finalizacion],
 Case When oc.IdOrdenTrabajo is not null Then oc.Observaciones Else Null End as [Observaciones],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Articulo],
 A1.AuxiliarString10 as [Ubicacion],
 A1.Codigo as [CodigoEquipoDestino],
 A1.Descripcion as [EquipoDestino],
 #Auxiliar1.Cantidad as [Cant.],
 #Auxiliar1.Costo as [CostoUnitario],
 #Auxiliar1.Cantidad*#Auxiliar1.Costo as [CostoTotal],
 Cuentas.Descripcion as [Cuenta],
 A2.Codigo as [CodigoEquipoDestino1],
 A2.Descripcion as [EquipoDestino1]
FROM #Auxiliar1
LEFT OUTER JOIN OrdenesTrabajo oc ON oc.IdOrdenTrabajo = #Auxiliar1.IdOrdenTrabajo
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo=oc.IdEquipoDestino
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=A1.IdCuentaCompras
ORDER BY #Auxiliar1.TipoNumero, #Auxiliar1.FechaSalida, #Auxiliar1.NumeroSalida, A1.Codigo

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1