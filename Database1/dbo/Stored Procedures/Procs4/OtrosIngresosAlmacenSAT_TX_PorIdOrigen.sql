
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_TX_PorIdOrigen]
@IdOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdOtroIngresoAlmacen
FROM OtrosIngresosAlmacenSAT
WHERE IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
