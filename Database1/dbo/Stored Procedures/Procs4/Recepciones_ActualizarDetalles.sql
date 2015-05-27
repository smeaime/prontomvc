CREATE Procedure [dbo].[Recepciones_ActualizarDetalles]

@IdRecepcionOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleRecepciones
SET IdRecepcion=(Select Top 1 Rec.IdRecepcion  From Recepciones Rec Where Rec.IdRecepcionOriginal=@IdRecepcionOriginal and Rec.IdOrigenTransmision=@IdOrigenTransmision), 
	Partida=IsNull(Partida,'')
WHERE IdRecepcionOriginal=@IdRecepcionOriginal and IdOrigenTransmision=@IdOrigenTransmision