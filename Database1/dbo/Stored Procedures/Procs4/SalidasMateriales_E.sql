


CREATE Procedure [dbo].[SalidasMateriales_E]
@IdSalidaMateriales int  
AS 
DELETE SalidasMateriales
WHERE (IdSalidaMateriales=@IdSalidaMateriales)


