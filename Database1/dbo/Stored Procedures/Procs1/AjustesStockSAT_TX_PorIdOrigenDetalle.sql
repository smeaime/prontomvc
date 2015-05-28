


CREATE Procedure [dbo].[AjustesStockSAT_TX_PorIdOrigenDetalle]
@IdDetalleAjusteStockOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 det.*, AjustesStockSAT.IdAjusteStock
FROM DetalleAjustesStockSAT det
LEFT OUTER JOIN AjustesStockSAT ON det.IdAjusteStock=AjustesStockSAT.IdAjusteStock
WHERE det.IdDetalleAjusteStockOriginal=@IdDetalleAjusteStockOriginal and 
	det.IdOrigenTransmision=@IdOrigenTransmision


