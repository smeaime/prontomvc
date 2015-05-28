CREATE Procedure [dbo].[AjustesStock_ActualizarDetalles]

@IdAjusteStockOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleAjustesStock
SET IdAjusteStock=(Select Top 1 Aju.IdAjusteStock From AjustesStock Aju Where Aju.IdAjusteStockOriginal=@IdAjusteStockOriginal and Aju.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdAjusteStockOriginal=@IdAjusteStockOriginal and IdOrigenTransmision=@IdOrigenTransmision