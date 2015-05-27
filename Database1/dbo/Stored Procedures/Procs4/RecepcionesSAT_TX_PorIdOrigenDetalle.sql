
CREATE Procedure [dbo].[RecepcionesSAT_TX_PorIdOrigenDetalle]
@IdDetalleRecepcionOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 det.*, RecepcionesSAT.IdRecepcion
FROM DetalleRecepcionesSAT det
LEFT OUTER JOIN RecepcionesSAT ON det.IdRecepcion=RecepcionesSAT.IdRecepcion
WHERE det.IdDetalleRecepcionOriginal=@IdDetalleRecepcionOriginal and 
	det.IdOrigenTransmision=@IdOrigenTransmision
