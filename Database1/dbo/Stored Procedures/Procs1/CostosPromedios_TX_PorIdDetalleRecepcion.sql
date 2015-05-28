

























CREATE Procedure [dbo].[CostosPromedios_TX_PorIdDetalleRecepcion]
@IdDetalleRecepcion int
AS 
SELECT Top 1 *
FROM CostosPromedios
WHERE IdDetalleRecepcion=@IdDetalleRecepcion


























