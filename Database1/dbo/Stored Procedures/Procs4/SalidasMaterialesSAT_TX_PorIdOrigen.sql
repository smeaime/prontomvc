
CREATE Procedure [dbo].[SalidasMaterialesSAT_TX_PorIdOrigen]
@IdSalidaMaterialesOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdSalidaMateriales
FROM SalidasMaterialesSAT
WHERE IdSalidaMaterialesOriginal=@IdSalidaMaterialesOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
