





























CREATE Procedure [dbo].[Tareas_TX_TareasPorEquipo]
@IdGrupoTareaHH int
AS 
Select 
dt.IdTarea,
Tareas.Descripcion as [Descripcion],
dt.Preparacion,
dt.CaldereriaPlana,
dt.Mecanica,
dt.Caldereria,
dt.Soldadura,
dt.Almacen,
dt.Mantenimiento
FROM DetalleAcoHHTareas dt
INNER JOIN Tareas ON dt.IdTarea = Tareas.IdTarea
INNER JOIN AcoHHTareas ON dt.IdAcoHHTarea=AcoHHTareas.IdAcoHHTarea
WHERE AcoHHTareas.IdGrupoTareaHH=@IdGrupoTareaHH AND 
	(dt.Preparacion='*' OR dt.CaldereriaPlana='*' OR dt.Mecanica='*' OR dt.Caldereria='*' OR 
	 dt.Soldadura='*' OR dt.Almacen='*' OR dt.Mantenimiento='*')
ORDER BY Tareas.Descripcion






























