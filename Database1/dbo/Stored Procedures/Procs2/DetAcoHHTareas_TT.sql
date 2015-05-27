





























CREATE Procedure [dbo].[DetAcoHHTareas_TT]
AS 
Select 
DetalleAcoHHTareas.IdDetalleAcoHHTarea,
DetalleAcoHHTareas.IdTarea,
Tareas.Descripcion as [Tarea de obra],
DetalleAcoHHTareas.Preparacion,
DetalleAcoHHTareas.CaldereriaPlana,
DetalleAcoHHTareas.Mecanica,
DetalleAcoHHTareas.Caldereria,
DetalleAcoHHTareas.Soldadura,
DetalleAcoHHTareas.Almacen,
DetalleAcoHHTareas.Mantenimiento
FROM DetalleAcoHHTareas
INNER JOIN Tareas ON DetalleAcoHHTareas.IdTarea = Tareas.IdTarea
ORDER BY Tareas.Descripcion






























