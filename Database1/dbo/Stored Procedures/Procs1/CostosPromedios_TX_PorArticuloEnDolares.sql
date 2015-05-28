

























CREATE Procedure [dbo].[CostosPromedios_TX_PorArticuloEnDolares]
@IdArticulo int
AS 
SELECT *
FROM CostosPromedios
WHERE IdArticulo=@IdArticulo and CostoFinalU$S is not null
ORDER by Fecha DESC


























