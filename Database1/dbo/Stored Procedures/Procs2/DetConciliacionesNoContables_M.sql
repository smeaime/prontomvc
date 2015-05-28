
















CREATE Procedure [dbo].[DetConciliacionesNoContables_M]
@IdDetalleConciliacionNoContable int,
@IdConciliacion int,
@Detalle varchar(50),
@FechaIngreso datetime,
@FechaCaducidad datetime,
@FechaRegistroContable datetime,
@Ingresos numeric(18,2),
@Egresos numeric(18,2)
As
Update [DetalleConciliacionesNoContables]
Set 
 IdConciliacion=@IdConciliacion,
 Detalle=@Detalle,
 FechaIngreso=@FechaIngreso,
 FechaCaducidad=@FechaCaducidad,
 FechaRegistroContable=@FechaRegistroContable,
 Ingresos=@Ingresos,
 Egresos=@Egresos
Where (IdDetalleConciliacionNoContable=@IdDetalleConciliacionNoContable)
Return(@IdDetalleConciliacionNoContable)
















