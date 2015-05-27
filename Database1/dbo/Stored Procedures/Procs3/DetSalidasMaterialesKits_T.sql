
CREATE Procedure [dbo].[DetSalidasMaterialesKits_T]

@IdDetalleSalidaMaterialesKit int

AS 

SELECT *
FROM [DetalleSalidasMaterialesKits]
WHERE (IdDetalleSalidaMaterialesKit=@IdDetalleSalidaMaterialesKit)
