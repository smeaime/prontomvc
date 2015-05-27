





CREATE Procedure [dbo].[CostosImportacion_TX_PorArticulo]
@IdArticulo int
AS 
SELECT *
FROM CostosImportacion
WHERE (IdArticulo=@IdArticulo)
ORDER BY FechaCostoImportacion DESC





