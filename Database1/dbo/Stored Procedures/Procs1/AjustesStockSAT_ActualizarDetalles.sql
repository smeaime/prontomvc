


CREATE Procedure [dbo].[AjustesStockSAT_ActualizarDetalles]

@IdAjusteStockOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleAjustesStockSAT
SET 
 IdAjusteStock=(Select Top 1 AjustesStockSAT.IdAjusteStock 
		From AjustesStockSAT  
		Where AjustesStockSAT.IdAjusteStockOriginal=@IdAjusteStockOriginal and 
			AjustesStockSAT.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdAjusteStockOriginal=@IdAjusteStockOriginal and IdOrigenTransmision=@IdOrigenTransmision


