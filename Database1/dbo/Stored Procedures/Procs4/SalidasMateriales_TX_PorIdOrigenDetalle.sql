




CREATE Procedure [dbo].[SalidasMateriales_TX_PorIdOrigenDetalle]
@IdDetalleSalidaMaterialesOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 
 dsm.IdDetalleSalidaMateriales,
 dsm.IdArticulo,
 dsm.Partida,
 dsm.Cantidad,
 dsm.IdUnidad,
 dsm.IdUbicacion,
 dsm.IdObra,
 SalidasMateriales.IdSalidaMateriales
FROM DetalleSalidasMateriales dsm
LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
WHERE dsm.IdDetalleSalidaMaterialesOriginal=@IdDetalleSalidaMaterialesOriginal and 
	dsm.IdOrigenTransmision=@IdOrigenTransmision




