CREATE Procedure [dbo].[Requerimientos_ActualizarDetalles]

@IdRequerimientoOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetalleRequerimientos
SET IdRequerimiento=(Select Top 1 Req.IdRequerimiento From Requerimientos Req Where Req.IdRequerimientoOriginal=@IdRequerimientoOriginal and Req.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdRequerimientoOriginal=@IdRequerimientoOriginal and IdOrigenTransmision=@IdOrigenTransmision