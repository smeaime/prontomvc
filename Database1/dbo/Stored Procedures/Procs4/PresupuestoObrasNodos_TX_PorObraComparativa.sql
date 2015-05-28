


create  Procedure [dbo].[PresupuestoObrasNodos_TX_PorObraComparativa]

@IdObra int,
@IdPresupuestoObrasNodo int = Null,
@Desde int = Null,
@FechaDesde datetime = Null,
@Hasta int = Null,
@FechaHasta datetime = Null

AS 



SET NOCOUNT ON


/*
--
drop table #Auxiliar1
drop table #Auxiliar2
drop table #Auxiliar3
declare @IdObra int
declare @IdPresupuestoObrasNodo int
declare @Desde int
declare @FechaDesde datetime
declare @Hasta int
declare @FechaHasta datetime
*/


SET @IdPresupuestoObrasNodo=IsNull(@IdPresupuestoObrasNodo,-1)
SET @Desde=IsNull(@Desde,-1)
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @Hasta=IsNull(@Hasta,-1)
SET @FechaHasta=IsNull(@FechaHasta,0)

DECLARE @FechaInicial datetime, @FechaFinal datetime
SET @FechaInicial=IsNull((Select Top 1 FechaInicio From Obras Where IdObra=@IdObra),GetDate())
SET @FechaFinal=IsNull((Select Top 1 FechaEntrega From Obras Where IdObra=@IdObra),GetDate())

DECLARE @vector_X varchar(200), @vector_T varchar(200), @vector_E varchar(2000), @Contador int, @Fecha datetime

CREATE TABLE #Auxiliar1 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 Mes INTEGER,
			 Año INTEGER,
			 Importe NUMERIC(18, 2),
			 ImporteConsumo NUMERIC(18, 2),
			 Fecha DATETIME
			)
INSERT INTO #Auxiliar1 

--se trae el presupuesto
 SELECT po.IdPresupuestoObrasNodo, po.Mes, po.Año, po.Importe, 0, Null
 FROM PresupuestoObrasNodos po 
 LEFT OUTER JOIN DetalleObrasDestinos dod On po.IdPresupuestoObrasNodo=dod.IdDetalleObraDestino
 WHERE dod.IdObra=@IdObra and 
	(@IdPresupuestoObrasNodo=-1 or po.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo) and 
	po.Año<>0 and po.Mes<>0


 UNION ALL
-- despues las facturas
 SELECT Det.IdDetalleObraDestino,Month(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), 
	Year(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), 0, Det.Importe*cp.CotizacionMoneda, 
	IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
 LEFT OUTER JOIN DetalleRecepciones DetRec ON DetRec.IdDetalleRecepcion=Det.IdDetalleRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=Det.IdDetallePedido
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento=IsNull(DetRec.IdDetalleRequerimiento,DetPed.IdDetalleRequerimiento)
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Det.IdDetalleObraDestino is not null and IsNull(DetObra.ADistribuir,'NO')='NO' and Det.IdObra=@IdObra and 
	(@IdPresupuestoObrasNodo=-1 or IsNull(Det.IdDetalleObraDestino,0)=@IdPresupuestoObrasNodo) and 
	IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' -- and DetReq.IdPresupuestoObrasNodo is null

 UNION ALL
-- y los remitos
 SELECT Det.IdDetalleObraDestino, 
	Month(SalidasMateriales.FechaSalidaMateriales), Year(SalidasMateriales.FechaSalidaMateriales), 
	0, Det.CostoUnitario*Det.Cantidad, SalidasMateriales.FechaSalidaMateriales
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Det.IdDetalleObraDestino is not null and Det.IdObra=@IdObra and 
	(@IdPresupuestoObrasNodo=-1 or Det.IdDetalleObraDestino=@IdPresupuestoObrasNodo) and 
	IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' 

CREATE TABLE #Auxiliar2 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 Mes INTEGER,
			 Año INTEGER,
			 Importe NUMERIC(18, 2),
			 ImporteConsumo NUMERIC(18, 2),
			 Desvio NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT IdPresupuestoObrasNodo, Mes, Año, 
	Sum(IsNull(#Auxiliar1.Importe,0)), Sum(IsNull(#Auxiliar1.ImporteConsumo,0)), 0
 FROM #Auxiliar1
 WHERE (#Auxiliar1.Fecha is null or 
	((@Desde=-1 or (@Desde=0 and #Auxiliar1.Fecha>=@FechaDesde)) and 
	 (@Hasta=-1 or (@Hasta=0 and #Auxiliar1.Fecha<=@FechaHasta))))
 GROUP BY IdPresupuestoObrasNodo, Mes, Año

UPDATE #Auxiliar2 
SET Desvio=(Importe-ImporteConsumo)/Importe*100
WHERE Importe<>0

CREATE TABLE #Auxiliar3 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 Etapa VARCHAR(200)
			)
INSERT INTO #Auxiliar3 
 SELECT DISTINCT #Auxiliar2.IdPresupuestoObrasNodo,
	Substring(IsNull(dod.Destino+' / ','')+Convert(varchar(200),IsNull(dod.Detalle,'')),1,200)
 FROM #Auxiliar2
 LEFT OUTER JOIN DetalleObrasDestinos dod On #Auxiliar2.IdPresupuestoObrasNodo=dod.IdDetalleObraDestino

SET NOCOUNT OFF


SELECT 
 0 as [IdAux], 
 Etapa as [Etapa],
 IdPresupuestoObrasNodo as [IdAux1], 

 (Select Top 1 #Auxiliar2.Importe From #Auxiliar2 
	Where #Auxiliar2.IdPresupuestoObrasNodo=#Auxiliar3.IdPresupuestoObrasNodo and 
		#Auxiliar2.Mes=Month(DateAdd(m,0,@FechaInicial)) and #Auxiliar2.Año=Year(DateAdd(m,0,@FechaInicial))) as [00-P],

 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3




--Mi código





DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3



