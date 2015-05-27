





























CREATE Procedure [dbo].[DetAcoHHTareas_TX_TodasLasTareas]
@IdAcoHHTarea int
AS 
Select 
Case 	When DetalleAcoHHTareas.IdDetalleAcoHHTarea is null Then Tareas.IdTarea*-1
	Else DetalleAcoHHTareas.IdDetalleAcoHHTarea
End as [IdDetalleAcoHHTarea],
Tareas.IdTarea,
Tareas.Descripcion as [Tarea de obra],
DetalleAcoHHTareas.Preparacion,
DetalleAcoHHTareas.CaldereriaPlana,
DetalleAcoHHTareas.Mecanica,
DetalleAcoHHTareas.Caldereria,
DetalleAcoHHTareas.Soldadura,
DetalleAcoHHTareas.Almacen,
DetalleAcoHHTareas.Mantenimiento
FROM Tareas
LEFT OUTER JOIN DetalleAcoHHTareas ON DetalleAcoHHTareas.IdAcoHHTarea = @IdAcoHHTarea 
					and Tareas.IdTarea=DetalleAcoHHTareas.IdTarea
ORDER BY Tareas.Descripcion






























