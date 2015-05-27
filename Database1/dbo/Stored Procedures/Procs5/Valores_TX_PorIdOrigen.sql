CREATE Procedure [dbo].[Valores_TX_PorIdOrigen]

@IdValorOriginal int,
@IdOrigenTransmision int

AS 

SELECT TOP 1 IdValor
FROM Valores
WHERE IdValorOriginal=@IdValorOriginal and IdOrigenTransmision=@IdOrigenTransmision