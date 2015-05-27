


create  Procedure [dbo].[PresupuestoObrasNodos_TX_PorObraComparativa_Detalles]

@IdObra int,
@IdPresupuestoObrasNodo int = Null,
@CodigoPresupuesto int = Null

AS 

SET NOCOUNT ON

/*
drop table #Auxiliar1
drop table #Auxiliar2
drop table #Auxiliar3
declare @IdObra int
declare @IdPresupuestoObrasNodo int
declare @CodigoPresupuesto int
*/

declare @LinajeObra varchar(255)
select @LinajeObra=lineage+ Ltrim(Str(P.IdPresupuestoObrasNodo,6,0)) + '/' 
from PresupuestoObrasNodos P where idObra=@IdObra and tiponodo=1
--set  @LinajeObra='/41/'


SET @IdPresupuestoObrasNodo=IsNull(@IdPresupuestoObrasNodo,-1)
SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)





CREATE TABLE #Auxiliar1 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 IdArticulo INTEGER,
			 IdRubro INTEGER,
			 IdUnidad INTEGER,
			 CantidadPresupuesto NUMERIC(18, 2),
			 ImportePresupuesto NUMERIC(18, 2),
			 CantidadConsumo NUMERIC(18, 2),
			 ImporteConsumo NUMERIC(18, 2),
			 Fecha DATETIME
			)

INSERT INTO #Auxiliar1 

 SELECT P.IdPresupuestoObrasNodo,P.IdArticulo,P.IdRubro,P.IdUnidad,
 	PxQ.cantidad,--dbo.fPresupuestoObrasNodos_TX_TotalPorNodoRecursiva(idPresupuestoObrasNodo,@CodigoPresupuesto) as total,
	dbo.fPresupuestoObrasNodos_TX_ImportePorNodoRecursiva(P.idPresupuestoObrasNodo,@CodigoPresupuesto) as Importerec,
	0,0,''	
 FROM PresupuestoObrasNodos P
	left outer join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
		p.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
		and CodigoPresupuesto=@CodigoPresupuesto
 LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
 LEFT OUTER JOIN Articulos A ON P.IdArticulo=A.IdArticulo
 LEFT OUTER JOIN Unidades U ON P.idUnidad=U.IdUnidad
 LEFT OUTER JOIN Rubros R ON P.IdRubro=R.IdRubro
 where left(lineage,len(@LinajeObra))=@LinajeObra --que sea de la obra

UNION ALL

 SELECT Det.IdDetalleObraDestino, Det.IdArticulo, '', IsNull(DetRec.IdUnidad,Articulos.IdUnidad), 
	0, 0, Det.Cantidad, Det.Importe*cp.CotizacionMoneda, IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
 LEFT OUTER JOIN DetalleRecepciones DetRec ON DetRec.IdDetalleRecepcion=Det.IdDetalleRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=Det.IdDetallePedido
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento=IsNull(DetRec.IdDetalleRequerimiento,DetPed.IdDetalleRequerimiento)
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Det.IdDetalleObraDestino is not null and IsNull(DetObra.ADistribuir,'NO')='NO' and Det.IdObra=@IdObra and 
	(@IdPresupuestoObrasNodo=-1 or IsNull(Det.IdDetalleObraDestino,0)=@IdPresupuestoObrasNodo) and 
	IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' -- and DetReq.IdDetalleObraDestino is null

 UNION ALL

 SELECT Det.IdDetalleObraDestino, Det.IdArticulo, '', Det.IdUnidad,
	0, 0, Det.Cantidad, Det.CostoUnitario*Det.Cantidad, SalidasMateriales.FechaSalidaMateriales
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleObrasDestinos DetObra ON DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Det.IdDetalleObraDestino is not null and Det.IdObra=@IdObra and 
	(@IdPresupuestoObrasNodo=-1 or Det.IdDetalleObraDestino=@IdPresupuestoObrasNodo)  
--confirmar que la siguiente linea no tiene mayor influencia
--	and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' 



CREATE TABLE #Auxiliar2 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 IdArticulo INTEGER,
			 IdRubro INTEGER,
			 IdUnidad INTEGER,
			 CantidadPresupuesto NUMERIC(18, 2),
			 ImportePresupuesto NUMERIC(18, 2),
			 CantidadConsumo NUMERIC(18, 2),
			 ImporteConsumo NUMERIC(18, 2),
			 DesvioCantidad NUMERIC(18, 2),
			 DesvioImporte NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT IdPresupuestoObrasNodo, '','','',-- IdArticulo, IdRubro, '',--IdUnidad, 
	Sum(IsNull(CantidadPresupuesto,0)), Sum(IsNull(ImportePresupuesto,0)), 
	Sum(IsNull(CantidadConsumo,0)), Sum(IsNull(ImporteConsumo,0)), 0, 0
 FROM #Auxiliar1
 GROUP BY IdPresupuestoObrasNodo --,  IdArticulo, IdRubro, IdUnidad --la linea decisiva


UPDATE #Auxiliar2 
SET ImportePresupuesto=0
WHERE ImportePresupuesto<0


UPDATE #Auxiliar2 
SET DesvioCantidad=(CantidadPresupuesto-CantidadConsumo)/CantidadPresupuesto*100
WHERE CantidadPresupuesto<>0

UPDATE #Auxiliar2 
SET DesvioImporte=(ImportePresupuesto-ImporteConsumo)/ImportePresupuesto*100
WHERE ImportePresupuesto<>0



SET NOCOUNT OFF

DECLARE @vector_X varchar(30), @vector_T varchar(30)
SET @vector_X='01111111166666633'
SET @vector_T='0399'
IF @IdPresupuestoObrasNodo=-1
	SET @vector_T=@vector_T+'9'
ELSE
	SET @vector_T=@vector_T+'F'

SET @vector_T=@vector_T+'2E133333300'

SELECT 
 0 as [IdAux], 
 Obras.NumeroObra as [Obra],
 #Auxiliar2.idPresupuestoObrasNodo as [IdAux1], 
 Substring(IsNull(dod.Destino+' / ','')+Convert(varchar(200),IsNull(dod.Detalle,'')),1,200) as [Etapa],
 R.Descripcion as [Rubro],
articulos.idarticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Material],
 Unidades.Abreviatura as [Un.],
 #Auxiliar2.CantidadPresupuesto as [Cant.Teor.],
 #Auxiliar2.CantidadConsumo as [Cant.Real],
 #Auxiliar2.DesvioCantidad as [DesvioC],
 #Auxiliar2.ImportePresupuesto as [Imp.Teor.],
 #Auxiliar2.ImporteConsumo as [Imp.Real],
 #Auxiliar2.DesvioImporte as [DesvioI],
	Obras.Descripcion as DescripcionObra,
	Articulos.Descripcion as DescripcionArticulo,
	Unidades.Descripcion as DescripcionUnidad,
	R.Descripcion as DescripcionRubro,
Lineage+ Ltrim(Str(pon.IdPresupuestoObrasNodo,6,0)) + '/'  as [Titulo],
pon.TipoNodo,
pon.Depth,
pon.descripcion,
pon.cantidadavanzada,
ponart.descripcion as descart,
ponrub.descripcion as descrub,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN DetalleObrasDestinos dod ON #Auxiliar2.IdPresupuestoObrasNodo=dod.IdDetalleObraDestino
LEFT OUTER JOIN PresupuestoObrasNodos pon ON #Auxiliar2.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
LEFT OUTER JOIN Articulos ponart ON pon.idArticulo=ponart.IdArticulo
LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo=Articulos.IdArticulo
LEFT OUTER JOIN Rubros R ON #Auxiliar2.IdRubro=R.IdRubro
LEFT OUTER JOIN Rubros ponrub ON pon.idRubro=ponrub.IdRubro
LEFT OUTER JOIN Unidades ON #Auxiliar2.IdUnidad=Unidades.IdUnidad
LEFT OUTER JOIN Obras ON dod.IdObra=Obras.IdObra
where left(lineage,len(@LinajeObra))=@LinajeObra --que sea de la obra
order by Lineage+ Ltrim(Str(pon.IdPresupuestoObrasNodo,6,0)) + '/'


DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2



