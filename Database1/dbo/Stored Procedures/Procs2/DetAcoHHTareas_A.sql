





























CREATE Procedure [dbo].[DetAcoHHTareas_A]
@IdDetalleAcoHHTarea int  output,
@IdAcoHHTarea int,
@IdTarea int,
@Preparacion varchar(1),
@CaldereriaPlana varchar(1),
@Mecanica varchar(1),
@Caldereria varchar(1),
@Soldadura varchar(1),
@Almacen varchar(1),
@Mantenimiento varchar(1)
AS 
Insert into [DetalleAcoHHTareas]
(
IdAcoHHTarea,
IdTarea,
Preparacion,
CaldereriaPlana,
Mecanica,
Caldereria,
Soldadura,
Almacen,
Mantenimiento
)
Values
(
@IdAcoHHTarea,
@IdTarea,
@Preparacion,
@CaldereriaPlana,
@Mecanica,
@Caldereria,
@Soldadura,
@Almacen,
@Mantenimiento
)
Select @IdDetalleAcoHHTarea=@@identity
Return(@IdDetalleAcoHHTarea)






























