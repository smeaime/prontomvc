





























CREATE Procedure [dbo].[GruposTareasHH_TX_TT]
@IdGrupoTareaHH int
AS 
Select 
IdGrupoTareaHH,
Descripcion,
Preparacion as [% Preparacion],
CaldereriaPlana as [% Caldereria Plana],
Mecanica as [% Mecanica],
Caldereria as [% Caldereria],
Soldadura as [% Soldadura],
Almacenes as [% Almacenes]
FROM GruposTareasHH
where (IdGrupoTareaHH=@IdGrupoTareaHH)






























