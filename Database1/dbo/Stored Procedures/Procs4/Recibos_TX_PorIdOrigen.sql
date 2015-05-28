


CREATE Procedure [dbo].[Recibos_TX_PorIdOrigen]
@IdReciboOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdRecibo
FROM Recibos
WHERE IdReciboOriginal=@IdReciboOriginal and IdOrigenTransmision=@IdOrigenTransmision


