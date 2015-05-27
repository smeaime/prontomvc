CREATE  Procedure [dbo].[LMateriales_TX_SaldosPorDestino]

@IdEquipoDestino int,
@TipoListado varchar(1),
@ConCostos varchar(2) = Null

AS 

SET NOCOUNT ON

SET @ConCostos=IsNull(@ConCostos,'NO')

CREATE TABLE #Auxiliar1 
			(
			 IdEquipoDestino INTEGER,
			 IdArticulo INTEGER,
			 Orden INTEGER,
			 IdDetalleLMateriales INTEGER,
			 IdDetalleSalidaMateriales INTEGER,
			 IdDetalleOtroIngresoAlmacen INTEGER,
			 IdUnidad INTEGER,
			 Cantidad NUMERIC(18,2),
			 CantidadLM NUMERIC(18,2),
			 CantidadSM NUMERIC(18,2),
			 CantidadOI NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT LMateriales.IdUnidadFuncional, Det.IdArticulo, 1, Det.IdDetalleLMateriales, Null, Null, Det.IdUnidad, Det.Cantidad, Det.Cantidad, Null, Null
 FROM DetalleLMateriales Det
 LEFT OUTER JOIN LMateriales ON LMateriales.IdLMateriales = Det.IdLMateriales
 WHERE LMateriales.IdUnidadFuncional is not null and (@IdEquipoDestino=-1 or LMateriales.IdUnidadFuncional=@IdEquipoDestino)

 UNION ALL

 SELECT Det.IdEquipoDestino, Det.IdArticulo, 2, Null, Det.IdDetalleSalidaMateriales, Null, Det.IdUnidad, Det.Cantidad*-1, Null, Det.Cantidad, Null
 FROM DetalleSalidasMateriales Det
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 WHERE Det.IdEquipoDestino is not null and (@IdEquipoDestino=-1 or IsNull(Det.IdEquipoDestino,0)=@IdEquipoDestino) and 
		IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and SalidasMateriales.TipoSalida=1

 UNION ALL

 SELECT Det.IdEquipoDestino, Det.IdArticulo, 3, Null, Null, Det.IdOtroIngresoAlmacen, Det.IdUnidad, Det.Cantidad, Null, Null, Det.Cantidad
 FROM DetalleOtrosIngresosAlmacen Det
 LEFT OUTER JOIN OtrosIngresosAlmacen ON Det.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 WHERE Det.IdEquipoDestino is not null and (@IdEquipoDestino=-1 or IsNull(Det.IdEquipoDestino,0)=@IdEquipoDestino) and 
		IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and OtrosIngresosAlmacen.TipoIngreso=3

CREATE TABLE #Auxiliar2 
			(
			 IdEquipoDestino INTEGER,
			 IdArticulo INTEGER,
			 CantidadLM NUMERIC(18,2),
			 CantidadSM NUMERIC(18,2),
			 CantidadOI NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdEquipoDestino, #Auxiliar1.IdArticulo, Sum(IsNull(#Auxiliar1.CantidadLM,0)), Sum(IsNull(#Auxiliar1.CantidadSM,0)), Sum(IsNull(#Auxiliar1.CantidadOI,0))
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdEquipoDestino, #Auxiliar1.IdArticulo

CREATE TABLE #Auxiliar3 
			(
			 IdEquipoDestino INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar3
 SELECT DISTINCT LMateriales.IdUnidadFuncional, Max(IsNull(LMateriales.IdObra,0))
 FROM LMateriales
 GROUP BY LMateriales.IdUnidadFuncional

SET NOCOUNT OFF

DECLARE @vector_X varchar(40),@vector_T varchar(40)

IF @TipoListado='D'
    BEGIN
	IF @ConCostos='NO'
	    BEGIN
		SET @vector_X='00000000111111110033'
		SET @vector_T='000000003C2EF2020000'
	    END
	ELSE
	    BEGIN
		SET @vector_X='00000000111111111133'
		SET @vector_T='000000003C2EF2022300'
	    END
	
	SELECT 
	 #Auxiliar1.IdEquipoDestino as [IdAux1],
	 Obras.NumeroObra as [IdAux2],
	 #Auxiliar1.IdArticulo as [IdAux3],
	 A1.Descripcion as [IdAux4],
	 #Auxiliar1.Orden as [IdAux5],
	 #Auxiliar1.IdDetalleLMateriales as [IdAux6],
	 #Auxiliar1.IdDetalleSalidaMateriales as [IdAux7],
	 #Auxiliar1.IdDetalleOtroIngresoAlmacen as [IdAux8],
	 Obras.NumeroObra as [Obra],
	 A2.Descripcion as [Destino],
	 A1.Codigo as [Codigo],
	 A1.Descripcion as [Material],
	 Case When #Auxiliar1.IdDetalleLMateriales is not null
		Then 'LM '+Substring('00000000',1,8-Len(Convert(varchar,LMateriales.NumeroLMateriales)))+Convert(varchar,LMateriales.NumeroLMateriales)+' Item '+Convert(varchar,DetLM.NumeroItem)
		When #Auxiliar1.IdDetalleSalidaMateriales is not null
		Then 'SM '+Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)
		When #Auxiliar1.IdDetalleSalidaMateriales is not null
		Then 'OT '+Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)
		Else Null
	 End as [Detalle],
	 #Auxiliar1.Cantidad as [Cant.],
	 Unidades.Abreviatura as [Un.],
	 Null as [Stock],
	 Null as [Costo rep.],
	 Null as [Costo total],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN Articulos A1 ON #Auxiliar1.IdArticulo = A1.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON #Auxiliar1.IdEquipoDestino = A2.IdArticulo
	LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN DetalleLMateriales DetLM ON #Auxiliar1.IdDetalleLMateriales = DetLM.IdDetalleLMateriales
	LEFT OUTER JOIN LMateriales ON DetLM.IdLMateriales = LMateriales.IdLMateriales
	LEFT OUTER JOIN DetalleSalidasMateriales DetSM ON #Auxiliar1.IdDetalleSalidaMateriales = DetSM.IdDetalleSalidaMateriales
	LEFT OUTER JOIN SalidasMateriales ON DetSM.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	LEFT OUTER JOIN DetalleOtrosIngresosAlmacen DetOI ON #Auxiliar1.IdDetalleOtroIngresoAlmacen = DetOI.IdDetalleOtroIngresoAlmacen
	LEFT OUTER JOIN OtrosIngresosAlmacen ON DetOI.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
	LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdEquipoDestino = #Auxiliar1.IdEquipoDestino
	LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar3.IdObra
	
	UNION ALL
	
	SELECT 
	 #Auxiliar1.IdEquipoDestino as [IdAux1],
	 Obras.NumeroObra as [IdAux2],
	 #Auxiliar1.IdArticulo as [IdAux3],
	 A1.Descripcion as [IdAux4],
	 9 as [IdAux5],
	 Null as [IdAux6],
	 Null as [IdAux7],
	 Null as [IdAux8],
	 Null as [Obra],
	 Null as [Destino],
	 Null as [Codigo],
	 Null as [Material],
	 'SALDO' as [Detalle],
	 Sum(#Auxiliar1.Cantidad) as [Cant.],
	 Null as [Un.],
	 (Select Sum(IsNull(Stock.CantidadUnidades,0)) From Stock Where Stock.IdArticulo=#Auxiliar1.IdArticulo) as [Stock],
	 Max(A1.CostoReposicion) as [Costo rep.],
	 Sum(#Auxiliar1.Cantidad) * Max(A1.CostoReposicion) as [Costo total],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN Articulos A1 ON #Auxiliar1.IdArticulo = A1.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON #Auxiliar1.IdEquipoDestino = A2.IdArticulo
	LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdEquipoDestino = #Auxiliar1.IdEquipoDestino
	LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar3.IdObra
	GROUP BY #Auxiliar1.IdEquipoDestino, Obras.NumeroObra, #Auxiliar1.IdArticulo, A1.Descripcion
	
	ORDER BY [IdAux2], [IdAux1], [IdAux4], [IdAux3], [IdAux5], [Detalle]
    END
ELSE
    BEGIN
	IF @ConCostos='NO'
	    BEGIN
		SET @vector_X='00001111111110033'
		SET @vector_T='00003C2E222220000'
	    END
	ELSE
	    BEGIN
		SET @vector_X='00001111111111133'
		SET @vector_T='00003C2E222222300'
	    END

	SELECT 
	 #Auxiliar2.IdEquipoDestino as [IdAux1],
	 Obras.NumeroObra as [IdAux2],
	 #Auxiliar2.IdArticulo as [IdAux3],
	 A1.Descripcion as [IdAux4],
	 Obras.NumeroObra as [Obra],
	 A2.Descripcion as [Destino],
	 A1.Codigo as [Codigo],
	 A1.Descripcion as [Material],
	 #Auxiliar2.CantidadLM as [Cant.LM],
	 #Auxiliar2.CantidadSM as [Cant.SM],
	 #Auxiliar2.CantidadOI as [Cant.OI],
	 #Auxiliar2.CantidadLM-(#Auxiliar2.CantidadSM-#Auxiliar2.CantidadOI) as [Saldo],
	 (Select Sum(IsNull(Stock.CantidadUnidades,0)) From Stock Where Stock.IdArticulo=#Auxiliar2.IdArticulo) as [Stock],
	 A1.CostoReposicion as [Costo rep.],
	 (#Auxiliar2.CantidadLM-(#Auxiliar2.CantidadSM-#Auxiliar2.CantidadOI)) * A1.CostoReposicion as [Costo total],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Articulos A1 ON #Auxiliar2.IdArticulo = A1.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON #Auxiliar2.IdEquipoDestino = A2.IdArticulo
	LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdEquipoDestino = #Auxiliar2.IdEquipoDestino
	LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar3.IdObra
	ORDER BY [IdAux2], [IdAux1], [IdAux4], [IdAux3]
    END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3