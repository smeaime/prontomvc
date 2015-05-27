





























CREATE Procedure [dbo].[LMateriales_TX_PorIdOrigen]
@IdLMaterialesOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdLMateriales
FROM LMateriales
WHERE IdLMaterialesOriginal=@IdLMaterialesOriginal and IdOrigenTransmision=@IdOrigenTransmision






























