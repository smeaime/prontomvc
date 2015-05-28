



CREATE Procedure [dbo].[Tareas_A]
@IdTarea int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@Observaciones ntext,
@TipoTarea int
As 
Insert into [Tareas]
(
 Descripcion,
 Abreviatura,
 Observaciones,
 TipoTarea
)
Values
(
 @Descripcion,
 @Abreviatura,
 @Observaciones,
 @TipoTarea
)
Select @IdTarea=@@identity
Return(@IdTarea)



