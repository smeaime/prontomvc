
CREATE Procedure [dbo].[DetSalidasMaterialesSAT_T]
@IdDetalleSalidaMateriales int
AS 
SELECT *
FROM [DetalleSalidasMaterialesSAT]
WHERE (IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)
