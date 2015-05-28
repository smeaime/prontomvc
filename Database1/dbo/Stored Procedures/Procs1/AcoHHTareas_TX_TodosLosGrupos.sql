































CREATE Procedure [dbo].[AcoHHTareas_TX_TodosLosGrupos]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='05500'
Select 
Case 	When AcoHHTareas.IdAcoHHTarea is null Then GruposTareasHH.IdGrupoTareaHH*-1
	Else AcoHHTareas.IdAcoHHTarea
End,
GruposTareasHH.Descripcion as [Grupo de tareas],
Case 	When AcoHHTareas.IdAcoHHTarea is null Then ' '
	Else 'Ok'
End as [Ya definido],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM GruposTareasHH
LEFT OUTER JOIN AcoHHTareas ON GruposTareasHH.IdGrupoTareaHH=AcoHHTareas.IdGrupoTareaHH
































