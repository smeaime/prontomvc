


CREATE Procedure [dbo].[Recibos_TX_PorIdOrigenDetalleCuentas]
@IdDetalleReciboCuentasOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 drc.IdDetalleReciboCuentas,Recibos.IdRecibo
FROM DetalleRecibosCuentas drc
LEFT OUTER JOIN Recibos ON drc.IdRecibo=Recibos.IdRecibo
WHERE drc.IdDetalleReciboCuentasOriginal=@IdDetalleReciboCuentasOriginal and 
	drc.IdOrigenTransmision=@IdOrigenTransmision


