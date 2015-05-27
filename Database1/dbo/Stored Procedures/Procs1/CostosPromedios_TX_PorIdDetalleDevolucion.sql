

























CREATE Procedure [dbo].[CostosPromedios_TX_PorIdDetalleDevolucion]
@IdDetalleDevolucion int
AS 
SELECT Top 1 *
FROM CostosPromedios
WHERE IdDetalleDevolucion=@IdDetalleDevolucion


























