CREATE Procedure [dbo].[Pesadas_TX_PorIdOrigen]

@IdPesadaOriginal int,
@IdOrigenTransmision int

AS 

SELECT TOP 1 IdPesada
FROM Pesadas
WHERE IdPesadaOriginal=@IdPesadaOriginal and IdOrigenTransmision=@IdOrigenTransmision