





















CREATE Procedure [dbo].[CostosPromedios_TX_PorArticulo]
@IdArticulo int
AS 
SELECT *
FROM CostosPromedios
WHERE IdArticulo=@IdArticulo and CostoFinal is not null
ORDER by Fecha DESC





















