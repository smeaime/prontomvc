


CREATE Procedure [dbo].[Recibos_TX_PorIdOrigenDetalleValores]
@IdDetalleReciboValoresOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 drv.IdDetalleReciboValores,Recibos.IdRecibo
FROM DetalleRecibosValores drv
LEFT OUTER JOIN Recibos ON drv.IdRecibo=Recibos.IdRecibo
WHERE drv.IdDetalleReciboValoresOriginal=@IdDetalleReciboValoresOriginal and 
	drv.IdOrigenTransmision=@IdOrigenTransmision


