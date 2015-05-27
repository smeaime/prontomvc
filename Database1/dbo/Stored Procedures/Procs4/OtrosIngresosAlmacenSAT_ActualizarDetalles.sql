
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_ActualizarDetalles]

@IdOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleOtrosIngresosAlmacenSAT
SET 
 IdOtroIngresoAlmacen=(Select Top 1 sat.IdOtroIngresoAlmacen 
			From OtrosIngresosAlmacenSAT sat
			Where sat.IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal and 
				sat.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
