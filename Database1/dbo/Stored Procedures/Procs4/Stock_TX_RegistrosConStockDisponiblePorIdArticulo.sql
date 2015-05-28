
CREATE Procedure [dbo].[Stock_TX_RegistrosConStockDisponiblePorIdArticulo]

@IdArticulo int

AS

DECLARE @IdObraStockDisponible int
SET @IdObraStockDisponible=IsNull((Select Top 1 Parametros.IdObraStockDisponible From Parametros Where Parametros.IdParametro=1),0)

SELECT Stock.*
FROM Stock
LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
WHERE (@IdObraStockDisponible<=0 or Stock.IdObra=@IdObraStockDisponible) and 
	CantidadUnidades>0 and Stock.IdArticulo=@IdArticulo and IsNull(Articulos.RegistrarStock,'SI')='SI'
ORDER BY Stock.IdArticulo
