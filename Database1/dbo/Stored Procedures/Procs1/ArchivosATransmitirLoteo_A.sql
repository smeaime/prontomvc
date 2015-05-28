































CREATE Procedure [dbo].[ArchivosATransmitirLoteo_A]
@IdArchivoATransmitirLoteo int  output,
@IdArchivoATransmitir int,
@FechaTransmision datetime,
@IdArchivoATransmitirDestino int,
@NumeroLote int,
@Confirmado varchar(2),
@FechaRecepcionOK datetime
AS 
Insert into [ArchivosATransmitirLoteo]
(
 IdArchivoATransmitir,
 FechaTransmision,
 IdArchivoATransmitirDestino,
 NumeroLote,
 Confirmado,
 FechaRecepcionOK
)
Values
(
 @IdArchivoATransmitir,
 @FechaTransmision,
 @IdArchivoATransmitirDestino,
 @NumeroLote,
 @Confirmado,
 @FechaRecepcionOK
)
Select @IdArchivoATransmitirLoteo=@@identity
Return(@IdArchivoATransmitirLoteo)
































