
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_TX_PorIdOrigenDetalle]
@IdDetalleOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 det.*, OtrosIngresosAlmacenSAT.IdOtroIngresoAlmacen
FROM DetalleOtrosIngresosAlmacenSAT det
LEFT OUTER JOIN OtrosIngresosAlmacenSAT ON det.IdOtroIngresoAlmacen=OtrosIngresosAlmacenSAT.IdOtroIngresoAlmacen
WHERE det.IdDetalleOtroIngresoAlmacenOriginal=@IdDetalleOtroIngresoAlmacenOriginal and 
	det.IdOrigenTransmision=@IdOrigenTransmision
