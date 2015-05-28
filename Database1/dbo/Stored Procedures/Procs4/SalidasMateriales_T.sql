
CREATE Procedure [dbo].[SalidasMateriales_T]
@IdSalidaMateriales int
AS 
SELECT * 
FROM SalidasMateriales
WHERE (IdSalidaMateriales=@IdSalidaMateriales)
