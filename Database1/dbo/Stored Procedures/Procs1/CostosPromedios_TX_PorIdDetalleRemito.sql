

























CREATE Procedure [dbo].[CostosPromedios_TX_PorIdDetalleRemito]
@IdDetalleRemito int
AS 
SELECT Top 1 *
FROM CostosPromedios
WHERE IdDetalleRemito=@IdDetalleRemito


























