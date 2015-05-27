



CREATE Procedure [dbo].[Tareas_TX_TareasPorEquipoSector]
@IdGrupoTareaHH int,
@Sector varchar(2)
AS 
Select 
dt.IdTarea,
Tareas.Descripcion as [Titulo]
FROM DetalleAcoHHTareas dt
INNER JOIN Tareas ON dt.IdTarea = Tareas.IdTarea
INNER JOIN AcoHHTareas ON dt.IdAcoHHTarea=AcoHHTareas.IdAcoHHTarea
WHERE AcoHHTareas.IdGrupoTareaHH=@IdGrupoTareaHH AND 
	((dt.Preparacion='*' AND @Sector='PR') OR 
	 (dt.CaldereriaPlana='*' AND @Sector='CP') OR 
	 (dt.Mecanica='*' AND @Sector='ME') OR 
	 (dt.Caldereria='*' AND @Sector='CA') OR 
	 (dt.Soldadura='*' AND @Sector='SO') OR 
	 (dt.Almacen='*' AND @Sector='AL') OR 
	 (dt.Mantenimiento='*' AND @Sector='MA'))
ORDER BY Tareas.Descripcion



