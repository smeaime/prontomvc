
CREATE Procedure [dbo].[DetSalidasMaterialesKits_Eliminar]

@IdDetalleSalidaMateriales int  

AS 

DELETE DetalleSalidasMaterialesKits
WHERE IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales
