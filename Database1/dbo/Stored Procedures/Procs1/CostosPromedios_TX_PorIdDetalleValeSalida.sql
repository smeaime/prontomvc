

























CREATE Procedure [dbo].[CostosPromedios_TX_PorIdDetalleValeSalida]
@IdDetalleValeSalida int
AS 
SELECT Top 1 *
FROM CostosPromedios
WHERE IdDetalleValeSalida=@IdDetalleValeSalida


























