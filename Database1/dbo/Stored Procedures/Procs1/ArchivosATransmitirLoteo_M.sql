































CREATE  Procedure [dbo].[ArchivosATransmitirLoteo_M]
@IdArchivoATransmitirLoteo int,
@IdArchivoATransmitir int,
@FechaTransmision datetime,
@IdArchivoATransmitirDestino int,
@NumeroLote int,
@Confirmado varchar(2),
@FechaRecepcionOK datetime
AS
Update ArchivosATransmitirLoteo
SET
IdArchivoATransmitir=@IdArchivoATransmitir,
FechaTransmision=@FechaTransmision,
IdArchivoATransmitirDestino=@IdArchivoATransmitirDestino,
NumeroLote=@NumeroLote,
Confirmado=@Confirmado,
FechaRecepcionOK=@FechaRecepcionOK
where (IdArchivoATransmitirLoteo=@IdArchivoATransmitirLoteo)
Return(@IdArchivoATransmitirLoteo)
































