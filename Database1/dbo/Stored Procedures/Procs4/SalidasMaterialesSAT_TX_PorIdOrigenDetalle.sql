
CREATE Procedure [dbo].[SalidasMaterialesSAT_TX_PorIdOrigenDetalle]
@IdDetalleSalidaMaterialesOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 det.*, SalidasMaterialesSAT.IdSalidaMateriales
FROM DetalleSalidasMaterialesSAT det
LEFT OUTER JOIN SalidasMaterialesSAT ON det.IdSalidaMateriales=SalidasMaterialesSAT.IdSalidaMateriales
WHERE det.IdDetalleSalidaMaterialesOriginal=@IdDetalleSalidaMaterialesOriginal and 
	det.IdOrigenTransmision=@IdOrigenTransmision
