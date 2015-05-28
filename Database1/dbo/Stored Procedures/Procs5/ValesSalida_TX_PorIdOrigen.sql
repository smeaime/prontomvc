




CREATE Procedure [dbo].[ValesSalida_TX_PorIdOrigen]
@IdValeSalidaOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdValeSalida
FROM ValesSalida
WHERE IdValeSalidaOriginal=@IdValeSalidaOriginal and IdOrigenTransmision=@IdOrigenTransmision




