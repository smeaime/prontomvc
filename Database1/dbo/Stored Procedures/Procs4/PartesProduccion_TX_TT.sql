CREATE Procedure [dbo].[PartesProduccion_TX_TT]

@IdParteProduccion int

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111133'
SET @vector_T='024GGE203GG5200'

SELECT 
 PartesProduccion.IdParteProduccion as [IdParteProduccion],
 PartesProduccion.NumeroParteProduccion as [Nro. de parte],
 PartesProduccion.FechaParteProduccion as [Fecha],
 O1.NumeroObra+' '+O1.Descripcion as [Auxiliar],
 O2.NumeroObra+' '+O2.Descripcion as [Obra destino],
 Articulos.Descripcion as [Material],
 PartesProduccion.Cantidad as [Cant.], 
 Unidades.Abreviatura as [Un.],
 PartesProduccion.Importe as [Importe], 
 pon1.Descripcion as [Etapa elaboracion],
 pon2.Descripcion as [Etapa materiales],
 PartesProduccion.Observaciones as [Observaciones], 
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [Nro. de salida],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM PartesProduccion
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = PartesProduccion.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = PartesProduccion.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos pon1 ON pon1.IdPresupuestoObrasNodo = PartesProduccion.IdPresupuestoObrasNodo
LEFT OUTER JOIN PresupuestoObrasNodos pon2 ON pon2.IdPresupuestoObrasNodo = PartesProduccion.IdPresupuestoObrasNodoMateriales
LEFT OUTER JOIN Obras O1 ON O1.IdObra = PartesProduccion.IdObra
LEFT OUTER JOIN Obras O2 ON O2.IdObra = PartesProduccion.IdObraDestino
LEFT OUTER JOIN DetalleSalidasMateriales dsm ON dsm.IdDetalleSalidaMateriales = PartesProduccion.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
WHERE (IdParteProduccion=@IdParteProduccion)