


CREATE Procedure [dbo].[AjustesStockSAT_TX_PorIdOrigen]
@IdAjusteStockOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdAjusteStock
FROM AjustesStockSAT
WHERE IdAjusteStockOriginal=@IdAjusteStockOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision


