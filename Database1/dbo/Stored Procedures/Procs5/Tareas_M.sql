



CREATE  Procedure [dbo].[Tareas_M]
@IdTarea int ,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@Observaciones ntext,
@TipoTarea int
As
Update Tareas
Set
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura,
 Observaciones=@Observaciones,
 TipoTarea=@TipoTarea
Where (IdTarea=@IdTarea)
Return(@IdTarea)



