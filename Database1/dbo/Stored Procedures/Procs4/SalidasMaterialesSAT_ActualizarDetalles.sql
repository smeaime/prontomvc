
CREATE Procedure [dbo].[SalidasMaterialesSAT_ActualizarDetalles]

@IdSalidaMaterialesOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleSalidasMaterialesSAT
SET 
 IdSalidaMateriales=(Select Top 1 sat.IdSalidaMateriales 
			From SalidasMaterialesSAT sat
			Where sat.IdSalidaMaterialesOriginal=@IdSalidaMaterialesOriginal and sat.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdSalidaMaterialesOriginal=@IdSalidaMaterialesOriginal and IdOrigenTransmision=@IdOrigenTransmision
