




create  Procedure [dbo].[PresupuestoObrasNodos_TX_PorObraConsumos]

@IdObra int,
@IdDetalleObraDestino int = Null,
@IdPresupuestoObraRubro int = Null,
@SoloPendientes varchar(2) = Null,
@ConConsumosAsignados varchar(2) = Null,
@TipoConsumo int = Null

AS 


SET NOCOUNT ON

SET @IdDetalleObraDestino=IsNull(@IdDetalleObraDestino,-1)
SET @IdPresupuestoObraRubro=IsNull(@IdPresupuestoObraRubro,-1)
SET @SoloPendientes=IsNull(@SoloPendientes,'NO')
SET @ConConsumosAsignados=IsNull(@ConConsumosAsignados,'NO')
SET @TipoConsumo=IsNull(@TipoConsumo,-1)



/*
--codigo debug
drop table #Auxiliar1
declare @IdObra int
declare @IdDetalleObraDestino int
declare @IdPresupuestoObraRubro int
declare @SoloPendientes varchar(2)
declare @ConConsumosAsignados varchar(2)
declare @TipoConsumo int
SET @IdObra=1
SET @IdDetalleObraDestino=-1
SET @IdPresupuestoObraRubro=-1
SET @SoloPendientes='NO'
SET @ConConsumosAsignados='NO'
SET @TipoConsumo=-1
--fin codigo debug
*/



IF @TipoConsumo=-1 
	SET @TipoConsumo=3


CREATE TABLE #Auxiliar1 
			(
			 IdPresupuestoObraConsumo INTEGER,
			 TipoMovimiento INTEGER,
			 IdArticulo INTEGER,
			 IdObra INTEGER,
			 IdDetalleObraDestino INTEGER,
			 IdPresupuestoObraRubro INTEGER,
			 Detalle VARCHAR(80),
			 Mes INTEGER,
			 Año INTEGER,
			 Cantidad NUMERIC(18, 2),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 0, 21, Det.IdArticulo, Det.IdObra, Det.IdDetalleObraDestino, IsNull(Det.IdPresupuestoObraRubro,0), Null, 
	Month(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), 
	Year(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), Det.Cantidad, Det.Importe
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
 LEFT OUTER JOIN DetalleRecepciones DetRec ON DetRec.IdDetalleRecepcion=Det.IdDetalleRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=Det.IdDetallePedido
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento=IsNull(DetRec.IdDetalleRequerimiento,DetPed.IdDetalleRequerimiento)
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Det.IdDetalleObraDestino is not null and IsNull(DetObra.ADistribuir,'NO')='SI' and @ConConsumosAsignados='NO' and 
	Det.IdObra=@IdObra and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' -- and DetReq.IdDetalleObraDestino is null

 UNION ALL

 SELECT 0, 22, Det.IdArticulo, Det.IdObra, Det.IdDetalleObraDestino, Det.IdPresupuestoObraRubro, 'CONSUMO ASIGNADO', 
	Month(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), 
	Year(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), Det.Cantidad*-1, Det.Importe*-1
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
 LEFT OUTER JOIN DetalleRecepciones DetRec ON DetRec.IdDetalleRecepcion=Det.IdDetalleRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=Det.IdDetallePedido
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento=IsNull(DetRec.IdDetalleRequerimiento,DetPed.IdDetalleRequerimiento)
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Det.IdDetalleObraDestino is not null and IsNull(DetObra.ADistribuir,'NO')='NO' and @ConConsumosAsignados='SI' and 
	Det.IdObra=@IdObra and (@IdDetalleObraDestino=-1 or Det.IdDetalleObraDestino=@IdDetalleObraDestino) and 
	IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' -- and DetReq.IdDetalleObraDestino is null

 UNION ALL

 SELECT 0, 51, Det.IdArticulo, Det.IdObra, Det.IdDetalleObraDestino, Det.IdPresupuestoObraRubro, 'CONSUMO ASIGNADO', 
	Month(SalidasMateriales.FechaSalidaMateriales), Year(SalidasMateriales.FechaSalidaMateriales), 
	Det.Cantidad*-1, Det.CostoUnitario*Det.Cantidad*-1
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Det.IdDetalleObraDestino is not null and Det.IdObra=@IdObra and @ConConsumosAsignados='SI' and 
	(@IdDetalleObraDestino=-1 or Det.IdDetalleObraDestino=@IdDetalleObraDestino) and 
	IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' 

 UNION ALL

 SELECT 0, 31, -2, Det.IdObra, 0, 0, 'ASIENTO', Month(Asientos.FechaAsiento), 
	Year(Asientos.FechaAsiento), 0, Sum(IsNull(Det.Debe,0))
 FROM DetalleAsientos Det 
 LEFT OUTER JOIN Asientos ON Det.IdAsiento=Asientos.IdAsiento
 WHERE IsNull(Asientos.AsignarAPresupuestoObra,'NO')='SI' and @ConConsumosAsignados='NO' and 
	Det.IdObra=@IdObra and IsNull(Det.Debe,0)>0
 GROUP BY Det.IdObra, Asientos.FechaAsiento








IF @SoloPendientes='SI'
    BEGIN
	CREATE TABLE #Auxiliar2 
				(
				 IdPresupuestoObraConsumo INTEGER,
				 IdArticulo INTEGER,
				 IdObra INTEGER,
				 IdDetalleObraDestino INTEGER,
				 IdPresupuestoObraRubro INTEGER,
				 Cantidad NUMERIC(18, 2),
				 Importe NUMERIC(18, 2)
				)
	INSERT INTO #Auxiliar2 
	 SELECT 0, Det.IdArticulo, Det.IdObra, Det.IdDetalleObraDestino, 0, Det.Cantidad, Det.Importe
	 FROM DetalleComprobantesProveedores Det 
	 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
	 LEFT OUTER JOIN DetalleRecepciones DetRec ON DetRec.IdDetalleRecepcion=Det.IdDetalleRecepcion
	 LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=Det.IdDetallePedido
	 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento=IsNull(DetRec.IdDetalleRequerimiento,DetPed.IdDetalleRequerimiento)
	 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
	 WHERE Det.IdDetalleObraDestino is not null and IsNull(DetObra.ADistribuir,'NO')='SI' and Det.IdObra=@IdObra and 
		IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' -- and DetReq.IdDetalleObraDestino is null 

	 UNION ALL

	 SELECT 0, -2, Det.IdObra, 0, 0, 0, Sum(IsNull(Det.Debe,0))
	 FROM DetalleAsientos Det 
	 LEFT OUTER JOIN Asientos ON Det.IdAsiento=Asientos.IdAsiento
	 WHERE IsNull(Asientos.AsignarAPresupuestoObra,'NO')='SI' and Det.IdObra=@IdObra and IsNull(Det.Debe,0)>0
	 GROUP BY Det.IdObra, Asientos.FechaAsiento
	
	
	CREATE TABLE #Auxiliar3 (IdArticulo INTEGER, Importe NUMERIC(18, 2))
	INSERT INTO #Auxiliar3 
	 SELECT #Auxiliar2.IdArticulo, Sum(IsNull(#Auxiliar2.Importe,0))
	 FROM #Auxiliar2 
	 GROUP BY #Auxiliar2.IdArticulo

	DELETE #Auxiliar3 WHERE Importe=0
	DELETE #Auxiliar1 WHERE Not Exists(Select Top 1 #Auxiliar3.IdArticulo From #Auxiliar3 
						Where #Auxiliar1.IdArticulo=#Auxiliar3.IdArticulo and 
							#Auxiliar1.TipoMovimiento in(11,21,31,41,42))

	DROP TABLE #Auxiliar2
	DROP TABLE #Auxiliar3
    END

CREATE TABLE #Auxiliar4 
			(
			 IdDetalleObraDestino INTEGER,
			 IdPresupuestoObraRubro INTEGER,
			 Etapa VARCHAR(200),
			 Rubro VARCHAR(50)
			)
INSERT INTO #Auxiliar4 
 SELECT DISTINCT #Auxiliar1.IdDetalleObraDestino, #Auxiliar1.IdPresupuestoObraRubro, 
	Substring(IsNull(dod.Destino+' / ','')+Convert(varchar(200),IsNull(dod.Detalle,'')),1,200), ''
 FROM #Auxiliar1
 LEFT OUTER JOIN DetalleObrasDestinos dod On #Auxiliar1.IdDetalleObraDestino=dod.IdDetalleObraDestino
-- LEFT OUTER JOIN PresupuestoObrasNodosRubros por On #Auxiliar1.IdPresupuestoObraRubro=por.IdPresupuestoObraRubro

SET NOCOUNT OFF


DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111111133'
--SET @vector_T='029999999999F0C2E24900'
SET @vector_T='025555999999F0C2E24900'

IF @ConConsumosAsignados='NO'
    BEGIN
	SELECT
	 0 as [IdAux],
	 Obras.NumeroObra as [Obra],
	 Obras.NumeroObra as [IdAux0],
	 #Auxiliar1.IdArticulo as [IdAux1],
	 Articulos.Descripcion as [IdAux2],
	 1 as [IdAux3],
	 #Auxiliar4.Etapa as [IdAux4],
	 Null as [IdAux5],
	 #Auxiliar1.IdDetalleObraDestino as [IdAux6],
	 #Auxiliar1.IdPresupuestoObraRubro as [IdAux7],
	 Null as [IdAux8],
	 Convert(varchar,#Auxiliar1.Año)+
		Substring('00',1,2-Len(Convert(varchar,#Auxiliar1.Mes)))+Convert(varchar,#Auxiliar1.Mes) as [IdAux9],
	 #Auxiliar4.Etapa as [Etapa],
	 '' as [Rubro],
	 Articulos.Descripcion as [Material],
	 #Auxiliar1.Detalle as [Detalle],
	 Convert(varchar,#Auxiliar1.Mes)+'/'+Convert(varchar,#Auxiliar1.Año) as [Periodo],
	 Sum(IsNull(#Auxiliar1.Cantidad,0)) as [Cantidad],
	 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
	 1 as [IdAux10],
	pon.Descripcion,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
	LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.IdDetalleObraDestino=#Auxiliar1.IdDetalleObraDestino
--	LEFT OUTER JOIN PresupuestoObrasNodosRubros por On por.IdPresupuestoObraRubro=#Auxiliar1.IdPresupuestoObraRubro
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN PresupuestoObrasNodos pon ON #Auxiliar1.IdDetalleObraDestino = pon.IdPresupuestoObrasNodo
	WHERE #Auxiliar1.IdPresupuestoObraConsumo=0 and #Auxiliar1.TipoMovimiento in(11,21,31,41,42) and 
		(@TipoConsumo=3 )
	GROUP BY Obras.NumeroObra, #Auxiliar1.IdArticulo, Articulos.Descripcion, #Auxiliar4.Etapa, 
		#Auxiliar1.IdDetalleObraDestino, #Auxiliar1.Mes, #Auxiliar1.Año, #Auxiliar1.Detalle, 
		#Auxiliar1.IdPresupuestoObraRubro,pon.descripcion
	
	UNION ALL
	
	SELECT
	 0 as [IdAux],
	 Obras.NumeroObra as [Obra],
	 Obras.NumeroObra as [IdAux0],
	 #Auxiliar1.IdArticulo as [IdAux1],
	 Articulos.Descripcion as [IdAux2],
	 2 as [IdAux3],
	 #Auxiliar4.Etapa as [IdAux4],
	 '' as [IdAux5],
	 #Auxiliar1.IdDetalleObraDestino as [IdAux6],
	 #Auxiliar1.IdPresupuestoObraRubro as [IdAux7],
	 #Auxiliar1.IdPresupuestoObraConsumo as [IdAux8],
	 Convert(varchar,#Auxiliar1.Año)+
		Substring('00',1,2-Len(Convert(varchar,#Auxiliar1.Mes)))+Convert(varchar,#Auxiliar1.Mes) as [IdAux9],
	 #Auxiliar4.Etapa as [Etapa],
	 '' as [Rubro],
	 Articulos.Descripcion as [Material],
	 #Auxiliar1.Detalle as [Detalle],
	 Convert(varchar,#Auxiliar1.Mes)+'/'+Convert(varchar,#Auxiliar1.Año) as [Periodo],
	 Sum(IsNull(#Auxiliar1.Cantidad,0)) as [Cantidad],
	 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
	 1 as [IdAux10],
	pon.Descripcion,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
--	LEFT OUTER JOIN PresupuestoObrasNodosConsumos poc ON poc.IdPresupuestoObraConsumo=#Auxiliar1.IdPresupuestoObraConsumo
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
	LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.IdDetalleObraDestino=#Auxiliar1.IdDetalleObraDestino
--	LEFT OUTER JOIN PresupuestoObrasNodosRubros por ON por.IdPresupuestoObraRubro=poc.IdPresupuestoObraRubro
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN PresupuestoObrasNodos pon ON #Auxiliar1.IdDetalleObraDestino = pon.IdPresupuestoObrasNodo
	WHERE #Auxiliar1.IdPresupuestoObraConsumo<>0 and #Auxiliar1.TipoMovimiento in(11,21,31,41,42) and 
		(@TipoConsumo=3)
	GROUP BY Obras.NumeroObra, #Auxiliar1.IdArticulo, Articulos.Descripcion, #Auxiliar4.Etapa, 
		#Auxiliar1.IdDetalleObraDestino, #Auxiliar1.IdPresupuestoObraRubro, 		#Auxiliar1.IdPresupuestoObraConsumo, #Auxiliar1.Mes, #Auxiliar1.Año, #Auxiliar1.Detalle,pon.descripcion
	
	UNION ALL
	
	SELECT
	 0 as [IdAux],
	 Null as [Obra],
	 Obras.NumeroObra as [IdAux0],
	 #Auxiliar1.IdArticulo as [IdAux1],
	 Articulos.Descripcion as [IdAux2],
	 3 as [IdAux3],
	 Null as [IdAux4],
	 Null as [IdAux5],
	 Null as [IdAux6],
	 Null as [IdAux7],
	 Null as [IdAux8],
	 Null as [IdAux9],
	 Null as [Etapa],
	 Null as [Rubro],
	 Null as [Material],
	 Null as [Detalle],
	 Null as [Periodo],
	 Sum(IsNull(#Auxiliar1.Cantidad,0)) as [Cantidad],
	 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
	 1 as [IdAux10],
	Null as Descripcion,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
--	LEFT OUTER JOIN PresupuestoObrasNodosRubros por ON por.IdPresupuestoObraRubro=#Auxiliar1.IdPresupuestoObraRubro
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	WHERE #Auxiliar1.TipoMovimiento in(11,21,31,41,42) and 
		(@TipoConsumo=3)
	GROUP BY Obras.NumeroObra, #Auxiliar1.IdArticulo, Articulos.Descripcion
	
	UNION ALL
	
	SELECT
	 0 as [IdAux],
	 Null as [Obra],
	 Obras.NumeroObra as [IdAux0],
	 #Auxiliar1.IdArticulo as [IdAux1],
	 Articulos.Descripcion as [IdAux2],
	 4 as [IdAux3],
	 Null as [IdAux4],
	 Null as [IdAux5],
	 Null as [IdAux6],
	 Null as [IdAux7],
	 Null as [IdAux8],
	 Null as [IdAux9],
	 Null as [Etapa],
	 Null as [Rubro],
	 Null as [Material],
	 Null as [Detalle],
	 Null as [Periodo],
	 Null as [Cantidad],
	 Null as [Importe],
	 1 as [IdAux10],
	Null as Descripcion,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
--	LEFT OUTER JOIN PresupuestoObrasNodosRubros por ON por.IdPresupuestoObraRubro=#Auxiliar1.IdPresupuestoObraRubro
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	WHERE #Auxiliar1.TipoMovimiento in(11,21,31,41,42) and 
		(@TipoConsumo=3)
	GROUP BY Obras.NumeroObra, #Auxiliar1.IdArticulo, Articulos.Descripcion
	
	UNION ALL
	
	SELECT
	 0 as [IdAux],
	 Obras.NumeroObra as [Obra],
	 Obras.NumeroObra as [IdAux0],
	 #Auxiliar1.IdArticulo as [IdAux1],
	 Articulos.Descripcion as [IdAux2],
	 1 as [IdAux3],
	 #Auxiliar4.Etapa as [IdAux4],
	 Null as [IdAux5],
	 #Auxiliar1.IdDetalleObraDestino as [IdAux6],
	 #Auxiliar1.IdPresupuestoObraRubro as [IdAux7],
	 #Auxiliar1.IdPresupuestoObraConsumo as [IdAux8],
	 Convert(varchar,#Auxiliar1.Año)+
		Substring('00',1,2-Len(Convert(varchar,#Auxiliar1.Mes)))+Convert(varchar,#Auxiliar1.Mes) as [IdAux9],
	 #Auxiliar4.Etapa as [Etapa],
	 '' as [Rubro],
	 Articulos.Descripcion as [Material],
	 #Auxiliar1.Detalle as [Detalle],
	 Convert(varchar,#Auxiliar1.Mes)+'/'+Convert(varchar,#Auxiliar1.Año) as [Periodo],
	 Sum(IsNull(#Auxiliar1.Cantidad,0)) as [Cantidad],
	 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
	 2 as [IdAux10],
	pon.descripcion,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
	LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.IdDetalleObraDestino=#Auxiliar1.IdDetalleObraDestino
--	LEFT OUTER JOIN PresupuestoObrasNodosRubros por On por.IdPresupuestoObraRubro=#Auxiliar1.IdPresupuestoObraRubro
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN PresupuestoObrasNodos pon ON #Auxiliar1.IdDetalleObraDestino = pon.IdPresupuestoObrasNodo
	WHERE #Auxiliar1.TipoMovimiento not in(11,21,31,41,42) and 
		(@TipoConsumo=3)
	GROUP BY Obras.NumeroObra, #Auxiliar1.IdArticulo, Articulos.Descripcion, #Auxiliar4.Etapa, 
		#Auxiliar1.IdDetalleObraDestino, #Auxiliar1.Mes, #Auxiliar1.Año, #Auxiliar1.Detalle, 
		#Auxiliar1.IdPresupuestoObraRubro, #Auxiliar1.IdPresupuestoObraConsumo,pon.descripcion
	
	ORDER BY [IdAux10], [IdAux2], [IdAux1], [IdAux3], [IdAux9]
    END
ELSE
    BEGIN
	SELECT
	 0 as [IdAux],
	 Obras.NumeroObra as [Obra],
	 Obras.NumeroObra as [IdAux0],
	 #Auxiliar1.IdArticulo as [IdAux1],
	 Articulos.Descripcion as [IdAux2],
	 2 as [IdAux3],
	 #Auxiliar4.Etapa as [IdAux4],
	 '' as [IdAux5],
	 #Auxiliar1.IdDetalleObraDestino as [IdAux6],
	 #Auxiliar1.IdPresupuestoObraRubro as [IdAux7],
	 0 as [IdAux8],
	 Convert(varchar,#Auxiliar1.Año)+
		Substring('00',1,2-Len(Convert(varchar,#Auxiliar1.Mes)))+Convert(varchar,#Auxiliar1.Mes) as [IdAux9],
	 #Auxiliar4.Etapa as [Etapa],
	 '' as [Rubro],
	 Articulos.Descripcion as [Material],
	 Null as [Detalle],
	 Convert(varchar,#Auxiliar1.Mes)+'/'+Convert(varchar,#Auxiliar1.Año) as [Periodo],
	 Sum(IsNull(#Auxiliar1.Cantidad,0)*-1) as [Cantidad],
	 Sum(IsNull(#Auxiliar1.Importe,0)*-1) as [Importe],
	 1 as [IdAux10],
	pon.descripcion,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1 
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
	LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.IdDetalleObraDestino=#Auxiliar1.IdDetalleObraDestino
--	LEFT OUTER JOIN PresupuestoObrasNodosRubros por ON por.IdPresupuestoObraRubro=#Auxiliar1.IdPresupuestoObraRubro
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN PresupuestoObrasNodos pon ON #Auxiliar1.IdDetalleObraDestino = pon.IdPresupuestoObrasNodo
	WHERE (@TipoConsumo=3)
	GROUP BY Obras.NumeroObra, #Auxiliar1.IdArticulo, Articulos.Descripcion, #Auxiliar4.Etapa, 
		#Auxiliar1.IdDetalleObraDestino, #Auxiliar1.IdPresupuestoObraRubro, 		#Auxiliar1.Mes, #Auxiliar1.Año,pon.descripcion
	ORDER BY [IdAux10], [IdAux2], [IdAux1], [IdAux3], [IdAux9]
    END








DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar4



