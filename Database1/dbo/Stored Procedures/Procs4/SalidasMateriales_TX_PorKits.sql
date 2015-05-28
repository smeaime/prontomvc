CREATE  Procedure [dbo].[SalidasMateriales_TX_PorKits]

@FechaDesde datetime,
@FechaHasta datetime,
@IdObra int = Null,
@IdDeposito int = Null,
@IdUbicacion int = Null

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @IdDeposito=IsNull(@IdDeposito,-1)
SET @IdUbicacion=IsNull(@IdUbicacion,-1)

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

CREATE TABLE #Auxiliar 
			(
			 IdDetalleSalidaMateriales INTEGER, 
			 Tipo VARCHAR(1), 
			 IdArticulo INTEGER, 
			 IdUnidad INTEGER, 
			 Cantidad NUMERIC(18,2) 
			)
INSERT INTO #Auxiliar
 SELECT dsm.IdDetalleSalidaMateriales, '1', dsm.IdArticulo, dsm.IdUnidad, dsm.Cantidad
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales sm ON sm.IdSalidaMateriales=dsm.IdSalidaMateriales
 LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion=dsm.IdUbicacion
 WHERE IsNull(sm.Anulada,'NO')<>'SI' and sm.FechaSalidaMateriales Between @FechaDesde and @FechaHasta and 
	(@IdObra=-1 or dsm.IdObra=@IdObra) and 
	(@IdDeposito=-1 or Ubicaciones.IdDeposito=@IdDeposito) and 
	(@IdUbicacion=-1 or dsm.IdUbicacion=@IdUbicacion) and 
	IsNull(dsm.DescargaPorKit,'')='SI' 

INSERT INTO #Auxiliar
 SELECT dsm.IdDetalleSalidaMateriales, '2', cv.IdArticulo, cv.IdUnidad, dsm.Cantidad * cv.Cantidad
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales sm ON sm.IdSalidaMateriales=dsm.IdSalidaMateriales
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=dsm.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=sm.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion=dsm.IdUbicacion
 WHERE IsNull(sm.Anulada,'NO')<>'SI' and sm.FechaSalidaMateriales Between @FechaDesde and @FechaHasta and 
	(@IdObra=-1 or dsm.IdObra=@IdObra) and 
	(@IdDeposito=-1 or Ubicaciones.IdDeposito=@IdDeposito) and 
	(@IdUbicacion=-1 or dsm.IdUbicacion=@IdUbicacion) and 
	IsNull(dsm.DescargaPorKit,'')='SI'  

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00001111111111111133'
SET @vector_T='000031C41E20550FD800'

SELECT 
 #Auxiliar.IdDetalleSalidaMateriales as [IdAux1],
 #Auxiliar.Tipo as [IdAux2],
 A1.Codigo as [IdAux3],
 0 as [IdAux4],
 Case When #Auxiliar.Tipo='1' Then '1.PLANTA' Else '2.INSUMO' End as [Tipo],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Articulo],
 sm.FechaSalidaMateriales as [Fecha],
 Case When sm.TipoSalida=0 Then 'Salida a fabrica' When sm.TipoSalida=1 Then 'Salida a obra' When sm.TipoSalida=2 Then 'A Proveedor' Else sm.ClaveTipoSalida End as [Documento],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(sm.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(sm.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,sm.NumeroSalidaMateriales)))+Convert(varchar,sm.NumeroSalidaMateriales) as [Numero], 
 #Auxiliar.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Un.],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=#Auxiliar.IdArticulo) as [Stock],
 A1.CostoReposicion as [Costo Rep.],
 Ubicaciones.Descripcion as [Ubicacion],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 A2.Descripcion as [Equipo destino],
 sm.Observaciones as [Observacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN DetalleSalidasMateriales dsm ON dsm.IdDetalleSalidaMateriales=#Auxiliar.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales sm ON sm.IdSalidaMateriales=dsm.IdSalidaMateriales
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo=#Auxiliar.IdArticulo
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo=dsm.IdEquipoDestino
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar.IdUnidad
LEFT OUTER JOIN Obras ON Obras.IdObra=dsm.IdObra
LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion=dsm.IdUbicacion

UNION ALL

SELECT 
 0 as [IdAux1],
 #Auxiliar.Tipo as [IdAux2],
 A1.Codigo as [IdAux3],
 2 as [IdAux4],
 Case When #Auxiliar.Tipo='1' Then '1.PLANTA' Else '2.INSUMO' End as [Tipo],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Articulo],
 Null as [Fecha],
 Null as [Documento],
 'TOTAL' as [Numero], 
 Sum(IsNull(#Auxiliar.Cantidad,0)) as [Cantidad],
 Max(Unidades.Abreviatura) as [Un.],
 Null as [Stock],
 Null as [Costo Rep.],
 Null as [Ubicacion],
 Null as [Obra],
 Null as [Equipo destino],
 Null as [Observacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN DetalleSalidasMateriales dsm ON dsm.IdDetalleSalidaMateriales=#Auxiliar.IdDetalleSalidaMateriales
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo=#Auxiliar.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar.IdUnidad
GROUP BY #Auxiliar.Tipo, A1.Codigo, A1.Descripcion

ORDER BY [IdAux2], [IdAux3], [IdAux4], [Fecha]

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar501
DROP TABLE #Auxiliar502
