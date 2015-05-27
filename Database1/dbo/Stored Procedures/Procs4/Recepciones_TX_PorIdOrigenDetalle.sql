


CREATE Procedure [dbo].[Recepciones_TX_PorIdOrigenDetalle]
@IdDetalleRecepcionOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 
 das.IdDetalleRecepcion,
 das.IdArticulo,
 das.Partida,
 das.Cantidad,
 das.IdUnidad,
 das.IdUbicacion,
 das.IdObra,
 Recepciones.IdRecepcion
FROM DetalleRecepciones das
LEFT OUTER JOIN Recepciones ON das.IdRecepcion=Recepciones.IdRecepcion
WHERE das.IdDetalleRecepcionOriginal=@IdDetalleRecepcionOriginal and 
	das.IdOrigenTransmision=@IdOrigenTransmision


