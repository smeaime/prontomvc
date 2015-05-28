




CREATE Procedure [dbo].[Recepciones_TX_PorIdOrigen]
@IdRecepcionOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdRecepcion
FROM Recepciones
WHERE IdRecepcionOriginal=@IdRecepcionOriginal and IdOrigenTransmision=@IdOrigenTransmision





