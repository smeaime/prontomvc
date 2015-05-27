
CREATE Procedure [dbo].[SalidasMaterialesSAT_T]
@IdSalidaMateriales int
AS 
SELECT * 
FROM SalidasMaterialesSAT
WHERE (IdSalidaMateriales=@IdSalidaMateriales)
