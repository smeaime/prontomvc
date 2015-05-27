





























CREATE Procedure [dbo].[DetAcoHHTareas_M]
@IdDetalleAcoHHTarea int,
@IdAcoHHTarea int,
@IdTarea int,
@Preparacion varchar(1),
@CaldereriaPlana varchar(1),
@Mecanica varchar(1),
@Caldereria varchar(1),
@Soldadura varchar(1),
@Almacen varchar(1),
@Mantenimiento varchar(1)
as
Update DetalleAcoHHTareas
SET 
IdAcoHHTarea=@IdAcoHHTarea,
IdTarea=@IdTarea,
Preparacion=@Preparacion,
CaldereriaPlana=@CaldereriaPlana,
Mecanica=@Mecanica,
Caldereria=@Caldereria,
Soldadura=@Soldadura,
Almacen=@Almacen,
Mantenimiento=@Mantenimiento
where IdDetalleAcoHHTarea=@IdDetalleAcoHHTarea
Return(@IdDetalleAcoHHTarea)






























