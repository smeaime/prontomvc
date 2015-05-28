CREATE Procedure [dbo].[Stock_TX_ControlContraCardex]

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
			 IdObra INTEGER,
			 IdUbicacion INTEGER,
			 Partida VARCHAR(20),
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 NumeroCaja INTEGER,
			 IdColor INTEGER,
			 Talle VARCHAR(2)
			)

INSERT INTO #Auxiliar1 
 SELECT 
  daj.IdArticulo,
  daj.IdObra,
  daj.IdUbicacion,
  daj.Partida,
  daj.CantidadUnidades,
  daj.IdUnidad,
  IsNull(daj.NumeroCaja,0),
  IsNull(daj.IdColor,0),
  IsNull(daj.Talle,'')
 FROM DetalleAjustesStock daj
 LEFT OUTER JOIN AjustesStock ON daj.IdAjusteStock=AjustesStock.IdAjusteStock
 WHERE AjustesStock.FechaAjuste>=@FechaArranqueMovimientosStock

INSERT INTO #Auxiliar1 
 SELECT
  dsm.IdArticulo,
  dsm.IdObra,
  dsm.IdUbicacion,
  dsm.Partida,
  dsm.Cantidad*-1,
  dsm.IdUnidad,
  IsNull(dsm.NumeroCaja,0),
  IsNull(dsm.IdColor,0),
  IsNull(dsm.Talle,'')
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	IsNull(dsm.DescargaPorKit,'NO')<>'SI' and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock

INSERT INTO #Auxiliar1 
 SELECT 
  cv.IdArticulo,
  dsm.IdObra,
  dsm.IdUbicacion,
  dsm.Partida,
  dsm.Cantidad * cv.Cantidad * -1,
  cv.IdUnidad,
  IsNull(dsm.NumeroCaja,0),
  IsNull(dsm.IdColor,0),
  IsNull(dsm.Talle,'')
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dsm.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=SalidasMateriales.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	IsNull(dsm.DescargaPorKit,'NO')='SI' and 
	SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock

INSERT INTO #Auxiliar1 
 SELECT
  dr.IdArticulo,
  dr.IdObra,
  dr.IdUbicacion,
  dr.Partida,
  dr.Cantidad,
  dr.IdUnidad,
  IsNull(dr.NumeroCaja,0),
  IsNull(dr.IdColor,0),
  IsNull(dr.Talle,'')
 FROM DetalleRecepciones dr
 LEFT OUTER JOIN Recepciones ON dr.IdRecepcion = Recepciones.IdRecepcion
 WHERE (Recepciones.Anulada is null or Recepciones.Anulada<>'SI') and 
	Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock

INSERT INTO #Auxiliar1 
 SELECT
  doia.IdArticulo,
  doia.IdObra,
  doia.IdUbicacion,
  doia.Partida,
  doia.Cantidad,
  doia.IdUnidad,
  0,
  IsNull(doia.IdColor,0),
  IsNull(doia.Talle,'')
 FROM DetalleOtrosIngresosAlmacen doia
 LEFT OUTER JOIN OtrosIngresosAlmacen ON doia.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen>=@FechaArranqueMovimientosStock

INSERT INTO #Auxiliar1 
 SELECT
  dr.IdArticulo,
  dr.IdObra,
  dr.IdUbicacion,
  dr.Partida,
  dr.Cantidad*-1,
  dr.IdUnidad,
  IsNull(dr.NumeroCaja,0),
  IsNull(dr.IdColor,0),
  IsNull(dr.Talle,'')
 FROM DetalleRemitos dr
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI' and 
	IsNull(dr.DescargaPorKit,'NO')<>'SI' and 
	Remitos.FechaRemito>=@FechaArranqueMovimientosStock

INSERT INTO #Auxiliar1 
 SELECT
  IsNull(cv.IdArticulo,0),
  dr.IdObra,
  dr.IdUbicacion,
  dr.Partida,
  dr.Cantidad * IsNull(cv.Cantidad,0) * -1,
  cv.IdUnidad,
  IsNull(dr.NumeroCaja,0),
  IsNull(dr.IdColor,0),
  IsNull(dr.Talle,'')
 FROM DetalleRemitos dr
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dr.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=Remitos.FechaRemito 
																									Order By a502_2.FechaModificacion2 Desc))
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI' and 
	IsNull(dr.DescargaPorKit,'NO')='SI' and 
	Remitos.FechaRemito>=@FechaArranqueMovimientosStock and
	IsNull(cv.IdArticulo,0)>0

INSERT INTO #Auxiliar1 
 SELECT
  dd.IdArticulo,
  dd.IdObra,
  dd.IdUbicacion,
  dd.Partida,
  dd.Cantidad,
  dd.IdUnidad,
  IsNull(dd.NumeroCaja,0),
  IsNull(dd.IdColor,0),
  IsNull(dd.Talle,'')
 FROM DetalleDevoluciones dd
 LEFT OUTER JOIN Devoluciones ON dd.IdDevolucion = Devoluciones.IdDevolucion
 WHERE (Devoluciones.Anulada is null or Devoluciones.Anulada<>'SI') and 
	Devoluciones.FechaDevolucion>=@FechaArranqueMovimientosStock


CREATE TABLE #Auxiliar2 
			(
			 IdArticulo INTEGER,
			 CantidadCalculada NUMERIC(18,2),
			 CantidadStock NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdArticulo,
  SUM(IsNull(#Auxiliar1.Cantidad,0)),
  0
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdArticulo

UNION ALL

 SELECT 
  Stock.IdArticulo,
  0,
  SUM(IsNull(Stock.CantidadUnidades,0))
 FROM Stock
 GROUP BY Stock.IdArticulo


CREATE TABLE #Auxiliar3 
			(
			 IdArticulo INTEGER,
			 CantidadCalculada NUMERIC(18,2),
			 CantidadStock NUMERIC(18,2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.IdArticulo,
  SUM(IsNull(#Auxiliar2.CantidadCalculada,0)),
  SUM(IsNull(#Auxiliar2.CantidadStock,0))
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdArticulo

SET NOCOUNT OFF

SELECT 
 #Auxiliar3.*,
 #Auxiliar3.CantidadCalculada-#Auxiliar3.CantidadStock as [Dif.],
 Articulos.Codigo,
 Articulos.Descripcion
FROM #Auxiliar3
LEFT OUTER JOIN Articulos ON #Auxiliar3.IdArticulo=Articulos.IdArticulo
WHERE CantidadCalculada<>CantidadStock and IsNull(Articulos.RegistrarStock,'SI')='SI'

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar501
DROP TABLE #Auxiliar502
