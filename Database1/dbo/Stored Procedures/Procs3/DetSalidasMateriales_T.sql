
CREATE Procedure [dbo].[DetSalidasMateriales_T]

@IdDetalleSalidaMateriales int

AS 

SELECT *
FROM [DetalleSalidasMateriales]
WHERE (IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)
