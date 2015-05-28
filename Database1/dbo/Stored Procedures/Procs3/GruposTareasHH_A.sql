





























CREATE Procedure [dbo].[GruposTareasHH_A]
@IdGrupoTareaHH int  output,
@Descripcion varchar(50),
@Preparacion numeric(6,2),
@CaldereriaPlana numeric(6,2),
@Mecanica numeric(6,2),
@Caldereria numeric(6,2),
@Soldadura numeric(6,2),
@Almacenes numeric(6,2)
AS 
Insert into [GruposTareasHH]
(
Descripcion,
Preparacion,
CaldereriaPlana,
Mecanica,
Caldereria,
Soldadura,
Almacenes
)
Values
(
@Descripcion,
@Preparacion,
@CaldereriaPlana,
@Mecanica,
@Caldereria,
@Soldadura,
@Almacenes
)
Select @IdGrupoTareaHH=@@identity
Return(@IdGrupoTareaHH)






























