
CREATE Procedure [dbo].[SalidasMateriales_TX_PorId]

@IdSalidaMateriales int

AS 

SELECT * 
FROM SalidasMateriales
WHERE (IdSalidaMateriales=@IdSalidaMateriales)
