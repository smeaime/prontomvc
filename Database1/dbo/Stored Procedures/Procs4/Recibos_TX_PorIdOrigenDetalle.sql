
CREATE Procedure [dbo].[Recibos_TX_PorIdOrigenDetalle]

@IdDetalleReciboOriginal int,
@IdOrigenTransmision int

AS 

SELECT TOP 1 dr.IdDetalleRecibo,Recibos.IdRecibo
FROM DetalleRecibos dr
LEFT OUTER JOIN Recibos ON dr.IdRecibo=Recibos.IdRecibo
WHERE dr.IdDetalleReciboOriginal=@IdDetalleReciboOriginal and 
	dr.IdOrigenTransmision=@IdOrigenTransmision
