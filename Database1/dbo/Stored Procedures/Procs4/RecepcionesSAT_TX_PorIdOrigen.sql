
CREATE Procedure [dbo].[RecepcionesSAT_TX_PorIdOrigen]
@IdRecepcionOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 IdRecepcion
FROM RecepcionesSAT
WHERE IdRecepcionOriginal=@IdRecepcionOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
