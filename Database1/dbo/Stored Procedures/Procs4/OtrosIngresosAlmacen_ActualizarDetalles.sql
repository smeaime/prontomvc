
CREATE Procedure [dbo].[OtrosIngresosAlmacen_ActualizarDetalles]

@IdOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleOtrosIngresosAlmacen
SET IdOtroIngresoAlmacen=(Select Top 1 oia.IdOtroIngresoAlmacen 
				From OtrosIngresosAlmacen oia 
				Where oia.IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal and 
					oia.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
