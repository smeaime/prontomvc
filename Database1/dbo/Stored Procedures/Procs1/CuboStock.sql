CREATE Procedure [dbo].[CuboStock]

@FechaDesde datetime,
@FechaHasta datetime,
@IncluirCodigo varchar(1),
@Dts varchar(200)

AS

SET NOCOUNT ON

DECLARE @FechaArranqueMovimientosStock datetime

SET @FechaArranqueMovimientosStock=IsNull((Select Top 1 FechaArranqueMovimientosStock From Parametros Where IdParametro=1),Convert(datetime,'01/01/1900'))

CREATE TABLE #Auxiliar501 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 date)
CREATE NONCLUSTERED INDEX IX__Auxiliar501 ON #Auxiliar501 (IdArticuloConjunto,FechaModificacion2,FechaModificacion Desc) ON [PRIMARY]
INSERT INTO #Auxiliar501 
 SELECT IdArticuloConjunto, FechaModificacion, FechaModificacion
 FROM ConjuntosVersiones

CREATE TABLE #Auxiliar502 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 date)
CREATE NONCLUSTERED INDEX IX__Auxiliar502 ON #Auxiliar502 (IdArticuloConjunto,FechaModificacion2 Desc) ON [PRIMARY]
INSERT INTO #Auxiliar502 
 SELECT IdArticuloConjunto, Max(FechaModificacion), FechaModificacion2
 FROM #Auxiliar501
 GROUP BY IdArticuloConjunto, FechaModificacion2

CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER,
			 Ubicacion VARCHAR(20),
			 Deposito VARCHAR(50),
			 Obra VARCHAR(113),
			 Cantidad NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT DetalleAjustesStock.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), DetalleAjustesStock.CantidadUnidades
 FROM DetalleAjustesStock
 LEFT OUTER JOIN AjustesStock ON DetalleAjustesStock.IdAjusteStock = AjustesStock.IdAjusteStock
 LEFT OUTER JOIN Ubicaciones ON DetalleAjustesStock.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON DetalleAjustesStock.IdObra = Obras.IdObra
 WHERE AjustesStock.FechaAjuste<@FechaDesde and AjustesStock.FechaAjuste>=@FechaArranqueMovimientosStock

 UNION ALL

 SELECT dsm.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), dsm.Cantidad * -1
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Ubicaciones ON dsm.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON Case When IsNull(dsm.IdObra,0)>0 Then dsm.IdObra Else SalidasMateriales.IdObra End = Obras.IdObra
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')<>'SI' and 
	SalidasMateriales.FechaSalidaMateriales<@FechaDesde and SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock

 UNION ALL

 SELECT cv.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), dsm.Cantidad * IsNull(cv.Cantidad,1) * -1
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dsm.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=SalidasMateriales.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 LEFT OUTER JOIN Ubicaciones ON dsm.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON Case When IsNull(dsm.IdObra,0)>0 Then dsm.IdObra Else SalidasMateriales.IdObra End = Obras.IdObra
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')='SI' and 
	SalidasMateriales.FechaSalidaMateriales<@FechaDesde and SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT dr.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), IsNull(dr.CantidadCC,dr.Cantidad)
 FROM DetalleRecepciones dr 
 LEFT OUTER JOIN Recepciones ON dr.IdRecepcion = Recepciones.IdRecepcion
 LEFT OUTER JOIN Ubicaciones ON dr.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON dr.IdObra = Obras.IdObra
 WHERE Recepciones.FechaRecepcion<@FechaDesde and IsNull(Recepciones.Anulada,'')<>'SI' and 
	Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT doia.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), IsNull(doia.CantidadCC,doia.Cantidad)
 FROM DetalleOtrosIngresosAlmacen doia 
 LEFT OUTER JOIN OtrosIngresosAlmacen ON doia.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 LEFT OUTER JOIN Ubicaciones ON doia.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON Case When IsNull(doia.IdObra,0)>0 Then doia.IdObra Else OtrosIngresosAlmacen.IdObra End = Obras.IdObra
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and OtrosIngresosAlmacen.FechaOtroIngresoAlmacen<@FechaDesde and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT dr.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), dr.Cantidad * -1
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Ubicaciones ON dr.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON dr.IdObra = Obras.IdObra
 WHERE Remitos.FechaRemito<@FechaDesde and IsNull(dr.DescargaPorKit,'NO')<>'SI' and IsNull(Remitos.Anulado,'')<>'SI' and 
	Remitos.FechaRemito>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT cv.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), dr.Cantidad * cv.Cantidad * -1
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dr.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=Remitos.FechaRemito 
																									Order By a502_2.FechaModificacion2 Desc))
 LEFT OUTER JOIN Ubicaciones ON dr.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON dr.IdObra = Obras.IdObra
 WHERE Remitos.FechaRemito<@FechaDesde and IsNull(dr.DescargaPorKit,'NO')='SI' and IsNull(Remitos.Anulado,'')<>'SI' and 
	Remitos.FechaRemito>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT dd.IdArticulo, 'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), 
	IsNull(Depositos.Descripcion,''), IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''), dd.Cantidad
 FROM DetalleDevoluciones dd 
 LEFT OUTER JOIN Devoluciones ON dd.IdDevolucion = Devoluciones.IdDevolucion
 LEFT OUTER JOIN Ubicaciones ON dd.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON dd.IdObra = Obras.IdObra
 WHERE Devoluciones.FechaDevolucion<@FechaDesde and IsNull(Devoluciones.Anulada,'')<>'SI' and 
	Devoluciones.FechaDevolucion>=@FechaArranqueMovimientosStock

-- POR SI NO TIENEN SALDO INICIAL Y QUE ESTE EL COSTO 
INSERT INTO #Auxiliar1 
 SELECT DetalleAjustesStock.IdArticulo, '', '', '', 0
 FROM DetalleAjustesStock
 LEFT OUTER JOIN AjustesStock ON DetalleAjustesStock.IdAjusteStock = AjustesStock.IdAjusteStock
 WHERE AjustesStock.FechaAjuste>=@FechaDesde and AjustesStock.FechaAjuste<=@FechaHasta and 
	AjustesStock.FechaAjuste>=@FechaArranqueMovimientosStock

 UNION ALL

 SELECT dsm.IdArticulo, '', '', '', 0
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')<>'SI' and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaDesde and SalidasMateriales.FechaSalidaMateriales<=@FechaHasta and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock

 UNION ALL

 SELECT cv.IdArticulo, '', '', '', 0
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dsm.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=SalidasMateriales.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')='SI' and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaDesde and SalidasMateriales.FechaSalidaMateriales<=@FechaHasta and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT dr.IdArticulo, '', '', '', 0
 FROM DetalleRecepciones dr 
 LEFT OUTER JOIN Recepciones ON dr.IdRecepcion = Recepciones.IdRecepcion
 WHERE Recepciones.FechaRecepcion>=@FechaDesde and Recepciones.FechaRecepcion<=@FechaHasta and IsNull(Recepciones.Anulada,'')<>'SI' and 
	Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT doia.IdArticulo, '', '', '', 0
 FROM DetalleOtrosIngresosAlmacen doia 
 LEFT OUTER JOIN OtrosIngresosAlmacen ON doia.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen>=@FechaDesde and OtrosIngresosAlmacen.FechaOtroIngresoAlmacen<=@FechaHasta and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT dr.IdArticulo, '', '', '', 0
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 WHERE Remitos.FechaRemito>=@FechaDesde and Remitos.FechaRemito<=@FechaHasta and IsNull(dr.DescargaPorKit,'NO')<>'SI' and 
	IsNull(Remitos.Anulado,'')<>'SI' and Remitos.FechaRemito>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT cv.IdArticulo, '', '', '', 0
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dr.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=Remitos.FechaRemito 
																									Order By a502_2.FechaModificacion2 Desc))
 WHERE Remitos.FechaRemito>=@FechaDesde and Remitos.FechaRemito<=@FechaHasta and IsNull(dr.DescargaPorKit,'NO')='SI' and 
	IsNull(Remitos.Anulado,'')<>'SI' and Remitos.FechaRemito>=@FechaArranqueMovimientosStock

UNION ALL

 SELECT dd.IdArticulo, '', '', '', 0
 FROM DetalleDevoluciones dd 
 LEFT OUTER JOIN Devoluciones ON dd.IdDevolucion = Devoluciones.IdDevolucion
 WHERE Devoluciones.FechaDevolucion>=@FechaDesde and Devoluciones.FechaDevolucion<=@FechaHasta and 
	IsNull(Devoluciones.Anulada,'')<>'SI' and Devoluciones.FechaDevolucion>=@FechaArranqueMovimientosStock

CREATE TABLE #Auxiliar21 
			(
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18, 2),
			 CostoReposicion NUMERIC(18, 3)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar21 ON #Auxiliar21 (IdArticulo) ON [PRIMARY]
INSERT INTO #Auxiliar21 
 SELECT #Auxiliar1.IdArticulo, Sum(IsNull(#Auxiliar1.Cantidad,0)), 0
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdArticulo

UPDATE #Auxiliar21
SET CostoReposicion=
	Round((Select Top 1 dr.CostoUnitario*dr.CotizacionMoneda
			From DetalleRecepciones dr 
			Left Outer Join Recepciones r On dr.IdRecepcion = r.IdRecepcion
			Where dr.IdArticulo=#Auxiliar21.IdArticulo and r.FechaRecepcion<=@FechaHasta and IsNull(r.Anulada,'NO')<>'SI' and r.FechaRecepcion>=@FechaArranqueMovimientosStock
			Order By r.FechaRecepcion Desc, r.NumeroRecepcionAlmacen Desc),3)

UPDATE #Auxiliar21
SET CostoReposicion=Round(IsNull((Select Top 1 Articulos.CostoInicial From Articulos Where Articulos.IdArticulo=#Auxiliar21.IdArticulo),0),3)
WHERE IsNull(CostoReposicion,0)=0


CREATE TABLE #Auxiliar22 
			(
			 IdArticulo INTEGER,
			 Obra VARCHAR(113),
			 Cantidad NUMERIC(18, 2),
			 CostoReposicion NUMERIC(18, 3)
			)
INSERT INTO #Auxiliar22 
 SELECT #Auxiliar1.IdArticulo, #Auxiliar1.Obra, Sum(IsNull(#Auxiliar1.Cantidad,0)), 0
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdArticulo, #Auxiliar1.Obra

UPDATE #Auxiliar22
SET CostoReposicion=Round(IsNull((Select Top 1 #Auxiliar21.CostoReposicion From #Auxiliar21 Where #Auxiliar21.IdArticulo=#Auxiliar22.IdArticulo),0),3)

CREATE TABLE #Auxiliar23 
			(
			 IdArticulo INTEGER,
			 Ubicacion VARCHAR(20),
			 Deposito VARCHAR(50),
			 Cantidad NUMERIC(18, 2),
			 CostoReposicion NUMERIC(18, 3)
			)
INSERT INTO #Auxiliar23 
 SELECT #Auxiliar1.IdArticulo, #Auxiliar1.Ubicacion, #Auxiliar1.Deposito, Sum(IsNull(#Auxiliar1.Cantidad,0)), 0
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdArticulo, #Auxiliar1.Ubicacion, #Auxiliar1.Deposito

UPDATE #Auxiliar23
SET CostoReposicion=Round(IsNull((Select Top 1 #Auxiliar21.CostoReposicion From #Auxiliar21 Where #Auxiliar21.IdArticulo=#Auxiliar23.IdArticulo),0),3)


TRUNCATE TABLE _TempCuboStock

INSERT INTO _TempCuboStock 
 SELECT 
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  AjustesStock.FechaAjuste,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(DetalleAjustesStock.Partida,''),
  '('+Convert(varchar,Year(AjustesStock.FechaAjuste))+
	Substring('00',1,2-Len(Convert(varchar,Month(AjustesStock.FechaAjuste))))+Convert(varchar,Month(AjustesStock.FechaAjuste))+
	Substring('00',1,2-Len(Convert(varchar,Day(AjustesStock.FechaAjuste))))+Convert(varchar,Day(AjustesStock.FechaAjuste))+') '+
	'Ajuste + '+
	Substring('0000000000',1,10-len(Convert(varchar,AjustesStock.NumeroAjusteStock)))+Convert(varchar,AjustesStock.NumeroAjusteStock)+' '+
	'del '+Convert(varchar,AjustesStock.FechaAjuste,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  DetalleAjustesStock.CantidadUnidades,
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleAjustesStock
 LEFT OUTER JOIN AjustesStock ON DetalleAjustesStock.IdAjusteStock = AjustesStock.IdAjusteStock
 LEFT OUTER JOIN Articulos ON DetalleAjustesStock.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON DetalleAjustesStock.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON DetalleAjustesStock.IdObra = Obras.IdObra
 LEFT OUTER JOIN Unidades ON DetalleAjustesStock.IdUnidad = Unidades.IdUnidad
 WHERE AjustesStock.FechaAjuste>=@FechaDesde and AjustesStock.FechaAjuste<=@FechaHasta and 
	DetalleAjustesStock.CantidadUnidades>=0 and AjustesStock.FechaAjuste>=@FechaArranqueMovimientosStock and 
	IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  AjustesStock.FechaAjuste,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(DetalleAjustesStock.Partida,''),
  '('+Convert(varchar,Year(AjustesStock.FechaAjuste))+Substring('00',1,2-Len(Convert(varchar,Month(AjustesStock.FechaAjuste))))+Convert(varchar,Month(AjustesStock.FechaAjuste))+
	Substring('00',1,2-Len(Convert(varchar,Day(AjustesStock.FechaAjuste))))+Convert(varchar,Day(AjustesStock.FechaAjuste))+') '+
  'Ajuste - '+
	Substring('0000000000',1,10-len(Convert(varchar,AjustesStock.NumeroAjusteStock)))+Convert(varchar,AjustesStock.NumeroAjusteStock)+' '+
	'del '+Convert(varchar,AjustesStock.FechaAjuste,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  DetalleAjustesStock.CantidadUnidades,
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleAjustesStock
 LEFT OUTER JOIN AjustesStock ON DetalleAjustesStock.IdAjusteStock = AjustesStock.IdAjusteStock
 LEFT OUTER JOIN Articulos ON DetalleAjustesStock.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON DetalleAjustesStock.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON DetalleAjustesStock.IdObra = Obras.IdObra
 LEFT OUTER JOIN Unidades ON DetalleAjustesStock.IdUnidad = Unidades.IdUnidad
 WHERE AjustesStock.FechaAjuste>=@FechaDesde and AjustesStock.FechaAjuste<=@FechaHasta and 
	DetalleAjustesStock.CantidadUnidades<0 and AjustesStock.FechaAjuste>=@FechaArranqueMovimientosStock and 
	IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  SalidasMateriales.FechaSalidaMateriales,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(dsm.Partida,''),
  '('+Convert(varchar,Year(SalidasMateriales.FechaSalidaMateriales))+
		Substring('00',1,2-Len(Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))+
	Substring('00',1,2-Len(Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))+') '+
  'Salida mat. '+
	Substring('0000000000',1,10-len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)+' '+
	'del '+Convert(varchar,SalidasMateriales.FechaSalidaMateriales,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  dsm.Cantidad * -1,
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Articulos ON dsm.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON dsm.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON Case When IsNull(dsm.IdObra,0)>0 Then dsm.IdObra Else SalidasMateriales.IdObra End = Obras.IdObra
 LEFT OUTER JOIN Unidades ON dsm.IdUnidad = Unidades.IdUnidad
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')<>'SI' and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaDesde and SalidasMateriales.FechaSalidaMateriales<=@FechaHasta and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock and IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  SalidasMateriales.FechaSalidaMateriales,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(dsm.Partida,''),
  '('+Convert(varchar,Year(SalidasMateriales.FechaSalidaMateriales))+
		Substring('00',1,2-Len(Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))+
	Substring('00',1,2-Len(Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))+') '+
  'Salida mat. (KIT) '+
	Substring('0000000000',1,10-len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)+' '+
	'del '+Convert(varchar,SalidasMateriales.FechaSalidaMateriales,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  dsm.Cantidad * cv.Cantidad * -1, 
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dsm.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=SalidasMateriales.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 LEFT OUTER JOIN Articulos ON cv.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON dsm.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON Case When IsNull(dsm.IdObra,0)>0 Then dsm.IdObra Else SalidasMateriales.IdObra End = Obras.IdObra
 LEFT OUTER JOIN Unidades ON dsm.IdUnidad = Unidades.IdUnidad
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')='SI' and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaDesde and SalidasMateriales.FechaSalidaMateriales<=@FechaHasta and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock and IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  Recepciones.FechaRecepcion,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(DetalleRecepciones.Partida,''),
  '('+Convert(varchar,Year(Recepciones.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Month(Recepciones.FechaRecepcion))))+Convert(varchar,Month(Recepciones.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Day(Recepciones.FechaRecepcion))))+Convert(varchar,Day(Recepciones.FechaRecepcion))+') '+
  'Recepcion '+
	Substring('0000',1,4-len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+' '+
	Substring('00000000',1,8-len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+' '+
	'del '+Convert(varchar,Recepciones.FechaRecepcion,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(DetalleRecepciones.CantidadCC,DetalleRecepciones.Cantidad),
  0,
  IsNull(DetalleRecepciones.CantidadCC,DetalleRecepciones.Cantidad) * IsNull(DetalleRecepciones.CostoUnitario,0) * IsNull(DetalleRecepciones.CotizacionMoneda,1),
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleRecepciones
 LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
 LEFT OUTER JOIN Articulos ON DetalleRecepciones.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON DetalleRecepciones.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON DetalleRecepciones.IdObra = Obras.IdObra
 LEFT OUTER JOIN Unidades ON DetalleRecepciones.IdUnidad = Unidades.IdUnidad
 WHERE Recepciones.FechaRecepcion>=@FechaDesde and Recepciones.FechaRecepcion<=@FechaHasta and 
	(Recepciones.Anulada is null or Recepciones.Anulada<>'SI') and Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock and 
	IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(DetalleOtrosIngresosAlmacen.Partida,''),
  '('+Convert(varchar,Year(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
	Substring('00',1,2-Len(Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
	Substring('00',1,2-Len(Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+') '+
  'Otros ing. '+
	Substring('0000000000',1,10-len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)+' '+
	'del '+Convert(varchar,OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(DetalleOtrosIngresosAlmacen.CantidadCC,DetalleOtrosIngresosAlmacen.Cantidad),
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleOtrosIngresosAlmacen
 LEFT OUTER JOIN OtrosIngresosAlmacen ON DetalleOtrosIngresosAlmacen.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 LEFT OUTER JOIN Articulos ON DetalleOtrosIngresosAlmacen.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON DetalleOtrosIngresosAlmacen.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON Case When IsNull(DetalleOtrosIngresosAlmacen.IdObra,0)>0 Then DetalleOtrosIngresosAlmacen.IdObra Else OtrosIngresosAlmacen.IdObra End = Obras.IdObra
 LEFT OUTER JOIN Unidades ON DetalleOtrosIngresosAlmacen.IdUnidad = Unidades.IdUnidad
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen>=@FechaDesde and OtrosIngresosAlmacen.FechaOtroIngresoAlmacen<=@FechaHasta and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen>=@FechaArranqueMovimientosStock and IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  Remitos.FechaRemito,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(DetalleRemitos.Partida,''),
  '('+Convert(varchar,Year(Remitos.FechaRemito))+Substring('00',1,2-Len(Convert(varchar,Month(Remitos.FechaRemito))))+Convert(varchar,Month(Remitos.FechaRemito))+
	Substring('00',1,2-Len(Convert(varchar,Day(Remitos.FechaRemito))))+Convert(varchar,Day(Remitos.FechaRemito))+') '+
  'Remito '+
	Substring('0000000000',1,10-len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito)+' '+
	'del '+Convert(varchar,Remitos.FechaRemito,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  DetalleRemitos.Cantidad * -1, 
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleRemitos
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Articulos ON DetalleRemitos.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON DetalleRemitos.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON DetalleRemitos.IdObra = Obras.IdObra
 LEFT OUTER JOIN Unidades ON DetalleRemitos.IdUnidad = Unidades.IdUnidad
 WHERE Remitos.FechaRemito>=@FechaDesde and Remitos.FechaRemito<=@FechaHasta and 
	IsNull(DetalleRemitos.DescargaPorKit,'NO')<>'SI' and IsNull(Remitos.Anulado,'')<>'SI' and 
	Remitos.FechaRemito>=@FechaArranqueMovimientosStock and IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  Remitos.FechaRemito,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(DetalleRemitos.Partida,''),
  '('+Convert(varchar,Year(Remitos.FechaRemito))+Substring('00',1,2-Len(Convert(varchar,Month(Remitos.FechaRemito))))+Convert(varchar,Month(Remitos.FechaRemito))+
	Substring('00',1,2-Len(Convert(varchar,Day(Remitos.FechaRemito))))+Convert(varchar,Day(Remitos.FechaRemito))+') '+
  'Remito '+
	Substring('0000000000',1,10-len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito)+' '+
	'del '+Convert(varchar,Remitos.FechaRemito,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  DetalleRemitos.Cantidad * cv.Cantidad * -1, 
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleRemitos
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=DetalleRemitos.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=Remitos.FechaRemito 
																									Order By a502_2.FechaModificacion2 Desc))
 LEFT OUTER JOIN Articulos ON cv.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON DetalleRemitos.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON DetalleRemitos.IdObra = Obras.IdObra
 LEFT OUTER JOIN Unidades ON DetalleRemitos.IdUnidad = Unidades.IdUnidad
 WHERE Remitos.FechaRemito>=@FechaDesde and Remitos.FechaRemito<=@FechaHasta and 
	IsNull(DetalleRemitos.DescargaPorKit,'NO')='SI' and IsNull(Remitos.Anulado,'')<>'SI' and 
	Remitos.FechaRemito>=@FechaArranqueMovimientosStock and IsNull(Articulos.RegistrarStock,'SI')='SI'

UNION ALL

 SELECT
  Articulos.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  Devoluciones.FechaDevolucion,
  Depositos.Descripcion,
  'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' '+'G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  IsNull(Obras.NumeroObra+' : ','')+IsNull(Obras.Descripcion,''),
  IsNull(DetalleDevoluciones.Partida,''),
  '('+Convert(varchar,Year(Devoluciones.FechaDevolucion))+
	Substring('00',1,2-Len(Convert(varchar,Month(Devoluciones.FechaDevolucion))))+Convert(varchar,Month(Devoluciones.FechaDevolucion))+
	Substring('00',1,2-Len(Convert(varchar,Day(Devoluciones.FechaDevolucion))))+Convert(varchar,Day(Devoluciones.FechaDevolucion))+') '+
  'Devoluciones '+
	Substring('0000',1,4-len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+' '+
	Substring('00000000',1,8-len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)+' '+
	'del '+Convert(varchar,Devoluciones.FechaDevolucion,103)+'  '+
	'Dep.'+IsNull(Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' - '+
	'E:'+IsNull(Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' M:'+IsNull(Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+' G:'+IsNull(Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''),
  DetalleDevoluciones.Cantidad, 
  0,
  0,
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM DetalleDevoluciones
 LEFT OUTER JOIN Devoluciones ON DetalleDevoluciones.IdDevolucion = Devoluciones.IdDevolucion
 LEFT OUTER JOIN Articulos ON DetalleDevoluciones.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Ubicaciones ON DetalleDevoluciones.IdUbicacion = Ubicaciones.IdUbicacion
 LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
 LEFT OUTER JOIN Obras ON DetalleDevoluciones.IdObra = Obras.IdObra
 LEFT OUTER JOIN Unidades ON DetalleDevoluciones.IdUnidad = Unidades.IdUnidad
 WHERE Devoluciones.FechaDevolucion>=@FechaDesde and Devoluciones.FechaDevolucion<=@FechaHasta and 
	IsNull(Devoluciones.Anulada,'')<>'SI' and Devoluciones.FechaDevolucion>=@FechaArranqueMovimientosStock and 
	IsNull(Articulos.RegistrarStock,'SI')='SI'

UPDATE _TempCuboStock
SET Costo=IsNull((Select Top 1 #Auxiliar21.CostoReposicion From #Auxiliar21 Where #Auxiliar21.IdArticulo=_TempCuboStock.IdArticulo),0)

UPDATE _TempCuboStock
SET Costo=Round(IsNull((Select Top 1 Articulos.CostoInicial From Articulos Where Articulos.IdArticulo=_TempCuboStock.IdArticulo),0),3)
WHERE IsNull(Costo,0)=0

UPDATE _TempCuboStock
SET StockValorizado=Round(Cantidad * Costo,3)
/*
	IsNull((Select Top 1 dr.CostoUnitario*dr.CotizacionMoneda
		From DetalleRecepciones dr 
		Left Outer Join Recepciones On dr.IdRecepcion = Recepciones.IdRecepcion
		Where dr.IdArticulo=_TempCuboStock.IdArticulo and Recepciones.FechaRecepcion<=_TempCuboStock.Fecha and IsNull(Recepciones.Anulada,'NO')<>'SI' 
		Order By Recepciones.FechaRecepcion Desc, Recepciones.NumeroRecepcionAlmacen Desc),0)
WHERE IsNull(StockValorizado,0)=0

UPDATE _TempCuboStock
SET StockValorizado=Cantidad * IsNull((Select Top 1 Articulos.CostoInicial From Articulos Where Articulos.IdArticulo=_TempCuboStock.IdArticulo),0)
WHERE IsNull(StockValorizado,0)=0
*/

TRUNCATE TABLE _TempCuboStock2
INSERT INTO _TempCuboStock2 
 SELECT IdArticulo, Articulo, Fecha, Deposito, Ubicacion, Obra, Partida, Detalle, Cantidad, Costo, StockValorizado, Cuenta, Unidad
 FROM _TempCuboStock

-- AGREGAR EL SALDO INICIAL POR ARTICULO - OBRA
INSERT INTO _TempCuboStock2 
 SELECT 
  #Auxiliar22.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  @FechaDesde,
  '',
  '',
  #Auxiliar22.Obra,
  0,
  '('+Convert(varchar,Year(@FechaDesde))+Substring('00',1,2-Len(Convert(varchar,Month(@FechaDesde))))+Convert(varchar,Month(@FechaDesde))+
	Substring('00',1,2-Len(Convert(varchar,Day(@FechaDesde))))+Convert(varchar,Day(@FechaDesde))+') '+'_Saldo al '+Convert(varchar,@FechaDesde,103),
  #Auxiliar22.Cantidad,
  Case When IsNull(#Auxiliar22.CostoReposicion,0)<>0 then IsNull(#Auxiliar22.CostoReposicion,0) Else IsNull(Articulos.CostoInicial,0) End,
  Round(#Auxiliar22.Cantidad * Case When IsNull(#Auxiliar22.CostoReposicion,0)<>0 then IsNull(#Auxiliar22.CostoReposicion,0) Else IsNull(Articulos.CostoInicial,0) End,3),
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM #Auxiliar22
 LEFT OUTER JOIN Articulos ON #Auxiliar22.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
 WHERE IsNull(Articulos.RegistrarStock,'SI')='SI' and IsNull(#Auxiliar22.Cantidad,0)<>0


TRUNCATE TABLE _TempCuboStock3
INSERT INTO _TempCuboStock3 
 SELECT IdArticulo, Articulo, Fecha, Deposito, Ubicacion, Obra, Partida, Detalle, Cantidad, Costo, StockValorizado, Cuenta, Unidad
 FROM _TempCuboStock

-- AGREGAR EL SALDO INICIAL POR ARTICULO - DEPOSITO
INSERT INTO _TempCuboStock3 
 SELECT 
  #Auxiliar23.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  @FechaDesde,
  #Auxiliar23.Deposito,
  #Auxiliar23.Ubicacion,
  '',
  0,
  '('+Convert(varchar,Year(@FechaDesde))+Substring('00',1,2-Len(Convert(varchar,Month(@FechaDesde))))+Convert(varchar,Month(@FechaDesde))+
	Substring('00',1,2-Len(Convert(varchar,Day(@FechaDesde))))+Convert(varchar,Day(@FechaDesde))+') '+'_Saldo al '+Convert(varchar,@FechaDesde,103),
  #Auxiliar23.Cantidad,
  Case When IsNull(#Auxiliar23.CostoReposicion,0)<>0 then IsNull(#Auxiliar23.CostoReposicion,0) Else IsNull(Articulos.CostoInicial,0) End,
  Round(#Auxiliar23.Cantidad * Case When IsNull(#Auxiliar23.CostoReposicion,0)<>0 then IsNull(#Auxiliar23.CostoReposicion,0) Else IsNull(Articulos.CostoInicial,0) End,3),
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM #Auxiliar23
 LEFT OUTER JOIN Articulos ON #Auxiliar23.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
 WHERE IsNull(Articulos.RegistrarStock,'SI')='SI' and IsNull(#Auxiliar23.Cantidad,0)<>0

-- AGREGAR EL SALDO INICIAL POR ARTICULO
INSERT INTO _TempCuboStock 
 SELECT 
  #Auxiliar21.IdArticulo,
  Case When @IncluirCodigo='C' 
	Then IsNull(Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+' ','')+Articulos.Descripcion+' - '+
		IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else Articulos.Descripcion+' - '+IsNull(IsNull(Unidades.Abreviatura COLLATE SQL_Latin1_General_CP1_CI_AS,Unidades.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS),'')
  End,
  @FechaDesde,
  '',
  '',
  '',
  0,
  '('+Convert(varchar,Year(@FechaDesde))+Substring('00',1,2-Len(Convert(varchar,Month(@FechaDesde))))+Convert(varchar,Month(@FechaDesde))+
	Substring('00',1,2-Len(Convert(varchar,Day(@FechaDesde))))+Convert(varchar,Day(@FechaDesde))+') '+'_Saldo al '+Convert(varchar,@FechaDesde,103),
  #Auxiliar21.Cantidad,
  Case When IsNull(#Auxiliar21.CostoReposicion,0)<>0 then IsNull(#Auxiliar21.CostoReposicion,0) Else IsNull(Articulos.CostoInicial,0) End,
  Round(#Auxiliar21.Cantidad * Case When IsNull(#Auxiliar21.CostoReposicion,0)<>0 then IsNull(#Auxiliar21.CostoReposicion,0) Else IsNull(Articulos.CostoInicial,0) End,3),
  IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'S/D'),
  IsNull(Unidades.Abreviatura COLLATE Modern_Spanish_CI_AS,Unidades.Descripcion COLLATE Modern_Spanish_CI_AS)
 FROM #Auxiliar21
 LEFT OUTER JOIN Articulos ON #Auxiliar21.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
 WHERE IsNull(Articulos.RegistrarStock,'SI')='SI' and IsNull(#Auxiliar21.Cantidad,0)<>0


DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar21
DROP TABLE #Auxiliar22
DROP TABLE #Auxiliar23
DROP TABLE #Auxiliar501
DROP TABLE #Auxiliar502
