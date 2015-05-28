



CREATE Procedure [dbo].[Tareas_TT]
AS 
SELECT
 IdTarea,
 Descripcion,
 Abreviatura,
 Case When IsNull(TipoTarea,1)=1 Then 'Tarea de obra'
	When IsNull(TipoTarea,1)=2 Then 'Tarea de mantenimiento'
	When IsNull(TipoTarea,1)=3 Then 'Tarea no productiva'
	Else Null
 End as [Tipo de tarea],
 Observaciones
FROM Tareas
ORDER BY Descripcion



