































CREATE Procedure [dbo].[AcoHHTareas_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='05500'
Select 
AcoHHTareas.IdAcoHHTarea,
GruposTareasHH.Descripcion as [Grupo de tareas],
'Ok' as [Ya definido],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoHHTareas
LEFT OUTER JOIN GruposTareasHH ON AcoHHTareas.IdGrupoTareaHH = GruposTareasHH.IdGrupoTareaHH
































