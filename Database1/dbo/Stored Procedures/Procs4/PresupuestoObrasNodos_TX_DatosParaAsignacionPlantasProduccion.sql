CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_DatosParaAsignacionPlantasProduccion]

@IdObra int,
@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @ConsumosTotales numeric(18,2), @ProductoDistribuido numeric(18,2)

-- PRIMERO CALCULO EL COSTO TOTAL DE LA PLANTA / AUXILIAR EN EL PERIODO DEFINIDO POR EL USUARIO.

CREATE TABLE #Auxiliar1 (Cantidad NUMERIC(18, 2), Importe NUMERIC(18, 2))
INSERT INTO #Auxiliar1 
 SELECT Det.Cantidad, Det.Importe*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON Det.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
 WHERE IsNull(Det.IdPresupuestoObrasNodo,0)>0 and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' and 
	(@IdObra=-1 or pon.IdObra=@IdObra) and 
	IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante) between @FechaDesde and @FechaHasta

INSERT INTO #Auxiliar1 
 SELECT dsmpo.Cantidad, Det.CostoUnitario*dsmpo.Cantidad
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMateriales=dsmpo.IdDetalleSalidaMateriales
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON IsNull(dsmpo.IdPresupuestoObrasNodo,0)=pon.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0)>0 and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and 
	IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and (@IdObra=-1 or pon.IdObra=@IdObra) and 
	SalidasMateriales.FechaSalidaMateriales between @FechaDesde and @FechaHasta and IsNull(Det.DescargaPorKit,'')<>'SI'

INSERT INTO #Auxiliar1 
 SELECT dsmpo.Cantidad, Articulos.CostoReposicion*dsmpo.Cantidad
 FROM DetalleSalidasMaterialesKits Det 
 LEFT OUTER JOIN DetalleSalidasMateriales ON Det.IdDetalleSalidaMateriales=DetalleSalidasMateriales.IdDetalleSalidaMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMaterialesKit=dsmpo.IdDetalleSalidaMaterialesKit
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON IsNull(dsmpo.IdPresupuestoObrasNodo,0)=pon.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0)>0  and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and 
	IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and (@IdObra=-1 or pon.IdObra=@IdObra) and 
	SalidasMateriales.FechaSalidaMateriales between @FechaDesde and @FechaHasta

/*
VER COMO JUEGA EL TEMA DE LA OBRA
INSERT INTO #Auxiliar1 
 SELECT Det.CantidadAvance, Det.ImporteTotal
 FROM SubcontratosPxQ Det 
 LEFT OUTER JOIN Subcontratos ON Subcontratos.IdSubcontrato=Det.IdSubcontrato
 LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.NumeroSubcontrato=Subcontratos.NumeroSubcontrato
 LEFT OUTER JOIN DetalleSubcontratosDatos dsd ON dsd.IdSubcontratoDatos=SubcontratosDatos.IdSubcontratoDatos and dsd.NumeroCertificado=Det.NumeroCertificado
 WHERE IsNull(Det.IdPresupuestoObrasNodo,0)>0 and dsd.FechaCertificadoHasta between @FechaDesde and @FechaHasta
*/
 
INSERT INTO #Auxiliar1 
 SELECT ponc.Cantidad, ponc.Importe
 FROM PresupuestoObrasNodosConsumos ponc 
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON ponc.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
 WHERE (@IdObra=-1 or pon.IdObra=@IdObra) and ponc.Fecha between @FechaDesde and @FechaHasta

SET @ConsumosTotales=IsNull((Select Sum(IsNull(Importe,0)) From #Auxiliar1),0)

-- LUEGO DETERMINO LOS DESTINOS DE OBRA DEL PRODUCIDO DE LAS PLANTA / AUXILIARES PARA CALCULAR LA MATRIZ DE DISTRIBUCION DE LOS COSTOS
-- DE CADA PLANTA / AUXILIAR PARA ASI DEFINIR LOS CONSUMOS

CREATE TABLE #Auxiliar2 (IdPresupuestoObrasNodo INTEGER, IdArticulo INTEGER, Cantidad NUMERIC(18, 2), Importe NUMERIC(18, 2))
/*
INSERT INTO #Auxiliar2 
 SELECT dsmpo.IdDetalleSalidaMaterialesPresupuestosObras, dsmpo.IdPresupuestoObrasNodo, Det.IdArticulo, dsmpo.Cantidad, Det.CostoUnitario*dsmpo.Cantidad, dsmpo.IdPresupuestoObrasNodoNoMateriales
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMateriales=dsmpo.IdDetalleSalidaMateriales
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON IsNull(dsmpo.IdPresupuestoObrasNodo,0)=pon.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0)>0 and IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and 
	SalidasMateriales.FechaSalidaMateriales between @FechaDesde and @FechaHasta and IsNull(Det.DescargaPorKit,'')='SI' and 
	(@IdObra=-1 or Det.IdObra=@IdObra)
--IsNull((Select Top 1 Conjuntos.IdObra From Conjuntos Where Conjuntos.IdArticulo=Det.IdArticulo),0)=@IdObra)
*/
INSERT INTO #Auxiliar2 
 SELECT PartesProduccion.IdPresupuestoObrasNodo, PartesProduccion.IdArticulo, PartesProduccion.Cantidad, PartesProduccion.Cantidad*PartesProduccion.Importe
/*
		IsNull((Select Top 1 pond.Importe From PresupuestoObrasNodosDatos pond 
				Where pond.IdPresupuestoObrasNodo=(Select Top 1 pon2.IdPresupuestoObrasNodo From PresupuestoObrasNodos pon2
													Where pon2.IdObra=PartesProduccion.IdObra and pon2.IdNodoPadre is null)),0)*PartesProduccion.Cantidad, 
		PartesProduccion.IdPresupuestoObrasNodo
*/
 FROM PartesProduccion 
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON PartesProduccion.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=PartesProduccion.IdArticulo
 WHERE PartesProduccion.FechaParteProduccion between @FechaDesde and @FechaHasta and 
	(@IdObra=-1 or PartesProduccion.IdObra=@IdObra)

CREATE TABLE #Auxiliar3 (IdPresupuestoObrasNodo INTEGER, Cantidad NUMERIC(18, 2), Importe NUMERIC(18, 2))
INSERT INTO #Auxiliar3 
 SELECT IdPresupuestoObrasNodo, Sum(IsNull(Cantidad,0)), Sum(IsNull(Importe,0))
 FROM #Auxiliar2
 GROUP BY IdPresupuestoObrasNodo

SET @ProductoDistribuido=IsNull((Select Sum(IsNull(Importe,0)) From #Auxiliar3),0)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111133'
SET @vector_T='009F555533400'

SELECT 
 #Auxiliar3.IdPresupuestoObrasNodo as [IdPresupuestoObrasNodo], 
 Obras.NumeroObra+' - '+Obras.Descripcion as [Obra],
 #Auxiliar3.IdPresupuestoObrasNodo as [IdAux1], 
 pon1.Item+' - '+pon1.Descripcion as [Etapa],
 @ConsumosTotales as [Consumo real obra],
 @ProductoDistribuido as [Total productos distribuidos],
 #Auxiliar3.Cantidad as [Cant.Producido],
 #Auxiliar3.Importe as [Importe Producido],
 Case When @ProductoDistribuido<>0 Then IsNull(#Auxiliar3.Importe,0) / @ProductoDistribuido * 100 Else 0 End as [% a asignar],
 #Auxiliar3.Cantidad as [Cantidad a asignar], --Case When @ProductoDistribuido<>0 Then IsNull(#Auxiliar3.Cantidad,0) / @ProductoDistribuido * @ConsumosTotales Else 0 End as [Cantidad a asignar],
 Case When @ProductoDistribuido<>0 Then IsNull(#Auxiliar3.Importe,0) / @ProductoDistribuido * @ConsumosTotales Else 0 End as [Importe a asignar],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN PresupuestoObrasNodos pon1 ON pon1.IdPresupuestoObrasNodo=#Auxiliar3.IdPresupuestoObrasNodo
LEFT OUTER JOIN Obras ON Obras.IdObra=pon1.IdObra
ORDER BY Obras.NumeroObra, pon1.SubItem1, pon1.SubItem2, pon1.SubItem3, pon1.SubItem4, pon1.SubItem5

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3