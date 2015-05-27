

























CREATE Procedure [dbo].[CostosPromedios_TX_PorIdDetalleAjusteStock]
@IdDetalleAjusteStock int
AS 
SELECT Top 1 *
FROM CostosPromedios
WHERE IdDetalleAjusteStock=@IdDetalleAjusteStock


























