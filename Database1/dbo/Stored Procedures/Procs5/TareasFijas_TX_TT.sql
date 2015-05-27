





























CREATE Procedure [dbo].[TareasFijas_TX_TT]
@IdTareaFija int
AS 
Select
IdTareaFija,
Empleados.Nombre as [Operario],
Sectores.Descripcion as [Sector],
FechaInicial as [Desde],
FechaFinal as [Hasta],
HoraInicial as [Desde las],
TareasFijas.HorasJornada as [Cant.horas],
ItemsProduccion.Descripcion as [Item],
Obras.NumeroObra as [Obra],
Equipos.Tag as [Equipo],
Tareas.Descripcion as [Tarea]
FROM TareasFijas
LEFT OUTER JOIN Empleados ON TareasFijas.IdEmpleado=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN ItemsProduccion ON TareasFijas.IdItemProduccion=ItemsProduccion.IdItemProduccion
LEFT OUTER JOIN Obras ON TareasFijas.IdObra=Obras.IdObra
LEFT OUTER JOIN Equipos ON TareasFijas.IdEquipo=Equipos.IdEquipo
LEFT OUTER JOIN Tareas ON TareasFijas.IdTarea=Tareas.IdTarea
WHERE (IdTareaFija=@IdTareaFija)






























