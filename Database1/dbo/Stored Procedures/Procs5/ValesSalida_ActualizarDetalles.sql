CREATE Procedure [dbo].[ValesSalida_ActualizarDetalles]

@IdValeSalidaOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleValesSalida
SET IdValeSalida=(Select Top 1 vs.IdValeSalida 
			From ValesSalida vs 
			Where vs.IdValeSalidaOriginal=@IdValeSalidaOriginal and vs.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdValeSalidaOriginal=@IdValeSalidaOriginal and IdOrigenTransmision=@IdOrigenTransmision