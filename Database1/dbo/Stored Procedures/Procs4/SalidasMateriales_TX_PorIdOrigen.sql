




CREATE Procedure [dbo].[SalidasMateriales_TX_PorIdOrigen]
@IdSalidaMaterialesOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdSalidaMateriales
FROM SalidasMateriales
WHERE IdSalidaMaterialesOriginal=@IdSalidaMaterialesOriginal and IdOrigenTransmision=@IdOrigenTransmision




