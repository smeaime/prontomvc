





























CREATE  Procedure [dbo].[GruposTareasHH_M]
@IdGrupoTareaHH int ,
@Descripcion varchar(50),
@Preparacion numeric(6,2),
@CaldereriaPlana numeric(6,2),
@Mecanica numeric(6,2),
@Caldereria numeric(6,2),
@Soldadura numeric(6,2),
@Almacenes numeric(6,2)
AS
Update GruposTareasHH
SET
Descripcion=@Descripcion,
Preparacion=@Preparacion,
CaldereriaPlana=@CaldereriaPlana,
Mecanica=@Mecanica,
Caldereria=@Caldereria,
Soldadura=@Soldadura,
Almacenes=@Almacenes
where (IdGrupoTareaHH=@IdGrupoTareaHH)
Return(@IdGrupoTareaHH)






























