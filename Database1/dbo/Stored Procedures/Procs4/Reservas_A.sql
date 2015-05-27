




CREATE Procedure [dbo].[Reservas_A]
@IdReserva int  output,
@NumeroReserva int,
@FechaReserva datetime,
@Observaciones ntext,
@Tipo varchar(1),
@IdReservaOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime
As 
Insert into Reservas
(
 NumeroReserva,
 FechaReserva,
 Observaciones,
 Tipo,
 IdReservaOriginal,
 IdOrigenTransmision,
 FechaImportacionTransmision
)
Values
(
 @NumeroReserva,
 @FechaReserva,
 @Observaciones,
 @Tipo,
 @IdReservaOriginal,
 @IdOrigenTransmision,
 @FechaImportacionTransmision
)
Select @IdReserva=@@identity
Return(@IdReserva)




