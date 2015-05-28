


CREATE Procedure [dbo].[Subdiarios_TX_PorIdOrigen]
@IdSubdiarioOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdSubdiario
FROM Subdiarios
WHERE IdSubdiarioOriginal=@IdSubdiarioOriginal and IdOrigenTransmision=@IdOrigenTransmision


