






CREATE Procedure [dbo].[AjustesStock_TX_PorIdOrigen]
@IdAjusteStockOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdAjusteStock
FROM AjustesStock
WHERE IdAjusteStockOriginal=@IdAjusteStockOriginal and IdOrigenTransmision=@IdOrigenTransmision







