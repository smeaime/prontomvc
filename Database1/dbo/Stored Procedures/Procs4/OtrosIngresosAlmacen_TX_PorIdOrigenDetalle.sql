




CREATE Procedure [dbo].[OtrosIngresosAlmacen_TX_PorIdOrigenDetalle]
@IdDetalleOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 
 doia.IdDetalleOtroIngresoAlmacen,
 doia.IdArticulo,
 doia.Partida,
 doia.Cantidad,
 doia.IdUnidad,
 doia.IdUbicacion,
 doia.IdObra,
 OtrosIngresosAlmacen.IdOtroIngresoAlmacen
FROM DetalleOtrosIngresosAlmacen doia
LEFT OUTER JOIN OtrosIngresosAlmacen ON doia.IdOtroIngresoAlmacen=OtrosIngresosAlmacen.IdOtroIngresoAlmacen
WHERE doia.IdDetalleOtroIngresoAlmacenOriginal=@IdDetalleOtroIngresoAlmacenOriginal and 
	doia.IdOrigenTransmision=@IdOrigenTransmision




