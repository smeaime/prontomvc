CREATE Procedure [dbo].[SalidasMateriales_ActualizarDetalles]

@IdSalidaMaterialesOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleSalidasMateriales
SET IdSalidaMateriales=(Select Top 1 sm.IdSalidaMateriales From SalidasMateriales sm Where sm.IdSalidaMaterialesOriginal=@IdSalidaMaterialesOriginal and sm.IdOrigenTransmision=@IdOrigenTransmision),
	Partida=IsNull(Partida,'')
WHERE IdSalidaMaterialesOriginal=@IdSalidaMaterialesOriginal and IdOrigenTransmision=@IdOrigenTransmision