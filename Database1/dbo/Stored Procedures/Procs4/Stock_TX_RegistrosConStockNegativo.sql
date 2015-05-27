


CREATE Procedure [dbo].[Stock_TX_RegistrosConStockNegativo]

AS

Declare @IdObraStockDisponible int
Set @IdObraStockDisponible=(Select Top 1 Parametros.IdObraStockDisponible 
				From Parametros Where Parametros.IdParametro=1)

SELECT Stock.*
FROM Stock
LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
WHERE Stock.IdObra<>@IdObraStockDisponible and CantidadUnidades<0 and IsNull(Articulos.RegistrarStock,'SI')='SI'
ORDER BY Stock.IdArticulo


