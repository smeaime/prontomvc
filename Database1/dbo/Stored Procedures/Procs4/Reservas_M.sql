




CREATE Procedure [dbo].[Reservas_M]
@IdReserva int,
@NumeroReserva int,
@FechaReserva datetime,
@Observaciones ntext,
@Tipo varchar(1),
@IdReservaOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime
As
Update Reservas
Set 
 NumeroReserva=@NumeroReserva,
 FechaReserva=@FechaReserva,
 Observaciones=@Observaciones,
 Tipo=@Tipo,
 IdReservaOriginal=@IdReservaOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 FechaImportacionTransmision=@FechaImportacionTransmision
Where (IdReserva=@IdReserva)
Return(@IdReserva)




