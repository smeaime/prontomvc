

























CREATE Procedure [dbo].[CostosPromedios_TX_PorIdDetalleSalidaMateriales]
@IdDetalleSalidaMateriales int
AS 
SELECT Top 1 *
FROM CostosPromedios
WHERE IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales


























