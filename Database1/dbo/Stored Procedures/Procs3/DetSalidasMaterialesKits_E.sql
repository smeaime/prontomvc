
CREATE Procedure [dbo].[DetSalidasMaterialesKits_E]

@IdDetalleSalidaMaterialesKit int  

AS 

DELETE DetalleSalidasMaterialesKits
WHERE IdDetalleSalidaMaterialesKit=@IdDetalleSalidaMaterialesKit
