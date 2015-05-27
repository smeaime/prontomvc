




CREATE Procedure [dbo].[OtrosIngresosAlmacen_TX_PorIdOrigen]
@IdOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdOtroIngresoAlmacen
FROM OtrosIngresosAlmacen
WHERE IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal and IdOrigenTransmision=@IdOrigenTransmision





