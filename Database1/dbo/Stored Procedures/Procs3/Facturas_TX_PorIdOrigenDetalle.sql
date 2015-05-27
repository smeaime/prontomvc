


CREATE Procedure [dbo].[Facturas_TX_PorIdOrigenDetalle]
@IdDetalleFacturaOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 df.IdDetalleFactura,Facturas.IdFactura
FROM DetalleFacturas df
LEFT OUTER JOIN Facturas ON df.IdFactura=Facturas.IdFactura
WHERE df.IdDetalleFacturaOriginal=@IdDetalleFacturaOriginal and 
	df.IdOrigenTransmision=@IdOrigenTransmision


