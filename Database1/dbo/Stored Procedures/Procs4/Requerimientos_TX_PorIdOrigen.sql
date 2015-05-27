






























CREATE Procedure [dbo].[Requerimientos_TX_PorIdOrigen]
@IdRequerimientoOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdRequerimiento
FROM Requerimientos
WHERE IdRequerimientoOriginal=@IdRequerimientoOriginal and IdOrigenTransmision=@IdOrigenTransmision































