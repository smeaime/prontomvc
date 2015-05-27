





CREATE Procedure [dbo].[Revaluos_A]
@IdRevaluo int  output,
@Descripcion varchar(50),
@FechaRevaluo datetime
As 
Insert into [Revaluos]
(
 Descripcion,
 FechaRevaluo
)
Values
(
 @Descripcion,
 @FechaRevaluo
)
Select @IdRevaluo=@@identity
Return(@IdRevaluo)






