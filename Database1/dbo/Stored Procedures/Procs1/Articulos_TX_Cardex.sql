CREATE Procedure [dbo].[Articulos_TX_Cardex]

@IdArticulo int,
@FechaDesde datetime, 
@FechaHasta datetime,
@CodigoDesde varchar(20),
@CodigoHasta varchar(20),
@IdObra1 int,
@IdDeposito1 int,
@IdUbicacion1 int,
@MostrarCosto varchar(2) = Null,
@Detallado varchar(2) = Null,
@RegistrosResumidos varchar(2) = Null,
@Descripcion varchar(300) = Null,
@SoloKits varchar(2) = Null

AS

SET NOCOUNT ON

SET @MostrarCosto=IsNull(@MostrarCosto,'SI')
SET @Detallado=IsNull(@Detallado,'SI')
SET @RegistrosResumidos=IsNull(@RegistrosResumidos,'NO')
SET @Descripcion=IsNull(@Descripcion,'*')
SET @SoloKits=IsNull(@SoloKits,'NO')

DECLARE @FechaArranqueMovimientosStock datetime, @DatosSalida varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50), @SistemaVentasPorTalle varchar(2)

SET @FechaArranqueMovimientosStock=IsNull((Select Top 1 FechaArranqueMovimientosStock From Parametros Where IdParametro=1),Convert(datetime,'01/01/1900'))
SET @DatosSalida=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						 Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						 Where pic.Clave='Mostrar datos de la salida en cardex' and IsNull(ProntoIni.Valor,'')='SI'),'')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')
SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

CREATE TABLE #Auxiliar501 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 datetime)
CREATE NONCLUSTERED INDEX IX__Auxiliar501 ON #Auxiliar501 (IdArticuloConjunto,FechaModificacion2,FechaModificacion Desc) ON [PRIMARY]
INSERT INTO #Auxiliar501 
 SELECT IdArticuloConjunto, FechaModificacion, FechaModificacion
 FROM ConjuntosVersiones

CREATE TABLE #Auxiliar502 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 datetime)
CREATE NONCLUSTERED INDEX IX__Auxiliar502 ON #Auxiliar502 (IdArticuloConjunto,FechaModificacion2 Desc) ON [PRIMARY]
INSERT INTO #Auxiliar502 
 SELECT IdArticuloConjunto, Max(FechaModificacion), FechaModificacion2
 FROM #Auxiliar501
 GROUP BY IdArticuloConjunto, FechaModificacion2

CREATE TABLE #Kits (IdArticulo INTEGER)
IF @SoloKits='SI'
	INSERT INTO #Kits 
	 SELECT DISTINCT IdArticulo
	 FROM Conjuntos
	 WHERE IsNull((Select Count(*) From DetalleConjuntos dc Where dc.IdConjunto=Conjuntos.IdConjunto),0)>0

CREATE TABLE #Auxiliar0 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
IF Len(@BasePRONTOMANT)>0
	SET @sql1='Select A.IdArticulo, A.Descripcion, A.NumeroInventario From '+@BasePRONTOMANT+'.dbo.Articulos A'
ELSE
	SET @sql1='Select A.IdArticulo, A.Descripcion, A.NumeroInventario From Articulos A'
INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1

CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Orden INTEGER,
			 Fecha DATETIME,
			 Documento VARCHAR(20),
			 Numero INTEGER,
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdDetalleRequerimiento INTEGER,
			 Observaciones VARCHAR(150),
			 NumeroCaja INTEGER,
			 IdEquipoDestino INTEGER,
			 Talle VARCHAR(2),
			 IdColor INTEGER,
			 Entidad VARCHAR(100)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticulo,Fecha,Orden,Documento,Numero,Cantidad) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  DetalleAjustesStock.IdArticulo,
  106,
  DetalleAjustesStock.IdAjusteStock,
  1,
  AjustesStock.FechaAjuste,
  Case When DetalleAjustesStock.IdDetalleSalidaMateriales is not null Then 'SM - Trasvaso -' Else 'Ajuste -' End,
  AjustesStock.NumeroAjusteStock,
  DetalleAjustesStock.IdUbicacion,
  DetalleAjustesStock.IdObra,
  DetalleAjustesStock.CantidadUnidades,
  DetalleAjustesStock.IdUnidad,
  DetalleAjustesStock.Partida,
  Null,
  Substring(Convert(Varchar,IsNull(DetalleAjustesStock.Observaciones,'')),1,150),
  DetalleAjustesStock.NumeroCaja,
  Null,
  DetalleAjustesStock.Talle,
  DetalleAjustesStock.IdColor,
  ''
 FROM DetalleAjustesStock
 LEFT OUTER JOIN AjustesStock ON DetalleAjustesStock.IdAjusteStock = AjustesStock.IdAjusteStock
 LEFT OUTER JOIN Articulos ON DetalleAjustesStock.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleAjustesStock.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN #Kits ON #Kits.IdArticulo = DetalleAjustesStock.IdArticulo
 WHERE (@IdArticulo=-1 or 
		(@IdArticulo>0 and DetalleAjustesStock.IdArticulo=@IdArticulo) or 
		(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		AjustesStock.FechaAjuste between @FechaArranqueMovimientosStock and @FechaHasta and 
		DetalleAjustesStock.CantidadUnidades<0 and IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleAjustesStock.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleAjustesStock.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		(@SoloKits<>'SI' or IsNull(#Kits.IdArticulo,0)>0)

 UNION ALL

 SELECT 
  DetalleAjustesStock.IdArticulo,
  106,
  DetalleAjustesStock.IdAjusteStock,
  2,
  AjustesStock.FechaAjuste,
  Case When DetalleAjustesStock.IdDetalleSalidaMateriales is not null Then 'SM - Trasvaso +' Else 'Ajuste +' End,
  AjustesStock.NumeroAjusteStock,
  DetalleAjustesStock.IdUbicacion,
  DetalleAjustesStock.IdObra,
  DetalleAjustesStock.CantidadUnidades,
  DetalleAjustesStock.IdUnidad,
  DetalleAjustesStock.Partida,
  Null,
  Substring(Convert(Varchar,IsNull(DetalleAjustesStock.Observaciones,'')),1,150),
  DetalleAjustesStock.NumeroCaja,
  Null,
  DetalleAjustesStock.Talle,
  DetalleAjustesStock.IdColor,
  ''
 FROM DetalleAjustesStock
 LEFT OUTER JOIN AjustesStock ON DetalleAjustesStock.IdAjusteStock = AjustesStock.IdAjusteStock
 LEFT OUTER JOIN Articulos ON DetalleAjustesStock.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleAjustesStock.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN #Kits ON #Kits.IdArticulo = DetalleAjustesStock.IdArticulo
 WHERE (@IdArticulo=-1 or 
		(@IdArticulo>0 and DetalleAjustesStock.IdArticulo=@IdArticulo) or 
		(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		AjustesStock.FechaAjuste between @FechaArranqueMovimientosStock and @FechaHasta and 
		DetalleAjustesStock.CantidadUnidades>=0 and IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleAjustesStock.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleAjustesStock.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		(@SoloKits<>'SI' or IsNull(#Kits.IdArticulo,0)>0)

 UNION ALL

 SELECT
  DetalleSalidasMateriales.IdArticulo,
  50,
  DetalleSalidasMateriales.IdSalidaMateriales,
  7,
  SalidasMateriales.FechaSalidaMateriales,
  Case When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
	When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
	When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
	Else Substring(IsNull(SalidasMateriales.ClaveTipoSalida,''),1,20)
  End,
  SalidasMateriales.NumeroSalidaMateriales,
  DetalleSalidasMateriales.IdUbicacion,
  DetalleSalidasMateriales.IdObra,
  DetalleSalidasMateriales.Cantidad * -1,
  DetalleSalidasMateriales.IdUnidad,
  DetalleSalidasMateriales.Partida,
  DetalleValesSalida.IdDetalleRequerimiento,
  Substring(IsNull('Obra destino : '+Obras.NumeroObra+' - '+Obras.Descripcion+'  ','')+Convert(Varchar,IsNull(DetalleSalidasMateriales.Observaciones,'')),1,150),
  DetalleSalidasMateriales.NumeroCaja,
  DetalleSalidasMateriales.IdEquipoDestino,
  DetalleSalidasMateriales.Talle,
  DetalleSalidasMateriales.IdColor,
  ''
 FROM DetalleSalidasMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Articulos ON DetalleSalidasMateriales.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleSalidasMateriales.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN DetalleValesSalida ON DetalleSalidasMateriales.IdDetalleValeSalida=DetalleValesSalida.IdDetalleValeSalida
 LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra = Obras.IdObra
 LEFT OUTER JOIN #Kits ON #Kits.IdArticulo = DetalleSalidasMateriales.IdArticulo
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
		(@SoloKits='SI' or IsNull(DetalleSalidasMateriales.DescargaPorKit,'NO')<>'SI' or IsNull(DetalleSalidasMateriales.IdUbicacionDestino,0)<>0) and 
		(@IdArticulo=-1 or 
			(@IdArticulo>0 and DetalleSalidasMateriales.IdArticulo=@IdArticulo) or 
			(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		SalidasMateriales.FechaSalidaMateriales between @FechaArranqueMovimientosStock and @FechaHasta and 
		IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleSalidasMateriales.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleSalidasMateriales.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		(@SoloKits<>'SI' or IsNull(#Kits.IdArticulo,0)>0)

 UNION ALL

 SELECT
  IsNull(cv.IdArticulo,0),
  50,
  DetalleSalidasMateriales.IdSalidaMateriales,
  7,
  SalidasMateriales.FechaSalidaMateriales,
  Case When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
	When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
	When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
	Else Substring(IsNull(SalidasMateriales.ClaveTipoSalida,''),1,20)
  End,
  SalidasMateriales.NumeroSalidaMateriales,
  DetalleSalidasMateriales.IdUbicacion,
  DetalleSalidasMateriales.IdObra,
  Case When DetalleSalidasMateriales.IdUnidad=A1.IdUnidad Then DetalleSalidasMateriales.Cantidad Else 
	Case When IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=DetalleSalidasMateriales.IdArticulo and dau.IdUnidad=DetalleSalidasMateriales.IdUnidad),1)<>0 
		Then DetalleSalidasMateriales.Cantidad/IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=DetalleSalidasMateriales.IdArticulo and dau.IdUnidad=DetalleSalidasMateriales.IdUnidad),1)
		Else DetalleSalidasMateriales.Cantidad
  End End * IsNull(cv.Cantidad,0) * -1,
  cv.IdUnidad,
  DetalleSalidasMateriales.Partida,
  DetalleValesSalida.IdDetalleRequerimiento,
  Substring(IsNull('Obra destino : '+Obras.NumeroObra+' - '+Obras.Descripcion+'  ','')+Convert(Varchar,IsNull(DetalleSalidasMateriales.Observaciones,'')),1,150),
  DetalleSalidasMateriales.NumeroCaja,
  DetalleSalidasMateriales.IdEquipoDestino,
  DetalleSalidasMateriales.Talle,
  DetalleSalidasMateriales.IdColor,
  ''
 FROM DetalleSalidasMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=DetalleSalidasMateriales.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=SalidasMateriales.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 LEFT OUTER JOIN Articulos A1 ON DetalleSalidasMateriales.IdArticulo = A1.IdArticulo
 LEFT OUTER JOIN Articulos A2 ON cv.IdArticulo = A2.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleSalidasMateriales.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN DetalleValesSalida ON DetalleSalidasMateriales.IdDetalleValeSalida=DetalleValesSalida.IdDetalleValeSalida
 LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra = Obras.IdObra
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
		IsNull(DetalleSalidasMateriales.DescargaPorKit,'NO')='SI' and IsNull(DetalleSalidasMateriales.IdUbicacionDestino,0)=0 and 
		(@IdArticulo=-1 or 
			(@IdArticulo>0 and cv.IdArticulo=@IdArticulo) or 
			(@IdArticulo=-2 and (IsNull(A2.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		SalidasMateriales.FechaSalidaMateriales between @FechaArranqueMovimientosStock and @FechaHasta and 
		IsNull(A2.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleSalidasMateriales.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleSalidasMateriales.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', A2.Descripcion)<>0) and 
		@SoloKits<>'SI' and IsNull(cv.IdArticulo,0)>0

 UNION ALL

 SELECT
  DetalleRecepciones.IdArticulo,
  60,
  DetalleRecepciones.IdRecepcion,
  4,
  Recepciones.FechaRecepcion,
  'Recepcion',
  Recepciones.NumeroRecepcionAlmacen,
  DetalleRecepciones.IdUbicacion,
  DetalleRecepciones.IdObra,
  IsNull(DetalleRecepciones.CantidadCC,DetalleRecepciones.Cantidad),
  DetalleRecepciones.IdUnidad,
  DetalleRecepciones.Partida,
  DetalleRecepciones.IdDetalleRequerimiento,
  Substring(Convert(Varchar,IsNull(DetalleRecepciones.Observaciones,'')),1,150),
  DetalleRecepciones.NumeroCaja,
  Null,
  DetalleRecepciones.Talle,
  DetalleRecepciones.IdColor,
  Substring(Convert(Varchar,IsNull(Proveedores.RazonSocial,'')),1,100)
 FROM DetalleRecepciones
 LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
 LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetalleRecepciones.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleRecepciones.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN #Kits ON #Kits.IdArticulo = DetalleRecepciones.IdArticulo
 WHERE IsNull(Recepciones.Anulada,'NO')<>'SI' and 
		(@IdArticulo=-1 or 
			(@IdArticulo>0 and DetalleRecepciones.IdArticulo=@IdArticulo) or 
			(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		Recepciones.FechaRecepcion between @FechaArranqueMovimientosStock and @FechaHasta and 
		IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleRecepciones.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleRecepciones.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		(@SoloKits<>'SI' or IsNull(#Kits.IdArticulo,0)>0)

 UNION ALL

 SELECT
  DetalleOtrosIngresosAlmacen.IdArticulo,
  108,
  DetalleOtrosIngresosAlmacen.IdOtroIngresoAlmacen,
  3,
  OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,
  'Otros ing.',
  OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen,
  DetalleOtrosIngresosAlmacen.IdUbicacion,
  DetalleOtrosIngresosAlmacen.IdObra,
  IsNull(DetalleOtrosIngresosAlmacen.CantidadCC,DetalleOtrosIngresosAlmacen.Cantidad),
  DetalleOtrosIngresosAlmacen.IdUnidad,
  DetalleOtrosIngresosAlmacen.Partida,
  Null,
  Substring(Convert(Varchar,IsNull(DetalleOtrosIngresosAlmacen.Observaciones,'')),1,150),
  Null,
  DetalleOtrosIngresosAlmacen.IdEquipoDestino,
  DetalleOtrosIngresosAlmacen.Talle,
  DetalleOtrosIngresosAlmacen.IdColor,
  ''
 FROM DetalleOtrosIngresosAlmacen
 LEFT OUTER JOIN OtrosIngresosAlmacen ON DetalleOtrosIngresosAlmacen.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 LEFT OUTER JOIN Articulos ON DetalleOtrosIngresosAlmacen.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleOtrosIngresosAlmacen.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN #Kits ON #Kits.IdArticulo = DetalleOtrosIngresosAlmacen.IdArticulo
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
		(@IdArticulo=-1 or 
			(@IdArticulo>0 and DetalleOtrosIngresosAlmacen.IdArticulo=@IdArticulo) or 
			(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		OtrosIngresosAlmacen.FechaOtroIngresoAlmacen between @FechaArranqueMovimientosStock and @FechaHasta and 
		IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleOtrosIngresosAlmacen.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleOtrosIngresosAlmacen.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		(@SoloKits<>'SI' or IsNull(#Kits.IdArticulo,0)>0)

 UNION ALL

 SELECT
  DetalleRemitos.IdArticulo,
  41,
  DetalleRemitos.IdRemito,
  6,
  Remitos.FechaRemito,
  'Remito',
  Remitos.NumeroRemito,
  DetalleRemitos.IdUbicacion,
  DetalleRemitos.IdObra,
  DetalleRemitos.Cantidad * -1,
  DetalleRemitos.IdUnidad,
  DetalleRemitos.Partida,
  Null,
  Substring(Convert(Varchar,IsNull(DetalleRemitos.Observaciones,'')),1,150),
  DetalleRemitos.NumeroCaja,
  Null,
  DetalleRemitos.Talle,
  DetalleRemitos.IdColor,
  Substring(Convert(Varchar,IsNull(Clientes.RazonSocial,'')),1,100)
 FROM DetalleRemitos
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Clientes ON Remitos.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Articulos ON DetalleRemitos.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleRemitos.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN #Kits ON #Kits.IdArticulo = DetalleRemitos.IdArticulo
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI' and 
		(@SoloKits='SI' or IsNull(DetalleRemitos.DescargaPorKit,'NO')<>'SI') and 
		(@IdArticulo=-1 or 
			(@IdArticulo>0 and DetalleRemitos.IdArticulo=@IdArticulo) or 
			(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		Remitos.FechaRemito between @FechaArranqueMovimientosStock and @FechaHasta and 
		IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleRemitos.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleRemitos.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		(@SoloKits<>'SI' or IsNull(#Kits.IdArticulo,0)>0)

 UNION ALL

 SELECT
  IsNull(cv.IdArticulo,0),
  41,
  DetalleRemitos.IdRemito,
  6,
  Remitos.FechaRemito,
  'Remito',
  Remitos.NumeroRemito,
  DetalleRemitos.IdUbicacion,
  DetalleRemitos.IdObra,  DetalleRemitos.Cantidad * IsNull(cv.Cantidad,0) * -1,
  cv.IdUnidad,
  DetalleRemitos.Partida,
  Null,
  Substring(Convert(Varchar,IsNull(DetalleRemitos.Observaciones,'')),1,150),
  DetalleRemitos.NumeroCaja,
  Null,
  DetalleRemitos.Talle,
  DetalleRemitos.IdColor,
  Substring(Convert(Varchar,IsNull(Clientes.RazonSocial,'')),1,100)
 FROM DetalleRemitos
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Clientes ON Remitos.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=DetalleRemitos.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=Remitos.FechaRemito 
																									Order By a502_2.FechaModificacion2 Desc))
 LEFT OUTER JOIN Articulos ON cv.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleRemitos.IdUbicacion = Ubicaciones.IdUbicacion
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI' and 
		IsNull(DetalleRemitos.DescargaPorKit,'NO')='SI' and 
		(@IdArticulo=-1 or 
			(@IdArticulo>0 and cv.IdArticulo=@IdArticulo) or 
			(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		Remitos.FechaRemito between @FechaArranqueMovimientosStock and @FechaHasta and 
		IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleRemitos.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleRemitos.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		@SoloKits<>'SI' and IsNull(cv.IdArticulo,0)>0

 UNION ALL

 SELECT
  DetalleDevoluciones.IdArticulo,
  5,
  DetalleDevoluciones.IdDevolucion,
  5,
  Devoluciones.FechaDevolucion,
  'Devolucion' as [Documento],
  Devoluciones.NumeroDevolucion,
  DetalleDevoluciones.IdUbicacion,
  DetalleDevoluciones.IdObra,
  DetalleDevoluciones.Cantidad,
  DetalleDevoluciones.IdUnidad,
  DetalleDevoluciones.Partida,
  Null,
  Substring(Convert(Varchar,IsNull(DetalleDevoluciones.Observaciones,'')),1,150),
  DetalleDevoluciones.NumeroCaja,
  Null,
  DetalleDevoluciones.Talle,
  DetalleDevoluciones.IdColor,
  Substring(Convert(Varchar,IsNull(Clientes.RazonSocial,'')),1,100)
 FROM DetalleDevoluciones
 LEFT OUTER JOIN Devoluciones ON DetalleDevoluciones.IdDevolucion = Devoluciones.IdDevolucion
 LEFT OUTER JOIN Clientes ON Devoluciones.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Articulos ON DetalleDevoluciones.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Ubicaciones ON DetalleDevoluciones.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN #Kits ON #Kits.IdArticulo = DetalleDevoluciones.IdArticulo
 WHERE IsNull(Devoluciones.Anulada,'NO')<>'SI' and 
		(@IdArticulo=-1 or 
			(@IdArticulo>0 and DetalleDevoluciones.IdArticulo=@IdArticulo) or 
			(@IdArticulo=-2 and (IsNull(Articulos.Codigo,'') between @CodigoDesde and @CodigoHasta))) and 
		Devoluciones.FechaDevolucion between @FechaArranqueMovimientosStock and @FechaHasta and 
		IsNull(Articulos.RegistrarStock,'SI')='SI' and 
		(@IdObra1=-1 or DetalleDevoluciones.IdObra=@IdObra1) and 
		(@IdDeposito1=-1 or Ubicaciones.IdDeposito=@IdDeposito1) and 
		(@IdUbicacion1=-1 or DetalleDevoluciones.IdUbicacion=@IdUbicacion1) and 
		(@Descripcion='*' or Patindex('%'+@Descripcion+'%', Articulos.Descripcion)<>0) and 
		(@SoloKits<>'SI' or IsNull(#Kits.IdArticulo,0)>0)


CREATE TABLE #Auxiliar2 
			(
			 IdArticulo INTEGER,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Orden INTEGER,
			 Fecha DATETIME,
			 Documento VARCHAR(20),
			 Numero INTEGER,
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 Stock NUMERIC(18,2),
			 IdDetalleRequerimiento INTEGER,
			 Observaciones VARCHAR(150),
			 NumeroCaja INTEGER,
			 NumeroOrden INTEGER,
			 IdEquipoDestino INTEGER,
			 Equivalencia NUMERIC(18,6),
			 CantidadEquivalencia NUMERIC(18,2),
			 Talle VARCHAR(2),
			 IdColor INTEGER,
			 T1 INTEGER,
			 T2 INTEGER,
			 T3 INTEGER,
			 T4 INTEGER,
			 T5 INTEGER,
			 T6 INTEGER,
			 T7 INTEGER,
			 T8 INTEGER,
			 T9 INTEGER,
			 T10 INTEGER,
			 T11 INTEGER,
			 T12 INTEGER,
			 T13 INTEGER,
			 T14 INTEGER,
			 T15 INTEGER,
			 Entidad VARCHAR(100)
			)

/*  CURSOR  */
DECLARE @IdArticulo1 int, @Orden int, @Fecha datetime, @Documento varchar(20), @Numero int, @IdUbicacion int, @IdObra int, @IdEquipoDestino int, @Entidad varchar(100), 
		@Cantidad numeric(18,2), @CantidadEquivalencia numeric(18,2), @Equivalencia numeric(18,6), @IdUnidad int, @IdUnidadArticulo int, @Partida varchar(20), 
		@Stock numeric(18,2), @Corte int, @NumeroCaja int, @NumeroOrden int, @SdoIni numeric(18,2), @IdTipoComprobante int, @IdComprobante int, 
		@IdDetalleRequerimiento int, @Observaciones varchar(150), @IdColor int, @IdCurvaTalle int, @Talle varchar(2), @Curva varchar(50), @Pos int, @i int, 
		@T1 int, @T2 int, @T3 int, @T4 int, @T5 int, @T6 int, @T7 int, @T8 int, @T9 int, @T10 int, @T11 int, @T12 int, @T13 int, @T14 int, @T15 int,
		@TT1 int, @TT2 int, @TT3 int, @TT4 int, @TT5 int, @TT6 int, @TT7 int, @TT8 int, @TT9 int, @TT10 int, @TT11 int, @TT12 int, @TT13 int, @TT14 int, @TT15 int

SET @TT1=0
SET @TT2=0
SET @TT3=0
SET @TT4=0
SET @TT5=0
SET @TT6=0
SET @TT7=0
SET @TT8=0
SET @TT9=0
SET @TT10=0
SET @TT11=0
SET @TT12=0
SET @TT13=0
SET @TT14=0
SET @TT15=0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdArticulo, IdTipoComprobante, IdComprobante, Orden, Fecha, Documento, Numero, IdUbicacion, IdObra, Cantidad, IdUnidad, 
			   Partida, IdDetalleRequerimiento, Observaciones, NumeroCaja, IdEquipoDestino, Talle, IdColor, Entidad
		FROM #Auxiliar1
		ORDER BY IdArticulo, Fecha, Orden, Documento, Numero, Talle, IdColor, Cantidad
OPEN Cur
FETCH NEXT FROM Cur INTO @IdArticulo1, @IdTipoComprobante, @IdComprobante, @Orden, @Fecha, @Documento, @Numero, @IdUbicacion, @IdObra, @Cantidad, @IdUnidad, 
						 @Partida, @IdDetalleRequerimiento, @Observaciones, @NumeroCaja, @IdEquipoDestino, @Talle, @IdColor, @Entidad
SET @Stock=0
SET @SdoIni=0
SET @Corte=@IdArticulo1
SET @NumeroOrden=0
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @Corte<>@IdArticulo1
	  BEGIN
		IF @SdoIni<>0
			INSERT INTO #Auxiliar2 
				(IdArticulo, IdTipoComprobante, IdComprobante, Orden, Fecha, Documento, Numero, IdUbicacion, IdObra, Cantidad, IdUnidad, Partida, Stock, 
				 IdDetalleRequerimiento, Observaciones, NumeroCaja, NumeroOrden, IdEquipoDestino, Equivalencia, CantidadEquivalencia, Talle, IdColor, 
				 T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, Entidad)
				VALUES
				(@Corte, 0, 0, 0, @FechaDesde, '_Sdo.Inic.', '', 0, 0, @SdoIni, 0, 0, @SdoIni, Null, Null, Null, 0, Null, 1, @SdoIni, Null, Null, 
				 @TT1, @TT2, @TT3, @TT4, @TT5, @TT6, @TT7, @TT8, @TT9, @TT10, @TT11, @TT12, @TT13, @TT14, @TT15, @Entidad)
		SET @Corte=@IdArticulo1
		SET @Stock=0
		SET @SdoIni=0
		SET @NumeroOrden=0
		SET @TT1=0
		SET @TT2=0
		SET @TT3=0
		SET @TT4=0
		SET @TT5=0
		SET @TT6=0
		SET @TT7=0
		SET @TT8=0
		SET @TT9=0
		SET @TT10=0
		SET @TT11=0
		SET @TT12=0
		SET @TT13=0
		SET @TT14=0
		SET @TT15=0
	  END

	SET @NumeroOrden=@NumeroOrden+1
	SET @IdUnidadArticulo=IsNull((Select Top 1 IdUnidad From Articulos Where IdArticulo=@IdArticulo1),0)
	SET @IdCurvaTalle=IsNull((Select Top 1 IdCurvaTalle From Articulos Where IdArticulo=@IdArticulo1),0)
	SET @Equivalencia=IsNull((Select Top 1 Equivalencia From DetalleArticulosUnidades Where IdArticulo=@IdArticulo1 and IdUnidad=@IdUnidad),1)
	SET @CantidadEquivalencia=@Cantidad
	IF @Equivalencia<>0
		SET @CantidadEquivalencia=@Cantidad/@Equivalencia
	SET @Stock=@Stock+@CantidadEquivalencia
	SET @Curva=IsNull((Select Top 1 Curva From CurvasTalles Where IdCurvaTalle=@IdCurvaTalle),'')

	SET @T1=0
	SET @T2=0
	SET @T3=0
	SET @T4=0
	SET @T5=0
	SET @T6=0
	SET @T7=0
	SET @T8=0
	SET @T9=0
	SET @T10=0
	SET @T11=0
	SET @T12=0
	SET @T13=0
	SET @T14=0
	SET @T15=0

	SET @Pos=0
	SET @i=0
	WHILE @i<15
	  BEGIN
		SET @i=@i+1
		IF Substring(@Curva,(@i-1)*2+1,2)=@Talle
		    BEGIN
			SET @Pos=@i
			BREAK
		    END
	  END
	IF @Pos<=1
		SET @T1=@CantidadEquivalencia
	IF @Pos=2
		SET @T2=@CantidadEquivalencia
	IF @Pos=3
		SET @T3=@CantidadEquivalencia
	IF @Pos=4
		SET @T4=@CantidadEquivalencia
	IF @Pos=5
		SET @T5=@CantidadEquivalencia
	IF @Pos=6
		SET @T6=@CantidadEquivalencia
	IF @Pos=7
		SET @T7=@CantidadEquivalencia
	IF @Pos=8
		SET @T8=@CantidadEquivalencia
	IF @Pos=9
		SET @T9=@CantidadEquivalencia
	IF @Pos=10
		SET @T10=@CantidadEquivalencia
	IF @Pos=11
		SET @T11=@CantidadEquivalencia
	IF @Pos=12
		SET @T12=@CantidadEquivalencia
	IF @Pos=13
		SET @T13=@CantidadEquivalencia
	IF @Pos=14
		SET @T14=@CantidadEquivalencia
	IF @Pos=15
		SET @T15=@CantidadEquivalencia

	SET @TT1=@TT1+@T1
	SET @TT2=@TT2+@T2
	SET @TT3=@TT3+@T3
	SET @TT4=@TT4+@T4
	SET @TT5=@TT5+@T5
	SET @TT6=@TT6+@T6
	SET @TT7=@TT7+@T7
	SET @TT8=@TT8+@T8
	SET @TT9=@TT9+@T9
	SET @TT10=@TT10+@T10
	SET @TT11=@TT11+@T11
	SET @TT12=@TT12+@T12
	SET @TT13=@TT13+@T13
	SET @TT14=@TT14+@T14
	SET @TT15=@TT15+@T15

	IF @Fecha>=@FechaDesde
		INSERT INTO #Auxiliar2 
		(IdArticulo, IdTipoComprobante, IdComprobante, Orden, Fecha, Documento, Numero, IdUbicacion, IdObra, Cantidad, IdUnidad, Partida, Stock, 
		 IdDetalleRequerimiento, Observaciones, NumeroCaja, NumeroOrden, IdEquipoDestino, Equivalencia, CantidadEquivalencia, Talle, IdColor, 
		 T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, Entidad)
		VALUES
		(@IdArticulo1, @IdTipoComprobante, @IdComprobante, @Orden, @Fecha, @Documento, @Numero, @IdUbicacion, @IdObra, @Cantidad, @IdUnidad, @Partida, @Stock, 
		 @IdDetalleRequerimiento, @Observaciones, @NumeroCaja, @NumeroOrden, @IdEquipoDestino, @Equivalencia, @CantidadEquivalencia, @Talle, @IdColor, 
		 @T1, @T2, @T3, @T4, @T5, @T6, @T7, @T8, @T9, @T10, @T11, @T12, @T13, @T14, @T15, @Entidad)
	ELSE
		SET @SdoIni=@SdoIni+@CantidadEquivalencia
		
	FETCH NEXT FROM Cur INTO @IdArticulo1, @IdTipoComprobante, @IdComprobante, @Orden, @Fecha, @Documento, @Numero, @IdUbicacion, @IdObra, @Cantidad, @IdUnidad, 
							 @Partida, @IdDetalleRequerimiento, @Observaciones, @NumeroCaja, @IdEquipoDestino, @Talle, @IdColor, @Entidad
  END
IF @SdoIni<>0
	INSERT INTO #Auxiliar2 
	(IdArticulo, IdTipoComprobante, IdComprobante, Orden, Fecha, Documento, Numero, IdUbicacion, IdObra, Cantidad, IdUnidad, Partida, Stock, 
	 IdDetalleRequerimiento, Observaciones, NumeroCaja, NumeroOrden, IdEquipoDestino, Equivalencia, CantidadEquivalencia, Talle, IdColor, 
	 T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, Entidad)
	VALUES
	(@Corte, 0, 0, 0, @FechaDesde, '_Sdo.Inic.', '', 0, 0, @SdoIni, 0, 0, @SdoIni, Null, Null, Null, 0, Null, 1, @SdoIni, Null, Null, 
	 @TT1, @TT2, @TT3, @TT4, @TT5, @TT6, @TT7, @TT8, @TT9, @TT10, @TT11, @TT12, @TT13, @TT14, @TT15, @Entidad)
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)

IF @RegistrosResumidos='SI'
  BEGIN
	SELECT
	 #Auxiliar2.IdArticulo as [Id],
	 Articulos.Descripcion as [Aux1],
	 2 as [Aux2],
	 #Auxiliar2.Orden as [Aux3],
	 Articulos.Codigo as [Codigo],
	 #Auxiliar2.IdTipoComprobante as [IdTipoComprobante],
	 #Auxiliar2.IdComprobante as [IdComprobante],
	 Articulos.Descripcion as [Articulo],
	 #Auxiliar2.NumeroOrden as [Ord.],
	 #Auxiliar2.Fecha as [Fecha],
	 #Auxiliar2.Documento as [Documento],
	 #Auxiliar2.Numero as [Numero],
	 U1.Abreviatura as [Un],
	 #Auxiliar2.Cantidad as [Cantidad],
	 U2.Abreviatura as [Equiv. a],
	 #Auxiliar2.Equivalencia as [Equiv.],
	 #Auxiliar2.CantidadEquivalencia as [Cant.Equiv.],
	 #Auxiliar2.Stock as [Stock],
	 Articulos.CostoReposicion as [Costo Rep.],
	 Depositos.Descripcion+' - '+Ubicaciones.Descripcion as [Ubicacion],
	 Obras.NumeroObra as [Obra],
	 #Auxiliar2.Partida as [Partida],
	 Requerimientos.NumeroRequerimiento as [Nro.RM],
	 DetReq.NumeroItem as [Item RM],
	 #Auxiliar2.NumeroCaja as [Nro.Caja],
	 #Auxiliar0.NumeroInventario as [Cod. Equipo destino],
	 #Auxiliar0.Descripcion as [Equipo destino],
	 #Auxiliar2.Observaciones as [Observaciones],
	 @Vector_T as [Vector_T],
	 @Vector_X as [Vector_X]
	FROM #Auxiliar2
	LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Ubicaciones ON #Auxiliar2.IdUbicacion = Ubicaciones.IdUbicacion
	LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
	LEFT OUTER JOIN Obras ON #Auxiliar2.IdObra = Obras.IdObra
	LEFT OUTER JOIN Unidades U1 ON #Auxiliar2.IdUnidad = U1.IdUnidad
	LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
	LEFT OUTER JOIN DetalleRequerimientos DetReq ON #Auxiliar2.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdArticulo = #Auxiliar2.IdEquipoDestino
	ORDER BY [Aux1], [Id], [Aux2], [Fecha], [Aux3], [Documento], [Numero], [Ord.], [Cantidad]
  END
ELSE
  BEGIN
	IF @Detallado='SI' and @RegistrosResumidos<>'SI' and @SistemaVentasPorTalle<>'SI'
	  BEGIN
		SET @vector_X='000011111111111111111111111133'
		IF @MostrarCosto='SI'
			IF @DatosSalida='SI'
				SET @vector_T='0000299CG43302222220302223D500'
			ELSE
				SET @vector_T='0000299CG433022222203022299500'
		ELSE
			IF @DatosSalida='SI'
				SET @vector_T='0000299CG43302222290302223D500'
			ELSE
				SET @vector_T='0000299CG433022222903022299500'
		
		SELECT
		 #Auxiliar2.IdArticulo as [Id],
		 Articulos.Descripcion as [Aux1],
		 1 as [Aux2],
		 0 as [Aux3],
		 Articulos.Codigo as [Codigo],
		 0 as [IdTipoComprobante],
		 0 as [IdComprobante],
		 Articulos.Descripcion as [Articulo],
		 Null as [Ord.],
		 Null as [Fecha],
		 Null as [Documento],
		 Null as [Numero],
		 Null as [Un],
		 Null as [Cantidad],
		 Null as [Equiv. a],
		 Null as [Equiv.],
		 Null as [Cant.Equiv.],
		 Null as [Stock],
		 Null as [Costo Rep.],
		 Null as [Ubicacion],
		 Null as [Obra],
		 Null as [Partida],
		 Null as [Nro.RM],
		 Null as [Item RM],
		 Null as [Nro.Caja],
		 Null as [Cod. Equipo destino],
		 Null as [Equipo destino],
		 Null as [Observaciones],
		 @Vector_T as [Vector_T],
		 @Vector_X as [Vector_X]
		FROM #Auxiliar2
		LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
		GROUP BY #Auxiliar2.IdArticulo, Articulos.Codigo, Articulos.Descripcion
		
		UNION ALL
		
		SELECT
		 #Auxiliar2.IdArticulo as [Id],
		 Articulos.Descripcion as [Aux1],
		 2 as [Aux2],
		 #Auxiliar2.Orden as [Aux3],
		 Articulos.Codigo as [Codigo],
		 #Auxiliar2.IdTipoComprobante as [IdTipoComprobante],
		 #Auxiliar2.IdComprobante as [IdComprobante],
		 Articulos.Descripcion as [Articulo],
		 #Auxiliar2.NumeroOrden as [Ord.],
		 #Auxiliar2.Fecha as [Fecha],
		 #Auxiliar2.Documento as [Documento],
		 #Auxiliar2.Numero as [Numero],
		 U1.Abreviatura as [Un],
		 #Auxiliar2.Cantidad as [Cantidad],
		 U2.Abreviatura as [Equiv. a],
		 #Auxiliar2.Equivalencia as [Equiv.],
		 #Auxiliar2.CantidadEquivalencia as [Cant.Equiv.],
		 #Auxiliar2.Stock as [Stock],
		 Articulos.CostoReposicion as [Costo Rep.],
		 Depositos.Descripcion+' - '+Ubicaciones.Descripcion as [Ubicacion],
		 Obras.NumeroObra as [Obra],
		 #Auxiliar2.Partida as [Partida],
		 Requerimientos.NumeroRequerimiento as [Nro.RM],
		 DetReq.NumeroItem as [Item RM],
		 #Auxiliar2.NumeroCaja as [Nro.Caja],
		 #Auxiliar0.NumeroInventario as [Cod. Equipo destino],
		 #Auxiliar0.Descripcion as [Equipo destino],
		 #Auxiliar2.Observaciones as [Observaciones],
		 @Vector_T as [Vector_T],
		 @Vector_X as [Vector_X]
		FROM #Auxiliar2
		LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN Ubicaciones ON #Auxiliar2.IdUbicacion = Ubicaciones.IdUbicacion
		LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
		LEFT OUTER JOIN Obras ON #Auxiliar2.IdObra = Obras.IdObra
		LEFT OUTER JOIN Unidades U1 ON #Auxiliar2.IdUnidad = U1.IdUnidad
		LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
		LEFT OUTER JOIN DetalleRequerimientos DetReq ON #Auxiliar2.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
		LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
		LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdArticulo = #Auxiliar2.IdEquipoDestino
		
		UNION ALL
		
		SELECT
		 #Auxiliar2.IdArticulo as [Id],
		 Articulos.Descripcion as [Aux1],
		 3 as [Aux2],
		 999 as [Aux3],
		 Null as [Codigo],
		 0 as [IdTipoComprobante],
		 0 as [IdComprobante],
		 Null as [Articulo],
		 Null as [Ord.],
		 Null as [Fecha],
		 Null as [Documento],
		 Null as [Numero],
		 Null as [Un],
		 Null as [Cantidad],
		 Null as [Equiv. a],
		 Null as [Equiv.],
		 Null as [Cant.Equiv.],
		 Null as [Stock],
		 Null as [Costo Rep.],
		 Null as [Ubicacion],
		 Null as [Obra],
		 Null as [Partida],
		 Null as [Nro.RM],
		 Null as [Item RM],
		 Null as [Nro.Caja],
		 Null as [Cod. Equipo destino],
		 Null as [Equipo destino],
		 Null as [Observaciones],
		 @Vector_T as [Vector_T],
		 @Vector_X as [Vector_X]
		FROM #Auxiliar2
		LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
		GROUP BY #Auxiliar2.IdArticulo, Articulos.Descripcion
		
		ORDER BY [Aux1], [Id], [Aux2], [Fecha], [Aux3], [Documento], [Numero], [Ord.], [Cantidad]
	  END

	IF @SistemaVentasPorTalle='SI'
	  BEGIN
		SET NOCOUNT ON
	
		CREATE TABLE #Auxiliar4 
					(
					 IdArticulo INTEGER,
					 IdTipoComprobante INTEGER,
					 IdComprobante INTEGER,
					 Fecha DATETIME,
					 Documento VARCHAR(20),
					 Numero INTEGER,
					 IdUnidad INTEGER,
					 IdColor INTEGER,
					 CantidadEquivalencia NUMERIC(18,2),
					 T1 INTEGER,
					 T2 INTEGER,
					 T3 INTEGER,
					 T4 INTEGER,
					 T5 INTEGER,
					 T6 INTEGER,
					 T7 INTEGER,
					 T8 INTEGER,
					 T9 INTEGER,
					 T10 INTEGER,
					 T11 INTEGER,
					 T12 INTEGER,
					 T13 INTEGER,
					 T14 INTEGER,
					 T15 INTEGER,
					 Entidad VARCHAR(100)
					)
		INSERT INTO #Auxiliar4 
		 SELECT IdArticulo, IdTipoComprobante, IdComprobante, Fecha, Documento, Numero, IdUnidad, IdColor, Sum(IsNull(CantidadEquivalencia,0)), 
				Sum(IsNull(T1,0)), Sum(IsNull(T2,0)), Sum(IsNull(T3,0)), Sum(IsNull(T4,0)), Sum(IsNull(T5,0)), Sum(IsNull(T6,0)), Sum(IsNull(T7,0)), Sum(IsNull(T8,0)), 
				Sum(IsNull(T9,0)), Sum(IsNull(T10,0)), Sum(IsNull(T11,0)), Sum(IsNull(T12,0)), Sum(IsNull(T13,0)), Sum(IsNull(T14,0)), Sum(IsNull(T15,0)), Entidad
		 FROM #Auxiliar2
		 GROUP BY IdArticulo, IdTipoComprobante, IdComprobante, Fecha, Documento, Numero, IdUnidad, IdColor, Entidad
		 ORDER BY IdArticulo, Fecha, Documento, Numero, IdTipoComprobante, IdComprobante
	
		SET NOCOUNT OFF
	
		SET @vector_X='000011111111111111111111111111133'
		SET @vector_T='0000299C432022FEEEEEEEEEEEEEEE200'
		
		SELECT 
		 0 as [Id],
		 Null as [Aux1],
		 0 as [Aux2],
		 0 as [Aux3],
		 Null as [Codigo],
		 Null as [IdTipoComprobante],
		 Null as [IdComprobante],
		 Null as [Articulo],
		 Null as [Fecha],
		 Null as [Documento],
		 Null as [Numero],
		 Null as [Un],
		 Null as [Color],
		 Null as [Cantidad],
		 CurvasTalles.Codigo as [C],
		 Substring(CurvasTalles.Curva,1,2) as [T1],
		 Substring(CurvasTalles.Curva,3,2) as [T2],
		 Substring(CurvasTalles.Curva,5,2) as [T3],
		 Substring(CurvasTalles.Curva,7,2) as [T4],
		 Substring(CurvasTalles.Curva,9,2) as [T5],
		 Substring(CurvasTalles.Curva,11,2) as [T6],
		 Substring(CurvasTalles.Curva,13,2) as [T7],
		 Substring(CurvasTalles.Curva,15,2) as [T8],
		 Substring(CurvasTalles.Curva,17,2) as [T9],
		 Substring(CurvasTalles.Curva,19,2) as [T10],
		 Substring(CurvasTalles.Curva,21,2) as [T11],
		 Substring(CurvasTalles.Curva,23,2) as [T12],
		 Substring(CurvasTalles.Curva,25,2) as [T13],
		 Substring(CurvasTalles.Curva,27,2) as [T14],
		 Substring(CurvasTalles.Curva,29,2) as [T15],
		 Null as [Entidad],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM CurvasTalles
		WHERE IsNull(MostrarCurvaEnInformes,'')='SI'

		UNION ALL

		SELECT
		 #Auxiliar4.IdArticulo as [Id],
		 Articulos.Descripcion as [Aux1],
		 1 as [Aux2],
		 1 as [Aux3],
		 Articulos.Codigo as [Codigo],
		 #Auxiliar4.IdTipoComprobante as [IdTipoComprobante],
		 #Auxiliar4.IdComprobante as [IdComprobante],
		 Articulos.Descripcion as [Articulo],
		 #Auxiliar4.Fecha as [Fecha],
		 #Auxiliar4.Documento as [Documento],
		 #Auxiliar4.Numero as [Numero],
		 U1.Abreviatura as [Un],
		 Colores.Descripcion as [Color],
		 #Auxiliar4.CantidadEquivalencia as [Cantidad],
		 CurvasTalles.Codigo as [C],
		 Convert(varchar,Case When #Auxiliar4.T1<>0 Then #Auxiliar4.T1 Else Null End) as [T1],
		 Convert(varchar,Case When #Auxiliar4.T2<>0 Then #Auxiliar4.T2 Else Null End) as [T2],
		 Convert(varchar,Case When #Auxiliar4.T3<>0 Then #Auxiliar4.T3 Else Null End) as [T3],
		 Convert(varchar,Case When #Auxiliar4.T4<>0 Then #Auxiliar4.T4 Else Null End) as [T4],
		 Convert(varchar,Case When #Auxiliar4.T5<>0 Then #Auxiliar4.T5 Else Null End) as [T5],
		 Convert(varchar,Case When #Auxiliar4.T6<>0 Then #Auxiliar4.T6 Else Null End) as [T6],
		 Convert(varchar,Case When #Auxiliar4.T7<>0 Then #Auxiliar4.T7 Else Null End) as [T7],
		 Convert(varchar,Case When #Auxiliar4.T8<>0 Then #Auxiliar4.T8 Else Null End) as [T8],
		 Convert(varchar,Case When #Auxiliar4.T9<>0 Then #Auxiliar4.T9 Else Null End) as [T9],
		 Convert(varchar,Case When #Auxiliar4.T10<>0 Then #Auxiliar4.T10 Else Null End) as [T10],
		 Convert(varchar,Case When #Auxiliar4.T11<>0 Then #Auxiliar4.T11 Else Null End) as [T11],
		 Convert(varchar,Case When #Auxiliar4.T12<>0 Then #Auxiliar4.T12 Else Null End) as [T12],
		 Convert(varchar,Case When #Auxiliar4.T13<>0 Then #Auxiliar4.T13 Else Null End) as [T13],
		 Convert(varchar,Case When #Auxiliar4.T14<>0 Then #Auxiliar4.T14 Else Null End) as [T14],
		 Convert(varchar,Case When #Auxiliar4.T15<>0 Then #Auxiliar4.T15 Else Null End) as [T15],
		 #Auxiliar4.Entidad as [Entidad],
		 @Vector_T as [Vector_T],
		 @Vector_X as [Vector_X]
		FROM #Auxiliar4
		LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = #Auxiliar4.IdArticulo
		LEFT OUTER JOIN Unidades U1 ON U1.IdUnidad = #Auxiliar4.IdUnidad
		LEFT OUTER JOIN Colores ON Colores.IdColor = #Auxiliar4.IdColor
		LEFT OUTER JOIN CurvasTalles ON CurvasTalles.IdCurvaTalle = Articulos.IdCurvaTalle

		ORDER BY [Aux1], [Id], [Aux2], [Fecha], [Aux3], [Documento], [Cantidad]

		DROP TABLE #Auxiliar4
	  END
	ELSE
		IF Not (@Detallado='SI' and @RegistrosResumidos<>'SI' and @SistemaVentasPorTalle<>'SI')
		  BEGIN
			SET NOCOUNT ON
		
			CREATE TABLE #Auxiliar3 
						(
						 IdArticulo INTEGER,
						 SaldoInicial NUMERIC(18,2),
						 Entradas NUMERIC(18,2),
						 Salidas NUMERIC(18,2),
						 Saldo NUMERIC(18,2),
						)
			INSERT INTO #Auxiliar3 
			 SELECT #Auxiliar2.IdArticulo, Sum(Case When Documento='_Sdo.Inic.' Then #Auxiliar2.Stock Else 0 End), 
				Sum(Case When Documento<>'_Sdo.Inic.' and CantidadEquivalencia>=0 Then #Auxiliar2.CantidadEquivalencia Else 0 End), 
				Sum(Case When Documento<>'_Sdo.Inic.' and CantidadEquivalencia<0 Then #Auxiliar2.CantidadEquivalencia Else 0 End), 0
			 FROM #Auxiliar2
			 GROUP BY IdArticulo
		
			UPDATE #Auxiliar3
			SET Saldo=SaldoInicial+Entradas+Salidas
		
			SET NOCOUNT OFF
		
			SET @vector_X='00011111133'
			SET @vector_T='0002D444400'
			
			SELECT
			 #Auxiliar3.IdArticulo as [Id],
			 Articulos.Descripcion as [Aux1],
			 1 as [Aux2],
			 Articulos.Codigo as [Codigo],
			 Articulos.Descripcion as [Articulo],
			 #Auxiliar3.SaldoInicial as [Sdo.Ini.],
			 #Auxiliar3.Entradas as [Entradas],
			 #Auxiliar3.Salidas as [Salidas],
			 #Auxiliar3.Saldo as [Saldo],
			 @Vector_T as [Vector_T],
			 @Vector_X as [Vector_X]
			FROM #Auxiliar3
			LEFT OUTER JOIN Articulos ON #Auxiliar3.IdArticulo = Articulos.IdArticulo
			ORDER BY Articulos.Codigo, Articulos.Descripcion
		
			DROP TABLE #Auxiliar3
		  END
  END

DROP TABLE #Kits
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar501
DROP TABLE #Auxiliar502
