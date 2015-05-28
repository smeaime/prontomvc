



CREATE Procedure [dbo].[Tareas_TX_TT]
@IdTarea int
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
WHERE (IdTarea=@IdTarea)



