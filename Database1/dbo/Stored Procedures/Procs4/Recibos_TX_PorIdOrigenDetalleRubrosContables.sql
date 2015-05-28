


CREATE Procedure [dbo].[Recibos_TX_PorIdOrigenDetalleRubrosContables]
@IdDetalleReciboRubrosContablesOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 drrc.IdDetalleReciboRubrosContables,Recibos.IdRecibo
FROM DetalleRecibosRubrosContables drrc
LEFT OUTER JOIN Recibos ON drrc.IdRecibo=Recibos.IdRecibo
WHERE drrc.IdDetalleReciboRubrosContablesOriginal=@IdDetalleReciboRubrosContablesOriginal and 
	drrc.IdOrigenTransmision=@IdOrigenTransmision


